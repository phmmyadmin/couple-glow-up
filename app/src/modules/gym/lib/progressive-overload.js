/**
 * Advanced Progressive Overload & Analytics Engine
 * - Double Progression model
 * - Stall Detection & Deload calculation
 * - 365-Day Activity Grid Matrix generator
 */

/**
 * Rounds weight to nearest standard barbell plate increment (usually 2.5kg or 1.25kg)
 */
function roundToPlateStep(weight, step = 2.5) {
  return Math.round(weight / step) * step;
}

/**
 * Detects if an athlete has stalled on an exercise over recent sessions
 * A stall is defined as 3 or more consecutive completed sessions without weight/rep increases
 */
export function detectExerciseStall(exerciseHistory = []) {
  if (!Array.isArray(exerciseHistory) || exerciseHistory.length < 3) {
    return {
      isStalled: false,
      stalledSessionsCount: 0,
      recommendation: null,
      deloadSuggestion: null,
    };
  }

  // Get top working set from the last 3 sessions
  const topSets = exerciseHistory.slice(0, 3).map((session) => {
    const sets = session.sets || [];
    if (sets.length === 0) return { weight: 0, reps: 0, rpe: 0 };
    // Sort by weight descending, then reps descending
    const sorted = [...sets].sort((a, b) => (b.weight_kg || 0) - (a.weight_kg || 0) || (b.reps || 0) - (a.reps || 0));
    return {
      weight: sorted[0]?.weight_kg || 0,
      reps: sorted[0]?.reps || 0,
      rpe: sorted[0]?.rpe || 8.0,
    };
  });

  const [s1, s2, s3] = topSets; // s1 is most recent

  // Check if weight and reps are identical or decreasing across 3 sessions
  const isNoProgress =
    s1.weight <= s2.weight &&
    s1.reps <= s2.reps &&
    s2.weight <= s3.weight &&
    s2.reps <= s3.reps;

  if (isNoProgress && s1.weight > 0) {
    // Deload suggestion: 10% reduction in weight, reset reps
    const targetDeloadWeight = roundToPlateStep(s1.weight * 0.9);
    return {
      isStalled: true,
      stalledSessionsCount: 3,
      recommendation: 'Plateau Detected. Take a 1-week deload to dissipate accumulated central fatigue.',
      deloadSuggestion: {
        targetWeight: targetDeloadWeight,
        reductionPercent: 10,
        originalWeight: s1.weight,
        targetReps: s1.reps,
      },
    };
  }

  return {
    isStalled: false,
    stalledSessionsCount: 0,
    recommendation: null,
    deloadSuggestion: null,
  };
}

/**
 * Generates an annual 52-week activity grid matrix (GitHub style)
 * for visualizing consistency, workouts per day, and volume intensity.
 */
export function generateAnnualActivityMatrix(workouts = [], referenceDate = new Date()) {
  const days = [];
  const oneDayMs = 24 * 60 * 60 * 1000;

  // Build 365 days leading up to referenceDate
  const ref = new Date(referenceDate);
  ref.setHours(23, 59, 59, 999);

  // Group workouts by YYYY-MM-DD
  const workoutsByDay = new Map();
  for (const w of workouts) {
    const dStr = (w.created_at || '').slice(0, 10);
    if (dStr) {
      const existing = workoutsByDay.get(dStr) || { count: 0, duration: 0 };
      existing.count += 1;
      existing.duration += w.duration_seconds || 0;
      workoutsByDay.set(dStr, existing);
    }
  }

  // Generate 52 weeks (approx 364-371 days)
  const totalDays = 52 * 7;
  for (let i = totalDays - 1; i >= 0; i--) {
    const d = new Date(ref.getTime() - i * oneDayMs);
    const dateStr = d.toISOString().slice(0, 10);
    const data = workoutsByDay.get(dateStr) || { count: 0, duration: 0 };

    // Level 0: 0 workouts
    // Level 1: 1 workout < 45 min
    // Level 2: 1 workout >= 45 min
    // Level 3: 2+ workouts or > 75 min
    let level = 0;
    if (data.count > 0) {
      if (data.count >= 2 || data.duration >= 4500) level = 3;
      else if (data.duration >= 2700) level = 2;
      else level = 1;
    }

    days.push({
      date: dateStr,
      dayOfWeek: d.getDay(),
      count: data.count,
      durationSeconds: data.duration,
      level,
    });
  }

  return {
    totalWeeks: 53,
    totalWorkouts: workouts.length,
    days,
  };
}

/**
 * Calculates current streak, active training days, and volume metrics
 */
export function calculateStreakMetrics(workouts = [], referenceDate = new Date()) {
  const workoutDates = new Set();
  let totalMinutes = 0;

  for (const w of workouts) {
    const rawDate = w.started_at || w.created_at || '';
    const dStr = rawDate.slice(0, 10);
    if (dStr) workoutDates.add(dStr);

    const dur = w.duration_minutes || Math.round((w.duration_seconds || 0) / 60) || 0;
    totalMinutes += dur;
  }

  const sortedDates = Array.from(workoutDates).sort().reverse();
  const activeDaysCount = sortedDates.length;

  const oneDayMs = 24 * 60 * 60 * 1000;
  const ref = new Date(referenceDate);
  const todayStr = ref.toISOString().slice(0, 10);
  const yesterdayStr = new Date(ref.getTime() - oneDayMs).toISOString().slice(0, 10);

  let currentStreak = 0;
  let checkDate = null;

  if (workoutDates.has(todayStr)) {
    checkDate = new Date(ref);
  } else if (workoutDates.has(yesterdayStr)) {
    checkDate = new Date(ref.getTime() - oneDayMs);
  }

  if (checkDate) {
    while (true) {
      const dStr = checkDate.toISOString().slice(0, 10);
      if (workoutDates.has(dStr)) {
        currentStreak++;
        checkDate = new Date(checkDate.getTime() - oneDayMs);
      } else {
        break;
      }
    }
  }

  const dayOfWeek = ref.getDay();
  const daysSinceMonday = dayOfWeek === 0 ? 6 : dayOfWeek - 1;
  const mondayMs = ref.getTime() - daysSinceMonday * oneDayMs;
  let workoutsThisWeek = 0;

  for (const w of workouts) {
    const wMs = new Date(w.started_at || w.created_at || 0).getTime();
    if (wMs >= mondayMs) {
      workoutsThisWeek++;
    }
  }

  return {
    totalWorkouts: workouts.length,
    activeDaysCount,
    currentStreak,
    workoutsThisWeek,
    totalMinutesTrained: totalMinutes,
  };
}
