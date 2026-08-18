import { supabase } from '../../../lib/supabase';

// ── EXERCISES ──
export const DEFAULT_EXERCISES = [
  // ── CHEST ──
  { name: 'Barbell Bench Press', muscle_group: 'chest', other_muscles: ['triceps', 'shoulders'], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Incline Dumbbell Press', muscle_group: 'chest', other_muscles: ['shoulders', 'triceps'], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Cable Chest Flyes', muscle_group: 'chest', other_muscles: ['shoulders'], equipment_category: 'cable', exercise_type: 'weight_reps' },
  { name: 'Dumbbell Chest Flyes', muscle_group: 'chest', other_muscles: ['shoulders'], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Push-ups', muscle_group: 'chest', other_muscles: ['triceps', 'shoulders'], equipment_category: 'bodyweight', exercise_type: 'bodyweight_reps' },
  { name: 'Chest Dip', muscle_group: 'chest', other_muscles: ['triceps', 'shoulders'], equipment_category: 'bodyweight', exercise_type: 'bodyweight_reps' },

  // ── BACK & LATS ──
  { name: 'Lat Pulldown', muscle_group: 'lats', other_muscles: ['biceps', 'upper_back'], equipment_category: 'cable', exercise_type: 'weight_reps' },
  { name: 'Pull-ups', muscle_group: 'lats', other_muscles: ['biceps', 'upper_back'], equipment_category: 'bodyweight', exercise_type: 'bodyweight_reps' },
  { name: 'Bent-Over Barbell Row', muscle_group: 'upper_back', other_muscles: ['lats', 'biceps', 'lower_back'], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Single-Arm Dumbbell Row', muscle_group: 'lats', other_muscles: ['upper_back', 'biceps'], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Seated Cable Row', muscle_group: 'upper_back', other_muscles: ['lats', 'biceps'], equipment_category: 'cable', exercise_type: 'weight_reps' },
  { name: 'T-Bar Row', muscle_group: 'upper_back', other_muscles: ['lats', 'biceps'], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Face Pulls', muscle_group: 'upper_back', other_muscles: ['shoulders'], equipment_category: 'cable', exercise_type: 'weight_reps' },
  { name: 'Deadlift', muscle_group: 'lower_back', other_muscles: ['hamstrings', 'glutes', 'upper_back'], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Hyperextensions (Back Extension)', muscle_group: 'lower_back', other_muscles: ['glutes', 'hamstrings'], equipment_category: 'bodyweight', exercise_type: 'bodyweight_reps' },

  // ── QUADRICEPS ──
  { name: 'Barbell Back Squat', muscle_group: 'quadriceps', other_muscles: ['glutes', 'hamstrings'], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Front Squat', muscle_group: 'quadriceps', other_muscles: ['glutes', 'abdominals'], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Leg Press', muscle_group: 'quadriceps', other_muscles: ['glutes'], equipment_category: 'machine', exercise_type: 'weight_reps' },
  { name: 'Leg Extensions', muscle_group: 'quadriceps', other_muscles: [], equipment_category: 'machine', exercise_type: 'weight_reps' },
  { name: 'Goblet Squat', muscle_group: 'quadriceps', other_muscles: ['glutes'], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Bulgarian Split Squat', muscle_group: 'quadriceps', other_muscles: ['glutes', 'hamstrings'], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Walking Lunges', muscle_group: 'quadriceps', other_muscles: ['glutes', 'hamstrings'], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },

  // ── HAMSTRINGS ──
  { name: 'Romanian Deadlift (RDL)', muscle_group: 'hamstrings', other_muscles: ['glutes', 'lower_back'], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Dumbbell Romanian Deadlift', muscle_group: 'hamstrings', other_muscles: ['glutes', 'lower_back'], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Seated Leg Curl', muscle_group: 'hamstrings', other_muscles: [], equipment_category: 'machine', exercise_type: 'weight_reps' },
  { name: 'Lying Leg Curl', muscle_group: 'hamstrings', other_muscles: [], equipment_category: 'machine', exercise_type: 'weight_reps' },

  // ── GLUTES ──
  { name: 'Barbell Hip Thrust', muscle_group: 'glutes', other_muscles: ['hamstrings'], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Hip Abduction (Machine)', muscle_group: 'glutes', other_muscles: [], equipment_category: 'machine', exercise_type: 'weight_reps' },
  { name: 'Hip Adduction (Machine)', muscle_group: 'glutes', other_muscles: [], equipment_category: 'machine', exercise_type: 'weight_reps' },
  { name: 'Cable Kickbacks', muscle_group: 'glutes', other_muscles: [], equipment_category: 'cable', exercise_type: 'weight_reps' },
  { name: 'Glute Bridge', muscle_group: 'glutes', other_muscles: ['hamstrings'], equipment_category: 'bodyweight', exercise_type: 'bodyweight_reps' },

  // ── CALVES ──
  { name: 'Standing Calf Raise', muscle_group: 'calves', other_muscles: [], equipment_category: 'machine', exercise_type: 'weight_reps' },
  { name: 'Seated Calf Raise', muscle_group: 'calves', other_muscles: [], equipment_category: 'machine', exercise_type: 'weight_reps' },

  // ── SHOULDERS ──
  { name: 'Overhead Barbell Press (OHP)', muscle_group: 'shoulders', other_muscles: ['triceps', 'upper_back'], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Dumbbell Shoulder Press', muscle_group: 'shoulders', other_muscles: ['triceps'], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Dumbbell Lateral Raise', muscle_group: 'shoulders', other_muscles: [], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Cable Lateral Raise', muscle_group: 'shoulders', other_muscles: [], equipment_category: 'cable', exercise_type: 'weight_reps' },
  { name: 'Rear Delt Flyes (Reverse Pec Deck)', muscle_group: 'shoulders', other_muscles: ['upper_back'], equipment_category: 'machine', exercise_type: 'weight_reps' },
  { name: 'Dumbbell Front Raise', muscle_group: 'shoulders', other_muscles: ['chest'], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },

  // ── BICEPS ──
  { name: 'Barbell Biceps Curl', muscle_group: 'biceps', other_muscles: ['forearms'], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Dumbbell Hammer Curl', muscle_group: 'biceps', other_muscles: ['forearms'], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Incline Dumbbell Curl', muscle_group: 'biceps', other_muscles: [], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Preacher Curl', muscle_group: 'biceps', other_muscles: [], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Cable Biceps Curl', muscle_group: 'biceps', other_muscles: ['forearms'], equipment_category: 'cable', exercise_type: 'weight_reps' },

  // ── TRICEPS ──
  { name: 'Triceps Rope Pushdown', muscle_group: 'triceps', other_muscles: [], equipment_category: 'cable', exercise_type: 'weight_reps' },
  { name: 'Skull Crushers (Lying Triceps Extension)', muscle_group: 'triceps', other_muscles: [], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Overhead Dumbbell Triceps Extension', muscle_group: 'triceps', other_muscles: [], equipment_category: 'dumbbell', exercise_type: 'weight_reps' },
  { name: 'Bench Dips', muscle_group: 'triceps', other_muscles: ['chest', 'shoulders'], equipment_category: 'bodyweight', exercise_type: 'bodyweight_reps' },

  // ── FOREARMS ──
  { name: 'Wrist Curl', muscle_group: 'forearms', other_muscles: [], equipment_category: 'barbell', exercise_type: 'weight_reps' },
  { name: 'Reverse Wrist Curl', muscle_group: 'forearms', other_muscles: [], equipment_category: 'barbell', exercise_type: 'weight_reps' },

  // ── CORE / ABS ──
  { name: 'Hanging Leg Raise', muscle_group: 'abdominals', other_muscles: ['forearms'], equipment_category: 'bodyweight', exercise_type: 'bodyweight_reps' },
  { name: 'Ab Wheel Rollout', muscle_group: 'abdominals', other_muscles: ['shoulders', 'lower_back'], equipment_category: 'other', exercise_type: 'bodyweight_reps' },
  { name: 'Plank', muscle_group: 'abdominals', other_muscles: ['shoulders', 'lower_back'], equipment_category: 'bodyweight', exercise_type: 'duration_only' },
  { name: 'Cable Woodchopper', muscle_group: 'abdominals', other_muscles: ['shoulders'], equipment_category: 'cable', exercise_type: 'weight_reps' },

  // ── CARDIO ──
  { name: 'Treadmill Running', muscle_group: 'cardio', other_muscles: ['quadriceps', 'calves'], equipment_category: 'machine', exercise_type: 'distance_duration' },
  { name: 'Stationary Cycling', muscle_group: 'cardio', other_muscles: ['quadriceps'], equipment_category: 'machine', exercise_type: 'distance_duration' },
  { name: 'Rowing Machine', muscle_group: 'cardio', other_muscles: ['lats', 'quadriceps'], equipment_category: 'machine', exercise_type: 'distance_duration' },
  { name: 'Jump Rope', muscle_group: 'cardio', other_muscles: ['calves'], equipment_category: 'bodyweight', exercise_type: 'duration_only' },
];

const TRANSLATIONS_MAP = {
  'Sentadilla con barra': { name: 'Barbell Back Squat', muscle: 'quadriceps' },
  'Sentadilla': { name: 'Barbell Back Squat', muscle: 'quadriceps' },
  'Press de banca': { name: 'Barbell Bench Press', muscle: 'chest' },
  'Press de banca con barra': { name: 'Barbell Bench Press', muscle: 'chest' },
  'Peso muerto': { name: 'Deadlift', muscle: 'lower_back' },
  'Peso muerto rumano': { name: 'Romanian Deadlift (RDL)', muscle: 'hamstrings' },
  'Dominadas': { name: 'Pull-ups', muscle: 'lats' },
  'Jalón al pecho': { name: 'Lat Pulldown', muscle: 'lats' },
  'Remo con barra': { name: 'Bent-Over Barbell Row', muscle: 'upper_back' },
  'Remo con mancuerna': { name: 'Single-Arm Dumbbell Row', muscle: 'lats' },
  'Remo gironda': { name: 'Seated Cable Row', muscle: 'upper_back' },
  'Press militar': { name: 'Overhead Barbell Press (OHP)', muscle: 'shoulders' },
  'Elevaciones laterales': { name: 'Dumbbell Lateral Raise', muscle: 'shoulders' },
  'Curll de bíceps': { name: 'Barbell Biceps Curl', muscle: 'biceps' },
  'Curl de bíceps': { name: 'Barbell Biceps Curl', muscle: 'biceps' },
  'Curl martillo': { name: 'Dumbbell Hammer Curl', muscle: 'biceps' },
  'Tríceps en polea': { name: 'Triceps Rope Pushdown', muscle: 'triceps' },
  'Extensión de cuadriceps': { name: 'Leg Extensions', muscle: 'quadriceps' },
  'Extensión de piernas': { name: 'Leg Extensions', muscle: 'quadriceps' },
  'Prensa de piernas': { name: 'Leg Press', muscle: 'quadriceps' },
  'Curl femoral': { name: 'Seated Leg Curl', muscle: 'hamstrings' },
  'Hip thrust': { name: 'Barbell Hip Thrust', muscle: 'glutes' },
  'Gemelos de pie': { name: 'Standing Calf Raise', muscle: 'calves' },
  'Zancadas': { name: 'Walking Lunges', muscle: 'quadriceps' },
  'Fondos en paralelas': { name: 'Chest Dip', muscle: 'chest' },
  'Flexiones': { name: 'Push-ups', muscle: 'chest' },
  'Aperturas con mancuernas': { name: 'Dumbbell Chest Flyes', muscle: 'chest' },
  'Plancha': { name: 'Plank', muscle: 'abdominals' },
};

export const SPANISH_TO_ENGLISH_EXERCISE_MAP = {
  'sentadilla con barra': 'barbell back squat',
  'sentadilla': 'barbell back squat',
  'press de banca': 'barbell bench press',
  'press de banca con barra': 'barbell bench press',
  'peso muerto': 'deadlift',
  'peso muerto rumano': 'romanian deadlift (rdl)',
  'dominadas': 'pull-ups',
  'jalón al pecho': 'lat pulldown',
  'jalon al pecho': 'lat pulldown',
  'remo con barra': 'bent-over barbell row',
  'remo con mancuerna': 'single-arm dumbbell row',
  'remo gironda': 'seated cable row',
  'press militar': 'overhead barbell press (ohp)',
  'elevaciones laterales': 'dumbbell lateral raise',
  'curll de bíceps': 'barbell biceps curl',
  'curl de bíceps': 'barbell biceps curl',
  'curl de biceps': 'barbell biceps curl',
  'curl martillo': 'dumbbell hammer curl',
  'tríceps en polea': 'triceps rope pushdown',
  'triceps en polea': 'triceps rope pushdown',
  'extensión de cuadriceps': 'leg extensions',
  'extensión de piernas': 'leg extensions',
  'prensa de piernas': 'leg press',
  'curl femoral': 'seated leg curl',
  'hip thrust': 'barbell hip thrust',
  'gemelos de pie': 'standing calf raise',
  'zancadas': 'walking lunges',
  'fondos en paralelas': 'chest dip',
  'flexiones': 'push-ups',
  'aperturas con mancuernas': 'dumbbell chest flyes',
  'aperturas (máquina)': 'rear delt flyes (reverse pec deck)',
  'aperturas máquina': 'rear delt flyes (reverse pec deck)',
  'aperturas maquina': 'rear delt flyes (reverse pec deck)',
  'abducción de cadera': 'hip abduction (machine)',
  'abducción de cadera (máquina)': 'hip abduction (machine)',
  'abduccion de cadera': 'hip abduction (machine)',
  'abduccion de cadera (maquina)': 'hip abduction (machine)',
  'abductores': 'hip abduction (machine)',
  'abductor': 'hip abduction (machine)',
  'máquina de abductores': 'hip abduction (machine)',
  'adducción de cadera': 'hip adduction (machine)',
  'adducción de cadera (máquina)': 'hip adduction (machine)',
  'adduccion de cadera': 'hip adduction (machine)',
  'adductores': 'hip adduction (machine)',
  'adductor': 'hip adduction (machine)',
  'hip abduction': 'hip abduction (machine)',
  'hip adduction': 'hip adduction (machine)',
  'squat en smith': 'smith machine squat',
  'sentadilla en smith': 'smith machine squat',
  'sentadilla smith': 'smith machine squat',
  'sentadilla en multipower': 'smith machine squat',
  'sentadilla multipower': 'smith machine squat',
  'multipower squat': 'smith machine squat',
  'smith squat': 'smith machine squat',
  'smith machine squat': 'smith machine squat',
  'prensa': 'leg press',
  'prensa de piernas': 'leg press',
  'extensiones de cuadriceps': 'leg extensions',
  'extension de cuadriceps': 'leg extensions',
  'plancha': 'plank',
};

export function stripExerciseName(name) {
  if (!name || typeof name !== 'string') return '';
  return name
    .toLowerCase()
    .normalize("NFD").replace(/[\u0300-\u036f]/g, "")
    .replace(/\(.*?\)/g, '')
    .replace(/[^\w\s]/g, '')
    .trim();
}

export function doesSetMatchExercise(set, targetExercise, catalogExercises = []) {
  if (!set || !targetExercise) return false;

  const sId = set.exercise_id || set.exercise?.id || set.exercises?.id;
  const tId = targetExercise.id || targetExercise.exercise_id;

  // 1. Direct ID equality
  if (sId && tId && sId === tId) return true;

  // 2. Resolve catalog objects if available
  let setCatalogEx = set.exercise || set.exercises;
  if (!setCatalogEx && sId && Array.isArray(catalogExercises) && catalogExercises.length > 0) {
    setCatalogEx = catalogExercises.find((e) => e.id === sId);
  }

  let targetCatalogEx = targetExercise;
  if (tId && Array.isArray(catalogExercises) && catalogExercises.length > 0) {
    const found = catalogExercises.find((e) => e.id === tId);
    if (found) targetCatalogEx = found;
  }

  // 3. Compare resolved catalog IDs
  if (setCatalogEx?.id && targetCatalogEx?.id && setCatalogEx.id === targetCatalogEx.id) return true;

  // 4. Extract all name variants for set and target
  const extractNames = (obj) => {
    if (!obj) return [];
    const list = [];
    const push = (v) => {
      if (v && typeof v === 'string' && v.trim()) list.push(v.trim());
    };
    push(obj.name);
    push(obj.name_es);
    push(obj.title);
    push(obj.es_title);
    push(obj.exercise_title);
    push(obj.exercise_name);
    if (obj.exercise) {
      push(obj.exercise.name);
      push(obj.exercise.name_es);
      push(obj.exercise.title);
      push(obj.exercise.exercise_name);
    }
    if (obj.exercises) {
      push(obj.exercises.name);
      push(obj.exercises.name_es);
      push(obj.exercises.title);
      push(obj.exercises.exercise_name);
    }
    return list;
  };

  const setNames = extractNames(set).concat(extractNames(setCatalogEx));
  const targetNames = extractNames(targetExercise).concat(extractNames(targetCatalogEx));

  if (setNames.length === 0 || targetNames.length === 0) return false;

  for (const sRaw of setNames) {
    const sLow = sRaw.toLowerCase().trim();
    const sMap = SPANISH_TO_ENGLISH_EXERCISE_MAP[sLow] || sLow;
    const sStrip = stripExerciseName(sMap);

    for (const tRaw of targetNames) {
      const tLow = tRaw.toLowerCase().trim();
      const tMap = SPANISH_TO_ENGLISH_EXERCISE_MAP[tLow] || tLow;
      const tStrip = stripExerciseName(tMap);

      // Direct match
      if (sLow === tLow || sMap === tMap || (sStrip && tStrip && sStrip === tStrip)) {
        return true;
      }

      // Substring fuzzy match
      if (sStrip && tStrip && sStrip.length >= 4 && tStrip.length >= 4) {
        if (sStrip.includes(tStrip) || tStrip.includes(sStrip)) {
          return true;
        }
      }

      // Smith machine / multipower fuzzy match
      const sIsSmith = /smith|multipower/.test(sLow);
      const tIsSmith = /smith|multipower/.test(tLow);
      if (sIsSmith && tIsSmith) {
        const sIsSquat = /squat|sentadilla/.test(sLow);
        const tIsSquat = /squat|sentadilla/.test(tLow);
        if (sIsSquat && tIsSquat) return true;

        const sIsPress = /press/.test(sLow);
        const tIsPress = /press/.test(tLow);
        if (sIsPress && tIsPress) return true;
      }
    }
  }

  return false;
}

export function formatExerciseName(rawName) {
  if (!rawName || typeof rawName !== 'string') return 'Exercise';
  const trimmed = rawName.trim();
  const lower = trimmed.toLowerCase();
  const mapped = SPANISH_TO_ENGLISH_EXERCISE_MAP[lower];
  if (mapped) {
    return mapped
      .split(' ')
      .map((w) => (w.startsWith('(') ? w.toUpperCase() : w.charAt(0).toUpperCase() + w.slice(1)))
      .join(' ');
  }
  return trimmed;
}

export async function fetchExercisesFromSupabase() {
  if (!supabase) return DEFAULT_EXERCISES;
  try {
    let { data, error } = await supabase
      .from('exercises')
      .select('*')
      .order('name', { ascending: true });

    if (error) throw error;

    if (!data || data.length === 0) {
      const { data: seeded } = await supabase.from('exercises').insert(DEFAULT_EXERCISES).select();
      return seeded || DEFAULT_EXERCISES;
    }

    // Auto-update Spanish names or generic muscle groups (legs -> quadriceps, back -> lats/upper_back)
    let needsRefetch = false;
    for (const ex of data) {
      const currentName = ex.name || ex.name_es || '';
      const translation = TRANSLATIONS_MAP[currentName];

      let newName = ex.name;
      let newMuscle = ex.muscle_group;

      if (translation) {
        newName = translation.name;
        newMuscle = translation.muscle;
      } else if (ex.muscle_group === 'legs') {
        const lower = currentName.toLowerCase();
        if (lower.includes('curl') || lower.includes('hamstring') || lower.includes('rdl') || lower.includes('deadlift')) {
          newMuscle = 'hamstrings';
        } else if (lower.includes('hip') || lower.includes('glute') || lower.includes('thrust')) {
          newMuscle = 'glutes';
        } else if (lower.includes('calf') || lower.includes('calves') || lower.includes('raise')) {
          newMuscle = 'calves';
        } else {
          newMuscle = 'quadriceps';
        }
      } else if (ex.muscle_group === 'back') {
        const lower = currentName.toLowerCase();
        if (lower.includes('deadlift') || lower.includes('extension') || lower.includes('lower')) {
          newMuscle = 'lower_back';
        } else if (lower.includes('row') || lower.includes('face') || lower.includes('shrug')) {
          newMuscle = 'upper_back';
        } else {
          newMuscle = 'lats';
        }
      }

      if (newName !== ex.name || newMuscle !== ex.muscle_group) {
        needsRefetch = true;
        await supabase
          .from('exercises')
          .update({ name: newName, name_es: newName, muscle_group: newMuscle })
          .eq('id', ex.id);
      }
    }

    if (needsRefetch) {
      const { data: refetched } = await supabase
        .from('exercises')
        .select('*')
        .order('name', { ascending: true });
      return refetched || data;
    }

    return data || DEFAULT_EXERCISES;
  } catch (err) {
    console.error('Error fetching exercises:', err);
    return DEFAULT_EXERCISES;
  }
}

export async function saveExerciseToSupabase(exercise) {
  if (!supabase) return null;
  try {
    if (exercise.id) {
      const { data, error } = await supabase
        .from('exercises')
        .update(exercise)
        .eq('id', exercise.id)
        .select()
        .single();
      if (error) throw error;
      return data;
    } else {
      const { data, error } = await supabase
        .from('exercises')
        .insert(exercise)
        .select()
        .single();
      if (error) throw error;
      return data;
    }
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
  console.log('🏋️ [SUPABASE GYM] fetchWorkoutsFromSupabase called with profileId:', profileId);
  if (!supabase) {
    console.warn('⚠️ [SUPABASE GYM] Supabase client is NOT initialized!');
    return [];
  }
  try {
    let query = supabase
      .from('workouts')
      .select('*, workout_sets(*, exercises(*))')
      .order('started_at', { ascending: false });

    if (profileId) {
      query = query.or(`profile_id.eq.${profileId},profile_id.is.null`);
    }

    const { data, error } = await query;
    if (error) {
      console.error('❌ [SUPABASE GYM] Error fetching workouts with profile filter:', error);
      const { data: fallbackData, error: fbErr } = await supabase
        .from('workouts')
        .select('*, workout_sets(*, exercises(*))')
        .order('started_at', { ascending: false });
      if (fbErr) console.error('❌ [SUPABASE GYM] Fallback fetch also failed:', fbErr);
      const result = enrichWorkoutList(fallbackData || []);
      console.log(`✅ [SUPABASE GYM] Fallback fetched ${result.length} workouts`);
      return result;
    }

    const result = enrichWorkoutList(data || []);
    console.log(`✅ [SUPABASE GYM] Successfully fetched ${result.length} workouts from Supabase`, {
      sampleWorkout: result[0] ? { name: result[0].name, setsCount: result[0].workout_sets?.length } : 'None'
    });
    return result;
  } catch (err) {
    console.error('💥 [SUPABASE GYM] Exception in fetchWorkoutsFromSupabase:', err);
    return [];
  }
}

function enrichWorkoutList(data) {
  return (data || []).map((w) => {
    const sets = (w.workout_sets || []).map((s) => {
      const exObj = s.exercises || s.exercise || {
        name: s.exercise_name || s.name || 'Exercise',
      };
      return {
        ...s,
        exercise: exObj,
        exercises: exObj,
        exercise_name: exObj?.name || exObj?.name_es || s.exercise_name || 'Exercise',
      };
    });
    return { ...w, name: w.name || 'Workout', workout_sets: sets };
  });
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

    // 2. Prepare sets with valid exercise_id (UUID check)
    const formattedSets = sets.map((s, idx) => {
      const exObj = s.exercise || s.exercises;
      const rawId = s.exercise_id || exObj?.id;
      const isUUID = rawId && typeof rawId === 'string' && rawId.length >= 30 && !rawId.startsWith('ex-');

      return {
        workout_id: workoutData.id,
        exercise_id: isUUID ? rawId : null,
        set_index: idx,
        indicator: s.indicator || 'normal',
        weight_kg: s.weight_kg !== undefined && s.weight_kg !== '' ? parseFloat(s.weight_kg) : null,
        reps: s.reps !== undefined && s.reps !== '' ? parseInt(s.reps, 10) : null,
        duration_seconds: s.duration_seconds !== undefined && s.duration_seconds !== '' ? parseInt(s.duration_seconds, 10) : null,
        distance_meters: s.distance_meters !== undefined && s.distance_meters !== '' ? parseFloat(s.distance_meters) : null,
        rpe: s.rpe ? parseFloat(s.rpe) : null,
        superset_id: s.superset_id || null,
        prs: s.prs || [],
      };
    });

    // 3. Insert sets and join exercises relation
    const { data: setData, error: setErr } = await supabase
      .from('workout_sets')
      .insert(formattedSets)
      .select('*, exercises(*)');

    if (setErr) throw setErr;

    const enrichedSets = (setData || []).map((s, idx) => {
      const originalSet = sets[idx];
      const exObj = s.exercises || originalSet?.exercise || originalSet?.exercises || {
        name: originalSet?.exercise_name || originalSet?.name || 'Exercise',
      };
      return {
        ...s,
        exercise: exObj,
        exercises: exObj,
        exercise_name: exObj?.name || exObj?.name_es || originalSet?.exercise_name || 'Exercise',
      };
    });

    return { ...workoutData, workout_sets: enrichedSets };
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
