import { describe, it, expect, beforeEach, vi } from 'vitest';
import {
  calculateStepCalories,
  calculateStepDistanceKm,
  getStepData,
  saveManualSteps,
  getStepProgressPercent,
} from '../../lib/health-connect';

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

describe('Health Connect & Steps Integration', () => {
  beforeEach(() => {
    localStorage.clear();
  });

  describe('Step Calculations', () => {
    it('calculates calories burned for 10,000 steps with 70kg weight', () => {
      const cals = calculateStepCalories(10000, 70);
      // 10,000 steps * 0.04 kcal = ~350 - 450 kcal
      expect(cals).toBeGreaterThanOrEqual(300);
      expect(cals).toBeLessThanOrEqual(500);
    });

    it('returns 0 calories for 0 steps', () => {
      expect(calculateStepCalories(0, 70)).toBe(0);
      expect(calculateStepCalories(-100, 70)).toBe(0);
    });

    it('calculates walking distance in km based on height and steps', () => {
      // 10,000 steps with 175cm height (~0.72m stride) -> ~7.2 km
      const km = calculateStepDistanceKm(10000, 175);
      expect(km).toBeCloseTo(7.26, 1);
    });

    it('calculates step goal progress percentage capped at reasonable values', () => {
      expect(getStepProgressPercent(5000, 10000)).toBe(50);
      expect(getStepProgressPercent(10000, 10000)).toBe(100);
      expect(getStepProgressPercent(15000, 10000)).toBe(150);
      expect(getStepProgressPercent(0, 10000)).toBe(0);
    });
  });

  describe('Storage & Web Fallback', () => {
    it('saves and retrieves daily steps from local storage when on web', async () => {
      const date = '2026-08-27';
      await saveManualSteps(date, 8500, 'user_123');

      const data = await getStepData(date, 'user_123');
      expect(data.steps).toBe(8500);
      expect(data.source).toBe('local');
      expect(data.date).toBe(date);
    });

    it('returns default 0 steps for an unlogged day', async () => {
      const data = await getStepData('2026-01-01', 'user_123');
      expect(data.steps).toBe(0);
    });
  });
});
