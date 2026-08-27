import { describe, it, expect } from 'vitest';
import {
  detectExerciseStall,
  generateAnnualActivityMatrix,
} from '../../modules/gym/lib/progressive-overload';

describe('Advanced Gym Analytics (Stall Detection, Smart Deload & 365-Day Heatmap)', () => {
  describe('Stall Detection & Deload Engine', () => {
    it('detects no stall when user is progressing normally', () => {
      // 3 sessions with increasing weight/reps
      const history = [
        { sets: [{ weight_kg: 85, reps: 8, rpe: 8 }] },
        { sets: [{ weight_kg: 82.5, reps: 8, rpe: 8 }] },
        { sets: [{ weight_kg: 80, reps: 8, rpe: 8 }] },
      ];

      const result = detectExerciseStall(history);
      expect(result.isStalled).toBe(false);
      expect(result.recommendation).toBeNull();
    });

    it('detects a stall when 3 consecutive sessions fail to progress', () => {
      // 3 sessions stuck at 80kg x 8 reps with high effort
      const history = [
        { sets: [{ weight_kg: 80, reps: 8, rpe: 9.5 }] },
        { sets: [{ weight_kg: 80, reps: 8, rpe: 9.5 }] },
        { sets: [{ weight_kg: 80, reps: 8, rpe: 10.0 }] },
      ];

      const result = detectExerciseStall(history);
      expect(result.isStalled).toBe(true);
      expect(result.stalledSessionsCount).toBe(3);
      expect(result.deloadSuggestion).toBeDefined();
      expect(result.deloadSuggestion.targetWeight).toBe(72.5); // ~10% deload from 80kg (rounded to 2.5kg)
    });

    it('requires at least 3 sessions to evaluate a stall', () => {
      const shortHistory = [
        { sets: [{ weight_kg: 80, reps: 8 }] },
        { sets: [{ weight_kg: 80, reps: 8 }] },
      ];

      const result = detectExerciseStall(shortHistory);
      expect(result.isStalled).toBe(false);
    });
  });

  describe('365-Day Activity Grid Matrix', () => {
    it('generates a 52-week activity dataset with intensity levels', () => {
      const mockWorkouts = [
        { created_at: '2026-08-25T10:00:00Z', duration_seconds: 3600 },
        { created_at: '2026-08-26T10:00:00Z', duration_seconds: 4200 },
      ];

      const matrix = generateAnnualActivityMatrix(mockWorkouts, new Date('2026-08-27T00:00:00Z'));
      expect(matrix.totalWorkouts).toBe(2);
      expect(matrix.totalWeeks).toBe(53);
      expect(matrix.days).toBeDefined();

      // Find the logged days in matrix
      const aug25 = matrix.days.find((d) => d.date === '2026-08-25');
      expect(aug25).toBeDefined();
      expect(aug25.count).toBe(1);
      expect(aug25.level).toBeGreaterThan(0);
    });
  });
});
