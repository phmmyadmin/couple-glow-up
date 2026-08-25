import { describe, it, expect } from 'vitest';
import {
  calculate1RM,
  doesSetMatchExercise,
  getLastPerformanceForExercise,
  getSmartOverloadRecommendation,
  formatExerciseName,
  estimateWorkoutCalories,
} from '../../modules/gym/lib/supabase-gym';

describe('Gym Module Integration & Progressive Overload Flows', () => {
  describe('1RM Epley Calculations', () => {
    it('calculates 1RM accurately for standard single rep and multi-rep sets', () => {
      // 1 rep of 100kg = 100kg 1RM
      expect(calculate1RM(100, 1)).toBe(100);

      // 10 reps of 100kg = 100 * (1 + 10/30) = 133.33 -> ~133.3kg
      expect(calculate1RM(100, 10)).toBeCloseTo(133.33, 1);

      // 5 reps of 80kg = 80 * (1 + 5/30) = 93.33 -> ~93.3kg
      expect(calculate1RM(80, 5)).toBeCloseTo(93.33, 1);
    });

    it('handles zero or invalid weight/reps gracefully', () => {
      expect(calculate1RM(0, 10)).toBe(0);
      expect(calculate1RM(100, 0)).toBe(0);
      expect(calculate1RM(null, 5)).toBe(0);
    });
  });

  describe('Exercise Matching & Catalog Resolution (Cross-language & Equipment checks)', () => {
    const mockCatalog = [
      { id: 'ex-bench-bb', name: 'Barbell Bench Press', name_es: 'Press de Banca con Barra', equipment_category: 'barbell' },
      { id: 'ex-bench-db', name: 'Dumbbell Bench Press', name_es: 'Press de Banca con Mancuernas', equipment_category: 'dumbbell' },
      { id: 'ex-incline-bb', name: 'Incline Barbell Bench Press', name_es: 'Press Inclinado con Barra', equipment_category: 'barbell' },
      { id: 'ex-squat', name: 'Barbell Squat', name_es: 'Sentadilla con Barra', equipment_category: 'barbell' },
    ];

    it('matches exact catalog IDs', () => {
      const set = { exercise_id: 'ex-bench-bb', weight_kg: 80, reps: 8 };
      const target = { id: 'ex-bench-bb', name: 'Barbell Bench Press' };
      expect(doesSetMatchExercise(set, target, mockCatalog)).toBe(true);
    });

    it('strictly separates distinct exercises with different catalog IDs', () => {
      const set = { exercise_id: 'ex-bench-bb', weight_kg: 80, reps: 8 };
      const target = { id: 'ex-bench-db', name: 'Dumbbell Bench Press' };
      expect(doesSetMatchExercise(set, target, mockCatalog)).toBe(false);
    });

    it('distinguishes equipment conflict (Barbell vs Dumbbell)', () => {
      const set = { name: 'Dumbbell Bench Press', equipment_category: 'dumbbell' };
      const target = { name: 'Barbell Bench Press', equipment_category: 'barbell' };
      expect(doesSetMatchExercise(set, target, mockCatalog)).toBe(false);
    });

    it('distinguishes movement angle conflict (Incline vs Flat)', () => {
      const set = { name: 'Incline Bench Press', equipment_category: 'barbell' };
      const target = { name: 'Flat Bench Press', equipment_category: 'barbell' };
      expect(doesSetMatchExercise(set, target, mockCatalog)).toBe(false);
    });

    it('matches Spanish exercise names to English target catalog', () => {
      const set = { name: 'press de banca', exercises: { name: 'Press de Banca con Barra' } };
      const target = { id: 'ex-bench-bb', name: 'Barbell Bench Press' };
      expect(doesSetMatchExercise(set, target, mockCatalog)).toBe(true);
    });
  });

  describe('Historical Performance & Progressive Overload Recommendations', () => {
    const targetExercise = { id: 'ex-bench', name: 'Barbell Bench Press', exercise_type: 'weight_reps' };
    const mockWorkouts = [
      {
        id: 'w-1',
        name: 'Push Day 1 (Old)',
        started_at: '2026-08-10T10:00:00Z',
        workout_sets: [
          { exercise_id: 'ex-bench', set_number: 1, weight_kg: 80, reps: 10, is_completed: true },
          { exercise_id: 'ex-bench', set_number: 2, weight_kg: 80, reps: 10, is_completed: true },
        ],
      },
      {
        id: 'w-2',
        name: 'Push Day 2 (Recent)',
        started_at: '2026-08-20T10:00:00Z',
        workout_sets: [
          { exercise_id: 'ex-bench', set_number: 1, weight_kg: 85, reps: 8, is_completed: true },
          { exercise_id: 'ex-bench', set_number: 2, weight_kg: 85, reps: 8, is_completed: true },
          { exercise_id: 'ex-bench', set_number: 3, weight_kg: 85, reps: 7, is_completed: true },
        ],
      },
    ];

    it('finds the latest performance from the most recent workout', () => {
      const lastPerf = getLastPerformanceForExercise(targetExercise, mockWorkouts);
      expect(lastPerf).not.toBeNull();
      expect(lastPerf.workoutName).toBe('Push Day 2 (Recent)');
      expect(lastPerf.sets).toHaveLength(3);
      expect(lastPerf.topSet.weight_kg).toBe(85);
      expect(lastPerf.topSet.reps).toBe(8);
    });

    it('generates a progressive overload recommendation from previous performance', () => {
      const lastPerf = getLastPerformanceForExercise(targetExercise, mockWorkouts);
      const rec = getSmartOverloadRecommendation(targetExercise, lastPerf);
      expect(rec).not.toBeNull();
      expect(rec.title).toBeDefined();
      expect(rec.detail).toBeDefined();
      expect(rec.targetSet1).toBeDefined();
      expect(rec.targetSet1.weight_kg).toBeGreaterThanOrEqual(85);
    });

    it('returns null when no previous performance exists', () => {
      const unusedExercise = { id: 'ex-cable-fly', name: 'Cable Fly' };
      const lastPerf = getLastPerformanceForExercise(unusedExercise, mockWorkouts);
      expect(lastPerf).toBeNull();
    });
  });

  describe('Workout Calories Estimation', () => {
    it('estimates calories burned based on duration, weight, and completed sets', () => {
      const completedSets = [
        { weight_kg: 100, reps: 8, is_completed: true },
        { weight_kg: 100, reps: 8, is_completed: true },
        { weight_kg: 100, reps: 8, is_completed: true },
      ];
      const cals = estimateWorkoutCalories(60, 75, completedSets);
      expect(cals).toBeGreaterThan(200);
      expect(cals).toBeLessThan(600);
    });
  });

  describe('Exercise Name Formatting', () => {
    it('formats raw names cleanly with proper capitalization and Spanish mapping', () => {
      expect(formatExerciseName('press militar')).toContain('Overhead');
      expect(formatExerciseName('elevaciones laterales')).toContain('Lateral');
      expect(formatExerciseName('Custom Exercise')).toBe('Custom Exercise');
    });
  });
});
