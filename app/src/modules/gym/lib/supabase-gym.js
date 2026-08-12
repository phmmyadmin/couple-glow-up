import { supabase } from '../../../lib/supabase';

// ── EXERCISES ──
export async function fetchExercisesFromSupabase() {
  if (!supabase) return [];
  try {
    const { data, error } = await supabase
      .from('exercises')
      .select('*')
      .order('name', { ascending: true });
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

    // 3. Insert sets and join exercises relation
    const { data: setData, error: setErr } = await supabase
      .from('workout_sets')
      .insert(formattedSets)
      .select('*, exercises(*)');

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

/**
 * Evaluate and save PRs for all sets in a just-completed workout.
 *
 * Rules:
 *  1. If this is the FIRST TIME a profile has ever done an exercise → skip PR entirely.
 *  2. Each exercise can only generate ONE PR per workout save (dedup across sets).
 *  3. A PR is only recorded if the new value strictly beats the existing record.
 *
 * @param {string} profileId
 * @param {Array}  sets  - flat array of {exercise_id, weight_kg, reps, duration_seconds}
 * @param {string} workoutId  - the workout that was just saved
 * @returns {Array} array of newly created PR objects
 */
export async function evaluateAndSavePRs(profileId, sets, workoutId) {
  if (!supabase || !profileId || !sets.length) return [];

  // 1. Group sets by exercise_id to find best value per exercise this session
  const bestPerExercise = {};
  for (const s of sets) {
    const exId = s.exercise_id;
    if (!exId) continue;

    const est1rm = calculate1RM(s.weight_kg, s.reps);
    const existing = bestPerExercise[exId];

    if (!existing || est1rm > existing.est1rm) {
      bestPerExercise[exId] = {
        exercise_id: exId,
        weight_kg: s.weight_kg,
        reps: s.reps,
        duration_seconds: s.duration_seconds,
        est1rm,
      };
    }
  }

  const exerciseIds = Object.keys(bestPerExercise);
  if (!exerciseIds.length) return [];

  // 2. Count how many PREVIOUS workouts (not the current one) included each exercise
  //    to detect "first time ever" attempts
  const { data: previousSets } = await supabase
    .from('workout_sets')
    .select('exercise_id, workout_id')
    .eq('workouts.profile_id', profileId)
    .in('exercise_id', exerciseIds)
    .neq('workout_id', workoutId);

  const previousExerciseIds = new Set((previousSets || []).map((s) => s.exercise_id));

  // 3. Fetch existing PRs for this profile
  const { data: existingPRs } = await supabase
    .from('personal_records')
    .select('*')
    .eq('profile_id', profileId)
    .in('exercise_id', exerciseIds);

  const existingPRMap = {};
  for (const pr of existingPRs || []) {
    const key = `${pr.exercise_id}__${pr.record_type}`;
    existingPRMap[key] = pr;
  }

  // 4. Determine which exercises beat their PR
  const newPRs = [];
  for (const exId of exerciseIds) {
    // RULE 1: Skip first-ever attempt (no previous sets for this exercise)
    if (!previousExerciseIds.has(exId)) continue;

    const best = bestPerExercise[exId];

    // Check 1RM PR
    if (best.weight_kg && best.reps) {
      const recordType = 'estimated_1rm';
      const key = `${exId}__${recordType}`;
      const existing = existingPRMap[key];

      if (!existing || best.est1rm > existing.value) {
        newPRs.push({
          profile_id: profileId,
          exercise_id: exId,
          record_type: recordType,
          value: best.est1rm,
          workout_id: workoutId,
          achieved_at: new Date().toISOString(),
        });
      }
    }

    // Check max weight PR
    if (best.weight_kg) {
      const recordType = 'max_weight';
      const key = `${exId}__${recordType}`;
      const existing = existingPRMap[key];

      if (!existing || best.weight_kg > existing.value) {
        newPRs.push({
          profile_id: profileId,
          exercise_id: exId,
          record_type: recordType,
          value: best.weight_kg,
          workout_id: workoutId,
          achieved_at: new Date().toISOString(),
        });
      }
    }

    // Check max duration PR
    if (best.duration_seconds) {
      const recordType = 'max_duration';
      const key = `${exId}__${recordType}`;
      const existing = existingPRMap[key];

      if (!existing || best.duration_seconds > existing.value) {
        newPRs.push({
          profile_id: profileId,
          exercise_id: exId,
          record_type: recordType,
          value: best.duration_seconds,
          workout_id: workoutId,
          achieved_at: new Date().toISOString(),
        });
      }
    }
  }

  if (!newPRs.length) return [];

  // 5. Upsert (on conflict = profile_id + exercise_id + record_type → update)
  const { data: saved, error } = await supabase
    .from('personal_records')
    .upsert(newPRs, { onConflict: 'profile_id,exercise_id,record_type' })
    .select('*, exercises(*)');

  if (error) {
    console.error('Error saving PRs:', error);
    return [];
  }

  return saved || [];
}

// ── 1RM EPLEY HELPER ──
export function calculate1RM(weight, reps) {
  if (!weight || !reps || weight <= 0 || reps <= 0) return 0;
  if (reps === 1) return weight;
  // Epley formula: 1RM = weight * (1 + reps / 30)
  return Math.round(weight * (1 + reps / 30) * 100) / 100;
}
