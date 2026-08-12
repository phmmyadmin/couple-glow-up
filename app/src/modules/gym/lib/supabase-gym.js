import { supabase } from '../../../lib/supabase';

// ── EXERCISES ──
export async function fetchExercisesFromSupabase() {
  if (!supabase) return [];
  try {
    const { data, error } = await supabase
      .from('exercises')
      .select('*')
      .order('name_es', { ascending: true });
    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error('Error fetching exercises:', err);
    return [];
  }
}

export async function saveExerciseToSupabase(exercise) {
  if (!supabase) return null;
  try {
    const { data, error } = await supabase
      .from('exercises')
      .insert(exercise)
      .select()
      .single();
    if (error) throw error;
    return data;
  } catch (err) {
    console.error('Error saving exercise:', err);
    return null;
  }
}

// ── ROUTINES ──
export async function fetchRoutinesFromSupabase(profileId) {
  if (!supabase || !profileId) return [];
  try {
    const { data, error } = await supabase
      .from('routines')
      .select('*')
      .eq('profile_id', profileId)
      .order('created_at', { ascending: false });
    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error('Error fetching routines:', err);
    return [];
  }
}

export async function saveRoutineToSupabase(routine) {
  if (!supabase) return null;
  try {
    if (routine.id) {
      const { data, error } = await supabase
        .from('routines')
        .update(routine)
        .eq('id', routine.id)
        .select()
        .single();
      if (error) throw error;
      return data;
    } else {
      const { data, error } = await supabase
        .from('routines')
        .insert(routine)
        .select()
        .single();
      if (error) throw error;
      return data;
    }
  } catch (err) {
    console.error('Error saving routine:', err);
    return null;
  }
}

export async function deleteRoutineFromSupabase(routineId) {
  if (!supabase) return false;
  try {
    const { error } = await supabase.from('routines').delete().eq('id', routineId);
    if (error) throw error;
    return true;
  } catch (err) {
    console.error('Error deleting routine:', err);
    return false;
  }
}

// ── WORKOUTS & SETS ──
export async function fetchWorkoutsFromSupabase(profileId) {
  if (!supabase || !profileId) return [];
  try {
    const { data, error } = await supabase
      .from('workouts')
      .select('*, workout_sets(*, exercises(*))')
      .eq('profile_id', profileId)
      .order('started_at', { ascending: false });
    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error('Error fetching workouts:', err);
    return [];
  }
}

export async function saveWorkoutSessionToSupabase(workoutObj, sets) {
  if (!supabase) return null;
  try {
    // 1. Save workout session record
    const { data: workoutData, error: workoutErr } = await supabase
      .from('workouts')
      .insert(workoutObj)
      .select()
      .single();

    if (workoutErr) throw workoutErr;

    // 2. Prepare sets with workout_id
    const formattedSets = sets.map((s, idx) => ({
      workout_id: workoutData.id,
      exercise_id: s.exercise_id,
      set_index: idx,
      indicator: s.indicator || 'normal',
      weight_kg: s.weight_kg !== undefined ? parseFloat(s.weight_kg) : null,
      reps: s.reps !== undefined ? parseInt(s.reps, 10) : null,
      duration_seconds: s.duration_seconds !== undefined ? parseInt(s.duration_seconds, 10) : null,
      distance_meters: s.distance_meters !== undefined ? parseFloat(s.distance_meters) : null,
      rpe: s.rpe ? parseFloat(s.rpe) : null,
      superset_id: s.superset_id || null,
      prs: s.prs || [],
    }));

    // 3. Insert sets
    const { data: setData, error: setErr } = await supabase
      .from('workout_sets')
      .insert(formattedSets)
      .select();

    if (setErr) throw setErr;

    return { ...workoutData, workout_sets: setData };
  } catch (err) {
    console.error('Error saving workout session:', err);
    return null;
  }
}

export async function deleteWorkoutFromSupabase(workoutId) {
  if (!supabase || !workoutId) return false;
  try {
    const { error } = await supabase.from('workouts').delete().eq('id', workoutId);
    if (error) throw error;
    return true;
  } catch (err) {
    console.error('Error deleting workout:', err);
    return false;
  }
}

export async function updateWorkoutInSupabase(workoutId, updates) {
  if (!supabase || !workoutId) return null;
  try {
    const { data, error } = await supabase
      .from('workouts')
      .update(updates)
      .eq('id', workoutId)
      .select()
      .single();
    if (error) throw error;
    return data;
  } catch (err) {
    console.error('Error updating workout:', err);
    return null;
  }
}

// ── PERSONAL RECORDS ──
export async function fetchPersonalRecordsFromSupabase(profileId) {
  if (!supabase || !profileId) return [];
  try {
    const { data, error } = await supabase
      .from('personal_records')
      .select('*, exercises(*)')
      .eq('profile_id', profileId)
      .order('achieved_at', { ascending: false });
    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error('Error fetching personal records:', err);
    return [];
  }
}

// ── 1RM EPLEY HELPER ──
export function calculate1RM(weight, reps) {
  if (!weight || !reps || weight <= 0 || reps <= 0) return 0;
  if (reps === 1) return weight;
  // Epley formula: 1RM = weight * (1 + reps / 30)
  return Math.round(weight * (1 + reps / 30) * 100) / 100;
}
