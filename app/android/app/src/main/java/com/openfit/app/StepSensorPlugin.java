package com.openfit.app;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener2;
import android.hardware.SensorManager;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import androidx.core.content.ContextCompat;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.annotation.Permission;
import com.getcapacitor.annotation.PermissionCallback;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@CapacitorPlugin(
    name = "StepSensor",
    permissions = {
        @Permission(
            strings = {
                Manifest.permission.ACTIVITY_RECOGNITION,
                Manifest.permission.BODY_SENSORS
            },
            alias = "activityRecognition"
        )
    }
)
public class StepSensorPlugin extends Plugin implements SensorEventListener2 {

    private SensorManager sensorManager;
    private Sensor stepCounterSensor;
    private Sensor stepDetectorSensor;
    private HealthConnectBridge healthConnectBridge;
    private static final String PREFS_NAME = "openfit_step_prefs";
    private static final String KEY_LAST_STEPS = "last_sensor_steps";
    private static final String KEY_BASELINE_STEPS = "baseline_sensor_steps";
    private static final String KEY_BASELINE_DATE = "baseline_date";
    private static final String KEY_ACCUMULATED_DAILY = "accumulated_daily_steps";
    private static final String KEY_DATE_PREFIX = "steps_date_";
    private int latestLiveSensorReading = 0;

    @Override
    public void load() {
        super.load();
        Context ctx = getContext();
        healthConnectBridge = new HealthConnectBridge(ctx);
        sensorManager = (SensorManager) ctx.getSystemService(Context.SENSOR_SERVICE);
        if (sensorManager != null) {
            stepCounterSensor = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER);
            if (stepCounterSensor != null) {
                sensorManager.registerListener(this, stepCounterSensor, SensorManager.SENSOR_DELAY_NORMAL);
            }
            stepDetectorSensor = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_DETECTOR);
            if (stepDetectorSensor != null) {
                sensorManager.registerListener(this, stepDetectorSensor, SensorManager.SENSOR_DELAY_NORMAL);
            }
            try {
                sensorManager.flush(this);
            } catch (Exception ignored) {}
        }
    }

    private String getTodayDateStr() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
        return sdf.format(new Date());
    }

    private synchronized int calculateTodaySteps(int currentSensorSteps) {
        latestLiveSensorReading = currentSensorSteps;
        Context ctx = getContext();
        SharedPreferences prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        String today = getTodayDateStr();
        String savedDate = prefs.getString(KEY_BASELINE_DATE, "");
        int baselineSteps = prefs.getInt(KEY_BASELINE_STEPS, -1);

        if (!today.equals(savedDate)) {
            prefs.edit()
                .putString(KEY_BASELINE_DATE, today)
                .putInt(KEY_BASELINE_STEPS, currentSensorSteps)
                .putInt(KEY_LAST_STEPS, currentSensorSteps)
                .putInt(KEY_ACCUMULATED_DAILY, 0)
                .putInt(KEY_DATE_PREFIX + today, 0)
                .apply();
            return 0;
        }

        if (baselineSteps < 0) {
            prefs.edit()
                .putString(KEY_BASELINE_DATE, today)
                .putInt(KEY_BASELINE_STEPS, currentSensorSteps)
                .putInt(KEY_LAST_STEPS, currentSensorSteps)
                .putInt(KEY_ACCUMULATED_DAILY, 0)
                .putInt(KEY_DATE_PREFIX + today, 0)
                .apply();
            return 0;
        }

        int dailySteps = Math.max(0, currentSensorSteps - baselineSteps);
        prefs.edit()
            .putInt(KEY_LAST_STEPS, currentSensorSteps)
            .putInt(KEY_ACCUMULATED_DAILY, dailySteps)
            .putInt(KEY_DATE_PREFIX + today, dailySteps)
            .apply();
        return dailySteps;
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        if (event.sensor.getType() == Sensor.TYPE_STEP_COUNTER && event.values.length > 0) {
            int totalStepsSinceBoot = (int) event.values[0];
            calculateTodaySteps(totalStepsSinceBoot);
        } else if (event.sensor.getType() == Sensor.TYPE_STEP_DETECTOR && event.values.length > 0) {
            Context ctx = getContext();
            SharedPreferences prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
            String today = getTodayDateStr();
            int current = prefs.getInt(KEY_DATE_PREFIX + today, prefs.getInt(KEY_ACCUMULATED_DAILY, 0));
            int next = current + 1;
            prefs.edit()
                .putInt(KEY_ACCUMULATED_DAILY, next)
                .putInt(KEY_DATE_PREFIX + today, next)
                .apply();
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {}

    @Override
    public void onFlushCompleted(Sensor sensor) {}

    @PluginMethod
    public void checkPermissions(PluginCall call) {
        JSObject ret = new JSObject();
        boolean hasActivityPermission = true;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            hasActivityPermission = ContextCompat.checkSelfPermission(
                getContext(),
                Manifest.permission.ACTIVITY_RECOGNITION
            ) == PackageManager.PERMISSION_GRANTED;
        }

        boolean hasHealthConnect = healthConnectBridge != null && healthConnectBridge.isAvailable();
        boolean hasHealthConnectPermission = healthConnectBridge != null && healthConnectBridge.hasStepsPermission();

        ret.put("granted", hasActivityPermission || hasHealthConnectPermission);
        ret.put("hasSensor", (stepCounterSensor != null || stepDetectorSensor != null));
        ret.put("hasHealthConnect", hasHealthConnect);
        ret.put("healthConnectGranted", hasHealthConnectPermission);
        ret.put("provider", hasHealthConnect ? "health_connect" : "samsung_sensor");
        call.resolve(ret);
    }

    @PluginMethod
    public void requestPermissions(PluginCall call) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            if (ContextCompat.checkSelfPermission(getContext(), Manifest.permission.ACTIVITY_RECOGNITION) != PackageManager.PERMISSION_GRANTED) {
                requestPermissionForAlias("activityRecognition", call, "permissionCallback");
                return;
            }
        }
        JSObject ret = new JSObject();
        ret.put("granted", true);
        ret.put("hasSensor", (stepCounterSensor != null || stepDetectorSensor != null));
        ret.put("provider", (healthConnectBridge != null && healthConnectBridge.isAvailable()) ? "health_connect" : "samsung_sensor");
        call.resolve(ret);
    }

    @PermissionCallback
    private void permissionCallback(PluginCall call) {
        checkPermissions(call);
    }

    @PluginMethod
    public synchronized void calibrateBaseline(PluginCall call) {
        int targetTodaySteps = call.getInt("todaySteps", 0);
        String targetDate = call.getString("date", getTodayDateStr());
        Context ctx = getContext();
        SharedPreferences prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        int currentSensor = prefs.getInt(KEY_LAST_STEPS, latestLiveSensorReading);
        int calculatedBaseline = Math.max(0, currentSensor - targetTodaySteps);

        prefs.edit()
            .putString(KEY_BASELINE_DATE, targetDate)
            .putInt(KEY_BASELINE_STEPS, calculatedBaseline)
            .putInt(KEY_ACCUMULATED_DAILY, targetTodaySteps)
            .putInt(KEY_DATE_PREFIX + targetDate, targetTodaySteps)
            .apply();

        JSObject ret = new JSObject();
        ret.put("baseline", calculatedBaseline);
        ret.put("todaySteps", targetTodaySteps);
        ret.put("date", targetDate);
        ret.put("source", "manual");
        call.resolve(ret);
    }

    @PluginMethod
    public synchronized void getDailySteps(PluginCall call) {
        if (sensorManager != null) {
            try {
                sensorManager.flush(this);
            } catch (Exception ignored) {}
        }

        String reqDate = call.getString("date", getTodayDateStr());
        String today = getTodayDateStr();
        Context ctx = getContext();
        SharedPreferences prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);

        // 1. First priority: Read official steps from Health Connect (Samsung Health)
        if (healthConnectBridge != null && healthConnectBridge.isAvailable()) {
            try {
                long hcSteps = healthConnectBridge.getDailySteps(reqDate);
                if (hcSteps > 0) {
                    prefs.edit().putInt(KEY_DATE_PREFIX + reqDate, (int) hcSteps).apply();

                    JSObject ret = new JSObject();
                    ret.put("steps", (int) hcSteps);
                    ret.put("rawSensorSteps", (int) hcSteps);
                    ret.put("date", reqDate);
                    ret.put("source", "samsung_health");
                    ret.put("provider", "health_connect");
                    ret.put("hasPermission", true);
                    ret.put("hasSensor", true);
                    call.resolve(ret);
                    return;
                }
            } catch (Exception ignored) {}
        }

        // 2. Second priority: Fallback to Hardware Sensor & Cached Steps
        boolean hasPermission = true;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            hasPermission = ContextCompat.checkSelfPermission(
                ctx,
                Manifest.permission.ACTIVITY_RECOGNITION
            ) == PackageManager.PERMISSION_GRANTED;
        }

        int stepsResult = 0;
        int lastSensor = prefs.getInt(KEY_LAST_STEPS, latestLiveSensorReading);
        int baseline = prefs.getInt(KEY_BASELINE_STEPS, -1);
        String savedDate = prefs.getString(KEY_BASELINE_DATE, "");

        if (reqDate.equals(today)) {
            if (!today.equals(savedDate)) {
                prefs.edit()
                    .putString(KEY_BASELINE_DATE, today)
                    .putInt(KEY_BASELINE_STEPS, lastSensor)
                    .putInt(KEY_ACCUMULATED_DAILY, 0)
                    .putInt(KEY_DATE_PREFIX + today, 0)
                    .apply();
                stepsResult = 0;
                baseline = lastSensor;
            } else {
                stepsResult = prefs.getInt(KEY_DATE_PREFIX + today, prefs.getInt(KEY_ACCUMULATED_DAILY, 0));
                if (stepsResult == 0 && lastSensor > 0 && baseline >= 0 && lastSensor >= baseline) {
                    stepsResult = lastSensor - baseline;
                }
            }
        } else {
            stepsResult = prefs.getInt(KEY_DATE_PREFIX + reqDate, 0);
        }

        JSObject ret = new JSObject();
        ret.put("steps", stepsResult);
        ret.put("rawSensorSteps", lastSensor);
        ret.put("baseline", baseline);
        ret.put("date", reqDate);
        ret.put("source", "samsung_health_sensor");
        ret.put("provider", "samsung_sensor");
        ret.put("hasPermission", hasPermission);
        ret.put("hasSensor", (stepCounterSensor != null || stepDetectorSensor != null));
        call.resolve(ret);
    }

    @PluginMethod
    public void openHealthSettings(PluginCall call) {
        try {
            Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
            Uri uri = Uri.fromParts("package", getContext().getPackageName(), null);
            intent.setData(uri);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            getContext().startActivity(intent);
            call.resolve();
        } catch (Exception e) {
            call.reject("Could not open settings: " + e.getMessage());
        }
    }

    @PluginMethod
    public void openSamsungHealthApp(PluginCall call) {
        try {
            Intent launchIntent = getContext().getPackageManager().getLaunchIntentForPackage("com.sec.android.app.shealth");
            if (launchIntent != null) {
                launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                getContext().startActivity(launchIntent);
                call.resolve();
            } else {
                Intent hcIntent = new Intent("androidx.health.ACTION_HEALTH_CONNECT_SETTINGS");
                hcIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                getContext().startActivity(hcIntent);
                call.resolve();
            }
        } catch (Exception e) {
            try {
                Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
                Uri uri = Uri.fromParts("package", getContext().getPackageName(), null);
                intent.setData(uri);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                getContext().startActivity(intent);
                call.resolve();
            } catch (Exception ex) {
                call.reject("Could not launch Samsung Health or settings: " + ex.getMessage());
            }
        }
    }
}
