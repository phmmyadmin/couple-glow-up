/**
 * Data Portability Engine:
 * - Full JSON Backup & Restore
 * - Hevy CSV Importer
 * - Strong CSV Importer
 * - Cardio calculations (Pace & MET Calories)
 */

/**
 * Creates a clean, versioned JSON backup containing all application datasets
 */
export function exportFullAppData(dataContext = {}) {
  const {
    workouts = [],
    exercises = [],
    routines = [],
    personalRecords = [],
    dailyLogs = [],
    weightLogs = [],
    dishes = [],
    shoppingItems = [],
  } = dataContext;

  return {
    version: '1.0',
    appName: 'OpenFit',
    exportDate: new Date().toISOString(),
    data: {
      workouts,
      exercises,
      routines,
      personalRecords,
      dailyLogs,
      weightLogs,
      dishes,
      shoppingItems,
    },
  };
}

/**
 * Validates and safely parses a JSON backup string
 */
export function importFullAppData(jsonString) {
  try {
    if (typeof jsonString !== 'string' || !jsonString.trim()) {
      return { isValid: false, error: 'Empty JSON payload' };
    }

    const parsed = JSON.parse(jsonString);
    if (!parsed || typeof parsed !== 'object' || !parsed.data) {
      return { isValid: false, error: 'Invalid backup structure. Missing "data" container.' };
    }

    return {
      isValid: true,
      version: parsed.version || '1.0',
      exportDate: parsed.exportDate,
      data: parsed.data,
    };
  } catch (err) {
    return { isValid: false, error: err.message || 'JSON parse error' };
  }
}

/**
 * Helper to parse generic CSV lines with support for quoted cells and comma/semicolon separators
 */
function parseCsvRows(csvText, delimiter = ',') {
  const lines = csvText.split(/\r?\n/).filter((l) => l.trim().length > 0);
  if (lines.length === 0) return [];

  // Detect delimiter from first row if semicolon is used
  const actualDelimiter = lines[0].includes(';') && !lines[0].includes(',') ? ';' : delimiter;

  return lines.map((line) => {
    const row = [];
    let insideQuotes = false;
    let currentCell = '';

    for (let i = 0; i < line.length; i++) {
      const char = line[i];
      if (char === '"') {
        insideQuotes = !insideQuotes;
      } else if (char === actualDelimiter && !insideQuotes) {
        row.push(currentCell.trim().replace(/^"|"$/g, ''));
        currentCell = '';
      } else {
        currentCell += char;
      }
    }
    row.push(currentCell.trim().replace(/^"|"$/g, ''));
    return row;
  });
}

/**
 * Matches an exercise name from an external app to our internal exercise catalog
 */
function matchExercise(rawName, existingExercises = []) {
  if (!rawName) return null;
  const cleanRaw = rawName.toLowerCase().replace(/[\(\)\[\]\-]/g, ' ').replace(/\s+/g, ' ').trim();

  // 1. Direct or partial match in existing catalog
  const found = existingExercises.find((ex) => {
    const exClean = ex.name.toLowerCase().replace(/[\(\)\[\]\-]/g, ' ').replace(/\s+/g, ' ').trim();
    return exClean === cleanRaw || exClean.includes(cleanRaw) || cleanRaw.includes(exClean);
  });

  if (found) return found;

  // 2. Fallback: synthesize an exercise object
  return {
    id: `imported-${Date.now()}-${Math.random().toString(36).slice(2, 7)}`,
    name: rawName,
    muscle_group: 'other',
    equipment: 'other',
  };
}

/**
 * Parses Hevy CSV export text
 * Expected format columns:
 * Date, Workout Name, Exercise Name, Set Order, Weight, Weight Unit, Reps, RPE, Distance, Distance Unit, Seconds, Notes
 */
export function parseHevyCsv(csvText, existingExercises = []) {
  const rows = parseCsvRows(csvText);
  if (rows.length < 2) return { workouts: [] };

  const header = rows[0].map((h) => h.toLowerCase().trim());
  const dateIdx = header.findIndex((h) => h.includes('date'));
  const workoutNameIdx = header.findIndex((h) => h.includes('workout name') || h.includes('title'));
  const exerciseIdx = header.findIndex((h) => h.includes('exercise'));
  const setOrderIdx = header.findIndex((h) => h.includes('set order') || h.includes('set'));
  const weightIdx = header.findIndex((h) => h.includes('weight'));
  const repsIdx = header.findIndex((h) => h.includes('rep'));
  const rpeIdx = header.findIndex((h) => h.includes('rpe'));
  const distanceIdx = header.findIndex((h) => h.includes('distance'));
  const secondsIdx = header.findIndex((h) => h.includes('second') || h.includes('duration'));
  const notesIdx = header.findIndex((h) => h.includes('note'));

  const workoutsMap = new Map();

  for (let i = 1; i < rows.length; i++) {
    const row = rows[i];
    if (row.length < 3) continue;

    const dateStr = row[dateIdx] || new Date().toISOString();
    const workoutName = row[workoutNameIdx] || 'Imported Workout';
    const exerciseName = row[exerciseIdx] || 'Exercise';
    const setOrder = parseInt(row[setOrderIdx], 10) || 1;
    const weight = parseFloat(row[weightIdx]) || 0;
    const reps = parseInt(row[repsIdx], 10) || 0;
    const rpe = parseFloat(row[rpeIdx]) || null;
    const distance = parseFloat(row[distanceIdx]) || null;
    const durationSeconds = parseInt(row[secondsIdx], 10) || null;
    const notes = row[notesIdx] || '';

    const workoutKey = `${dateStr}__${workoutName}`;
    if (!workoutsMap.has(workoutKey)) {
      workoutsMap.set(workoutKey, {
        id: `hevy-${Date.now()}-${i}`,
        created_at: dateStr,
        workout_name: workoutName,
        duration_seconds: 0,
        notes: '',
        workout_exercises: [],
      });
    }

    const currentWorkout = workoutsMap.get(workoutKey);
    let currentEx = currentWorkout.workout_exercises.find((e) => e.exercise_name === exerciseName);

    if (!currentEx) {
      const matched = matchExercise(exerciseName, existingExercises);
      currentEx = {
        id: `we-${Date.now()}-${Math.random().toString(36).slice(2, 6)}`,
        exercise_id: matched?.id || null,
        exercise_name: exerciseName,
        exercise_media: matched?.media_url || null,
        notes: notes,
        sets: [],
      };
      currentWorkout.workout_exercises.push(currentEx);
    }

    currentEx.sets.push({
      id: `set-${Date.now()}-${Math.random().toString(36).slice(2, 6)}`,
      set_number: setOrder,
      set_type: 'normal',
      weight_kg: weight,
      reps: reps,
      rpe: rpe,
      distance_km: distance,
      duration_seconds: durationSeconds,
      is_completed: true,
    });
  }

  return {
    workouts: Array.from(workoutsMap.values()),
  };
}

/**
 * Parses Strong CSV export text
 */
export function parseStrongCsv(csvText, existingExercises = []) {
  // Strong CSV shares very similar column concepts (often semicolon separated in EU)
  return parseHevyCsv(csvText, existingExercises);
}

/**
 * Calculates cardio pace formatted as 'MM:SS /km'
 */
export function calculateCardioPace(distanceKm, durationSeconds) {
  if (!distanceKm || distanceKm <= 0 || !durationSeconds || durationSeconds <= 0) {
    return '-';
  }

  const secondsPerKm = durationSeconds / distanceKm;
  const minutes = Math.floor(secondsPerKm / 60);
  const seconds = Math.round(secondsPerKm % 60);

  return `${minutes}:${String(seconds).padStart(2, '0')} /km`;
}

/**
 * Estimates cardio calories burned based on distance, duration and bodyweight
 * Uses standard MET running/cycling formula: Calories = MET * Weight(kg) * Time(hours)
 */
export function calculateCardioCalories(distanceKm, durationSeconds, userWeightKg = 70) {
  if (!distanceKm || distanceKm <= 0 || !durationSeconds || durationSeconds <= 0) {
    return 0;
  }

  const hours = durationSeconds / 3600;
  const speedKmH = distanceKm / hours;

  // Approximate MET based on speed (Running: 8-12 km/h ≈ MET 8-11.5)
  let met = 7.0; // Base jogging
  if (speedKmH >= 12) met = 12.5;
  else if (speedKmH >= 10) met = 10.0;
  else if (speedKmH >= 8) met = 8.3;
  else if (speedKmH < 6) met = 4.5; // Walking

  const totalCalories = met * userWeightKg * hours;
  return Math.round(totalCalories);
}
