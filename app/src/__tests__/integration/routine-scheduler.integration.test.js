import { describe, it, expect } from 'vitest';
import {
  DAYS_OF_WEEK,
  getCurrentDayOfWeek,
  getScheduledRoutineForDay,
  getScheduleMapping,
  setScheduleForDay,
  removeScheduleForDay,
} from '../../modules/gym/lib/routine-scheduler';

describe('Weekly Routine Scheduler & Auto-Day Guided Workout', () => {
  it('defines 7 standard days of week in order Monday to Sunday', () => {
    expect(DAYS_OF_WEEK).toHaveLength(7);
    expect(DAYS_OF_WEEK[0]).toBe('Monday');
    expect(DAYS_OF_WEEK[6]).toBe('Sunday');
  });

  it('detects current day of the week accurately', () => {
    const today = getCurrentDayOfWeek();
    expect(DAYS_OF_WEEK).toContain(today);
  });

  it('matches assigned routine for a specific day from schedule mapping', () => {
    const mockRoutines = [
      { id: 'rot-1', name: 'Push Day (Chest & Triceps)', exercises: [1, 2, 3] },
      { id: 'rot-2', name: 'Pull Day (Back & Biceps)', exercises: [4, 5] },
      { id: 'rot-3', name: 'Leg Day (Quads & Glutes)', exercises: [6, 7, 8] },
    ];

    const mockSchedule = {
      Monday: 'rot-1',
      Wednesday: 'rot-2',
      Friday: 'rot-3',
    };

    const mondayRoutine = getScheduledRoutineForDay('Monday', mockSchedule, mockRoutines);
    expect(mondayRoutine).not.toBeNull();
    expect(mondayRoutine.name).toBe('Push Day (Chest & Triceps)');

    const tuesdayRoutine = getScheduledRoutineForDay('Tuesday', mockSchedule, mockRoutines);
    expect(tuesdayRoutine).toBeNull();
  });

  it('updates schedule for a day and preserves other day assignments', () => {
    const initialSchedule = { Monday: 'rot-1' };
    const updated = setScheduleForDay(initialSchedule, 'Wednesday', 'rot-2');

    expect(updated.Monday).toBe('rot-1');
    expect(updated.Wednesday).toBe('rot-2');
  });

  it('removes schedule assignment for a specific day', () => {
    const initialSchedule = { Monday: 'rot-1', Wednesday: 'rot-2' };
    const updated = removeScheduleForDay(initialSchedule, 'Monday');

    expect(updated.Monday).toBeUndefined();
    expect(updated.Wednesday).toBe('rot-2');
  });
});
