import { Capacitor } from '@capacitor/core';
import { saveDailyStepsToSupabase, supabase } from './supabase';

/**
 * Health Connect & Steps Client Bridge
 * Bridges Android Health Connect / Samsung Health native data with React web PWA
 */

export function isNativePlatform() {
  try {
    return Capacitor.isNativePlatform();
  } catch (e) {
    return false;
  }
}

/**
 * Checks if Physical Activity / Health permissions are granted in native Android
 */
export async function checkNativeStepPermissions() {
  if (isNativePlatform() && window?.Capacitor?.Plugins?.HealthConnect) {
    try {
      const res = await window.Capacitor.Plugins.HealthConnect.checkPermissions();
      return res || { granted: false, hasSensor: false };
    } catch (e) {
      console.warn('Error checking native permissions:', e);
    }
  }
  return { granted: true, hasSensor: false };
}

/**
 * Requests Physical Activity / Step permission from Android runtime
 */
export async function requestNativeStepPermissions() {
  if (isNativePlatform() && window?.Capacitor?.Plugins?.HealthConnect) {
    try {
      const res = await window.Capacitor.Plugins.HealthConnect.requestPermissions();
      return res || { granted: false };
    } catch (e) {
      console.warn('Error requesting native permissions:', e);
    }
  }
  return { granted: true };
}

/**
 * Opens Android system settings for app permissions
 */
export async function openNativeHealthSettings() {
  if (isNativePlatform() && window?.Capacitor?.Plugins?.HealthConnect) {
    try {
      await window.Capacitor.Plugins.HealthConnect.openHealthSettings();
    } catch (e) {
      console.warn('Error opening health settings:', e);
    }
  }
}

/**
 * Calculates active walking calories based on step count and user weight
 * Formula: MET walking (~3.5) * weightKg * (steps / steps_per_minute / 60)
 * Average: ~0.00055 kcal per step per kg bodyweight
 */
export function calculateStepCalories(steps, weightKg = 70) {
  const s = parseInt(steps, 10);
  const w = parseFloat(weightKg) || 70;
  if (isNaN(s) || s <= 0) return 0;

  // Approx 0.00057 kcal per step per kg
  return Math.round(s * 0.00057 * w);
}

/**
 * Calculates estimated walking distance in KM based on step count and height in CM
 * Stride length = heightCm * 0.415
 */
export function calculateStepDistanceKm(steps, heightCm = 175) {
  const s = parseInt(steps, 10);
  const h = parseFloat(heightCm) || 175;
  if (isNaN(s) || s <= 0) return 0;

  const strideMeters = (h * 0.415) / 100;
  const totalMeters = s * strideMeters;
  return Math.round((totalMeters / 1000) * 100) / 100;
}

/**
 * Calculates step progress percentage toward target (e.g. 10,000 steps)
 */
export function getStepProgressPercent(steps, target = 10000) {
  const s = parseInt(steps, 10) || 0;
  const t = parseInt(target, 10) || 10000;
  if (s <= 0 || t <= 0) return 0;
  return Math.round((s / t) * 100);
}

/**
 * Retrieves daily steps for a date and profile
 * Reads from native Health Connect if available, otherwise localStorage / Supabase
 */
export async function getStepData(dateStr, profileId = 'default') {
  if (!dateStr) return { steps: 0, date: dateStr, source: 'none' };

  // 1. If running on native Capacitor Android with Health Connect Plugin available:
  if (isNativePlatform() && window?.Capacitor?.Plugins?.HealthConnect) {
    try {
      const result = await window.Capacitor.Plugins.HealthConnect.getDailySteps({
        date: dateStr,
      });
      if (result && typeof result.steps === 'number') {
        // Sync native steps to Supabase in background
        if (profileId && profileId !== 'default') {
          saveDailyStepsToSupabase(dateStr, result.steps, profileId).catch(() => {});
        }
        return {
          steps: result.steps,
          date: dateStr,
          source: 'health_connect',
          lastSynced: new Date().toISOString(),
        };
      }
    } catch (err) {
      console.warn('Native Health Connect query failed, falling back to local storage:', err);
    }
  }

  // 2. Web fallback (localStorage)
  const storageKey = `openfit_steps_${profileId}_${dateStr}`;
  const raw = localStorage.getItem(storageKey);
  if (raw !== null) {
    const parsed = parseInt(raw, 10);
    return {
      steps: isNaN(parsed) ? 0 : parsed,
      date: dateStr,
      source: 'local',
    };
  }

  return {
    steps: 0,
    date: dateStr,
    source: 'none',
  };
}

/**
 * Saves manual step count or user correction for a date
 * Persists to localStorage and syncs with Supabase in the background
 */
export async function saveManualSteps(dateStr, steps, profileId = 'default') {
  if (!dateStr) return;
  const s = Math.max(0, parseInt(steps, 10) || 0);
  const storageKey = `openfit_steps_${profileId}_${dateStr}`;
  localStorage.setItem(storageKey, String(s));

  // Sync to Supabase in background
  if (profileId && profileId !== 'default') {
    saveDailyStepsToSupabase(dateStr, s, profileId).catch((err) => {
      console.warn('Background Supabase steps sync error:', err);
    });
  }

  return { steps: s, date: dateStr, source: 'local' };
}

