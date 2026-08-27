import { describe, it, expect } from 'vitest';
import {
  exportFullAppData,
  importFullAppData,
  parseHevyCsv,
  parseStrongCsv,
  calculateCardioPace,
  calculateCardioCalories,
} from '../../modules/gym/lib/data-importers';

describe('Data Portability Engine (JSON Backup, Hevy & Strong CSV Importers, Cardio)', () => {
  describe('Full JSON Backup & Export / Restore', () => {
    it('creates a complete, versioned JSON backup object', () => {
      const mockPayload = {
        workouts: [{ id: 'w1', name: 'Leg Day' }],
        exercises: [{ id: 'e1', name: 'Squat' }],
        routines: [{ id: 'r1', name: 'PPL' }],
        personalRecords: [{ id: 'pr1', exercise_name: 'Squat', max_weight: 140 }],
        dailyLogs: [{ date: '2026-08-25', intakes: [] }],
        weightLogs: [{ date: '2026-08-25', weight: 75.5 }],
        dishes: [{ id: 'd1', name: 'Meal Prep Rice' }],
      };

      const exported = exportFullAppData(mockPayload);
      expect(exported.version).toBe('1.0');
      expect(exported.exportDate).toBeDefined();
      expect(exported.appName).toBe('OpenFit');
      expect(exported.data.workouts).toHaveLength(1);
      expect(exported.data.exercises).toHaveLength(1);
      expect(exported.data.personalRecords).toHaveLength(1);
    });

    it('validates and safely extracts data from a valid JSON backup', () => {
      const backupJson = JSON.stringify({
        version: '1.0',
        appName: 'OpenFit',
        data: {
          workouts: [{ id: 'w1', name: 'Push Day' }],
          routines: [{ id: 'r1', name: '3-Day Split' }],
        },
      });

      const parsed = importFullAppData(backupJson);
      expect(parsed.isValid).toBe(true);
      expect(parsed.data.workouts).toHaveLength(1);
      expect(parsed.data.workouts[0].name).toBe('Push Day');
    });

    it('rejects invalid or corrupted JSON backup gracefully', () => {
      const invalid = importFullAppData('not a json');
      expect(invalid.isValid).toBe(false);
      expect(invalid.error).toBeDefined();
    });
  });

  describe('Hevy CSV Importer', () => {
    it('parses Hevy CSV workout logs and groups sets into workouts and exercises', () => {
      const hevyCsv = `"Date","Workout Name","Exercise Name","Set Order","Weight","Weight Unit","Reps","RPE","Distance","Distance Unit","Seconds","Notes"
"2026-08-10 18:30:00","Push Day","Bench Press (Barbell)",1,80,"kg",10,8.5,"","","",
"2026-08-10 18:30:00","Push Day","Bench Press (Barbell)",2,85,"kg",8,9.0,"","","",
"2026-08-10 18:30:00","Push Day","Overhead Press (Dumbbell)",1,24,"kg",12,8.0,"","",""
"2026-08-12 19:00:00","Pull Day","Lat Pulldown (Cable)",1,70,"kg",10,8.0,"","",""`;

      const existingExercises = [
        { id: 'ex-bench', name: 'Barbell Bench Press', muscle_group: 'chest' },
        { id: 'ex-ohp', name: 'Dumbbell Shoulder Press', muscle_group: 'shoulders' },
      ];

      const result = parseHevyCsv(hevyCsv, existingExercises);

      expect(result.workouts).toHaveLength(2);

      // Workout 1: Push Day
      const pushWorkout = result.workouts[0];
      expect(pushWorkout.workout_name).toBe('Push Day');
      expect(pushWorkout.workout_exercises).toHaveLength(2);

      // Bench Press sets
      const benchEx = pushWorkout.workout_exercises[0];
      expect(benchEx.sets).toHaveLength(2);
      expect(benchEx.sets[0].weight_kg).toBe(80);
      expect(benchEx.sets[0].reps).toBe(10);
      expect(benchEx.sets[0].rpe).toBe(8.5);

      // Workout 2: Pull Day
      const pullWorkout = result.workouts[1];
      expect(pullWorkout.workout_name).toBe('Pull Day');
      expect(pullWorkout.workout_exercises).toHaveLength(1);
    });
  });

  describe('Strong CSV Importer', () => {
    it('parses Strong CSV format with dates, weights and reps', () => {
      const strongCsv = `Date;Workout Name;Exercise Name;Set Order;Weight;Reps;RPE;Distance;Seconds;Notes
2026-08-14 10:00:00;Legs;Squat (Barbell);1;100;8;8;;;
2026-08-14 10:00:00;Legs;Squat (Barbell);2;100;8;8.5;;;
2026-08-14 10:00:00;Legs;Leg Extension (Machine);1;60;12;9;;;`;

      const result = parseStrongCsv(strongCsv, []);
      expect(result.workouts).toHaveLength(1);
      expect(result.workouts[0].workout_name).toBe('Legs');
      expect(result.workouts[0].workout_exercises).toHaveLength(2);
      expect(result.workouts[0].workout_exercises[0].sets).toHaveLength(2);
      expect(result.workouts[0].workout_exercises[0].sets[0].weight_kg).toBe(100);
    });
  });

  describe('Cardio Mode Calculations', () => {
    it('calculates pace in MM:SS /km format accurately', () => {
      // 5 km in 30 minutes (1800 seconds) -> 6:00 /km
      const pace = calculateCardioPace(5, 1800);
      expect(pace).toBe('6:00 /km');

      // 10 km in 45 minutes (2700 seconds) -> 4:30 /km
      const fastPace = calculateCardioPace(10, 2700);
      expect(fastPace).toBe('4:30 /km');
    });

    it('returns "-" for invalid distance or duration', () => {
      expect(calculateCardioPace(0, 1800)).toBe('-');
      expect(calculateCardioPace(5, 0)).toBe('-');
    });

    it('estimates cardio calories burned using MET formula', () => {
      // 5 km in 30 min (speed = 10 km/h) for a 70 kg person ≈ ~350 kcal
      const calories = calculateCardioCalories(5, 1800, 70);
      expect(calories).toBeGreaterThan(300);
      expect(calories).toBeLessThan(450);
    });
  });
});
