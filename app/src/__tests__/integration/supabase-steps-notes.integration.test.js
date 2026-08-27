import { describe, it, expect, beforeEach, vi } from 'vitest';
import {
  saveDailyStepsToSupabase,
  fetchDailyLogsFromSupabase,
} from '../../lib/supabase';
import {
  saveManualSteps,
  getStepData,
} from '../../lib/health-connect';
import {
  saveWorkoutSessionToSupabase,
  getLastPerformanceForExercise,
} from '../../modules/gym/lib/supabase-gym';

const memoryStore = {};
globalThis.localStorage = {
  getItem: (k) => memoryStore[k] || null,
  setItem: (k, v) => {
    memoryStore[k] = String(v);
  },
  removeItem: (k) => {
    delete memoryStore[k];
  },
  clear: () => {
    Object.keys(memoryStore).forEach((k) => delete memoryStore[k]);
  },
};

describe('Supabase Steps & Exercise Notes Persistence', () => {
  beforeEach(() => {
    localStorage.clear();
  });

  describe('Daily Steps Sync', () => {
    it('saves steps locally and returns step data accurately', async () => {
      const date = '2026-08-27';
      const profileId = 'prof-abc';

      const result = await saveManualSteps(date, 12500, profileId);
      expect(result.steps).toBe(12500);

      const loaded = await getStepData(date, profileId);
      expect(loaded.steps).toBe(12500);
      expect(loaded.date).toBe(date);
    });
  });

  describe('Exercise Notes Persistence', () => {
    it('retrieves notes from previous workout session or cache', () => {
      const exercise = { id: 'ex-bench', name: 'Barbell Bench Press' };
      const workouts = [
        {
          id: 'w-1',
          started_at: '2026-08-20T10:00:00Z',
          workout_sets: [
            {
              exercise_id: 'ex-bench',
              weight_kg: 80,
              reps: 8,
              notes: 'Seat at pin 4, grip slightly wider than shoulder width',
            },
          ],
        },
      ];

      const perf = getLastPerformanceForExercise(exercise, workouts, [exercise]);
      expect(perf).not.toBeNull();
      expect(perf.notes).toBe('Seat at pin 4, grip slightly wider than shoulder width');
    });
  });
});
