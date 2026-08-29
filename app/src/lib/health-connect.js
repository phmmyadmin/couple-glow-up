import { Capacitor, registerPlugin } from '@capacitor/core';
import { saveDailyStepsToSupabase, logAppErrorToSupabase, supabase } from './supabase';

/**
 * Native Capacitor Bridge for Samsung Health & Health Connect
 */
export const StepSensorNative = registerPlugin('StepSensor');

export function isNativePlatform() {
  try {
    return Capacitor.isNativePlatform();
  } catch (e) {
    return false;
  }
}

/**
 * Checks if Samsung Health / Health Connect / Step Sensor permissions are granted
 */
export async function checkNativeStepPermissions() {
  if (isNativePlatform()) {
    try {
      const res = await StepSensorNative.checkPermissions();
      logAppErrorToSupabase('info', 'step_sensor', 'StepSensor checkPermissions result', res);
      return res || { granted: false, hasSensor: false, provider: 'sensor' };
    } catch (e) {
      logAppErrorToSupabase('error', 'step_sensor', `StepSensor check error: ${e?.message || e}`);
    }
  }
  return { granted: true, hasSensor: false, provider: 'web' };
}

/**
 * Requests Physical Activity & Samsung Health permissions
 */
export async function requestNativeStepPermissions() {
  if (isNativePlatform()) {
    try {
      const res = await StepSensorNative.requestPermissions();
      logAppErrorToSupabase('info', 'step_sensor', 'StepSensor requestPermissions result', res);
      return res || { granted: false };
    } catch (e) {
      logAppErrorToSupabase('error', 'step_sensor', `StepSensor request error: ${e?.message || e}`);
    }
  }
  return { granted: true };
}

/**
 * Opens Android system settings for app permissions
 */
export async function openNativeHealthSettings() {
  if (isNativePlatform()) {
    try {
      await StepSensorNative.openHealthSettings();
    } catch (e) {
      logAppErrorToSupabase('error', 'step_sensor', `openHealthSettings error: ${e?.message || e}`);
    }
  }
}

/**
 * Opens Health Connect permissions screen specifically for OpenFit
 */
export async function openHealthConnectPermissions() {
  if (isNativePlatform()) {
    try {
      await StepSensorNative.openHealthConnectPermissions();
    } catch (e) {
      logAppErrorToSupabase('error', 'step_sensor', `openHealthConnectPermissions error: ${e?.message || e}`);
    }
  }
}

/**
 * Opens Samsung Health app or Health Connect settings
 */
export async function openSamsungHealthApp() {
  if (isNativePlatform()) {
    try {
      await StepSensorNative.openSamsungHealthApp();
    } catch (e) {
      logAppErrorToSupabase('error', 'step_sensor', `openSamsungHealthApp error: ${e?.message || e}`);
    }
  }
}

/**
 * Calculates active walking calories based on step count and user weight
 * Formula: MET walking (~3.5) * weightKg * (steps / steps_per_minute / 60)
 * Average: ~0.00057 kcal per step per kg bodyweight
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
 * Reads from native Samsung Health / Health Connect, with local storage and Supabase caching
 */
export async function getStepData(dateStr, profileId = 'default') {
  if (!dateStr) return { steps: 0, date: dateStr, source: 'none' };

  // 1. If running on native Android:
  if (isNativePlatform()) {
    try {
      const result = await StepSensorNative.getDailySteps({
        date: dateStr,
      });

      logAppErrorToSupabase('info', 'step_sensor', `StepSensor query result: ${result?.steps || 0} steps`, result);

      if (result && typeof result.steps === 'number' && result.steps > 0) {
        // Cache locally for this specific date
        const storageKey = `openfit_steps_${profileId}_${dateStr}`;
        localStorage.setItem(storageKey, String(result.steps));

        if (profileId && profileId !== 'default') {
          saveDailyStepsToSupabase(dateStr, result.steps, profileId).catch(() => {});
        }
        return {
          steps: result.steps,
          date: dateStr,
          source: result.source || 'samsung_health',
          provider: result.provider || 'health_connect',
          lastSynced: new Date().toISOString(),
        };
      }
    } catch (err) {
      logAppErrorToSupabase('warn', 'step_sensor', `StepSensor query error: ${err?.message || err}`);
    }
  }

  // 2. Storage / Cache Fallback (localStorage for this specific date)
  const storageKey = `openfit_steps_${profileId}_${dateStr}`;
  const raw = localStorage.getItem(storageKey);
  if (raw !== null) {
    const parsed = parseInt(raw, 10);
    return {
      steps: isNaN(parsed) ? 0 : parsed,
      date: dateStr,
      source: 'local',
      lastSynced: new Date().toISOString(),
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
  if (!dateStr) return { steps: 0, date: dateStr, source: 'manual' };
  const s = Math.max(0, parseInt(steps, 10) || 0);
  const storageKey = `openfit_steps_${profileId}_${dateStr}`;
  localStorage.setItem(storageKey, String(s));

  // Calibrate native hardware pedometer baseline so hardware step tracking matches
  if (isNativePlatform()) {
    try {
      await StepSensorNative.calibrateBaseline({ todaySteps: s, date: dateStr });
    } catch (e) {}
  }

  // Sync to Supabase in background
  if (profileId && profileId !== 'default') {
    saveDailyStepsToSupabase(dateStr, s, profileId).catch((err) => {
      console.warn('Background Supabase steps sync error:', err);
    });
  }

  return { steps: s, date: dateStr, source: 'manual' };
}
