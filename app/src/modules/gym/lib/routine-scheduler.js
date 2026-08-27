/**
 * Weekly Routine Schedule & Auto-Day Guided Workout Helper
 */

export const DAYS_OF_WEEK = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const STORAGE_KEY = 'openfit_weekly_routine_schedule';

/**
 * Returns the current day of the week name ('Monday', 'Tuesday', etc.)
 */
export function getCurrentDayOfWeek(date = new Date()) {
  const dayIndex = date.getDay(); // 0 is Sunday, 1 is Monday, ...
  // Map standard JS getDay() to DAYS_OF_WEEK (0 -> Sunday = index 6)
  const adjustedIndex = dayIndex === 0 ? 6 : dayIndex - 1;
  return DAYS_OF_WEEK[adjustedIndex];
}

/**
 * Retrieves the stored schedule mapping from localStorage or profile fallback
 */
export function getScheduleMapping(profileId) {
  try {
    const key = profileId ? `${STORAGE_KEY}_${profileId}` : STORAGE_KEY;
    const raw = localStorage.getItem(key);
    return raw ? JSON.parse(raw) : {};
  } catch {
    return {};
  }
}

/**
 * Saves the schedule mapping to localStorage
 */
export function saveScheduleMapping(mapping, profileId) {
  try {
    const key = profileId ? `${STORAGE_KEY}_${profileId}` : STORAGE_KEY;
    localStorage.setItem(key, JSON.stringify(mapping));
  } catch (e) {
    console.warn('Failed to save schedule mapping:', e);
  }
}

/**
 * Returns the Routine object assigned to a specific day, or null if none
 */
export function getScheduledRoutineForDay(dayName, scheduleMapping, routines = []) {
  if (!dayName || !scheduleMapping || !Array.isArray(routines)) return null;
  const routineId = scheduleMapping[dayName];
  if (!routineId) return null;
  return routines.find((r) => r.id === routineId) || null;
}

/**
 * Assigns a routine ID to a specific day of the week
 */
export function setScheduleForDay(currentSchedule, dayName, routineId) {
  const next = { ...(currentSchedule || {}) };
  if (routineId) {
    next[dayName] = routineId;
  } else {
    delete next[dayName];
  }
  return next;
}

/**
 * Removes assignment for a specific day
 */
export function removeScheduleForDay(currentSchedule, dayName) {
  const next = { ...(currentSchedule || {}) };
  delete next[dayName];
  return next;
}
