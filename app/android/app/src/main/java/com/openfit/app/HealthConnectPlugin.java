package com.openfit.app;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
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
    name = "HealthConnect",
    permissions = {
        @Permission(
            strings = { Manifest.permission.ACTIVITY_RECOGNITION },
            alias = "activityRecognition"
        )
    }
)
public class HealthConnectPlugin extends Plugin implements SensorEventListener {

    private SensorManager sensorManager;
    private Sensor stepCounterSensor;
    private static final String PREFS_NAME = "openfit_step_prefs";
    private static final String KEY_LAST_STEPS = "last_sensor_steps";
    private static final String KEY_BASELINE_STEPS = "baseline_sensor_steps";
    private static final String KEY_BASELINE_DATE = "baseline_date";
    private static final String KEY_ACCUMULATED_DAILY = "accumulated_daily_steps";

    @Override
    public void load() {
        super.load();
        Context ctx = getContext();
        sensorManager = (SensorManager) ctx.getSystemService(Context.SENSOR_SERVICE);
        if (sensorManager != null) {
            stepCounterSensor = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER);
            if (stepCounterSensor != null) {
                sensorManager.registerListener(this, stepCounterSensor, SensorManager.SENSOR_DELAY_UI);
            }
        }
    }

    private String getTodayDateStr() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.getDefault());
        return sdf.format(new Date());
    }

    private int calculateTodaySteps(int currentSensorSteps) {
        Context ctx = getContext();
        SharedPreferences prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        String today = getTodayDateStr();
        String savedDate = prefs.getString(KEY_BASELINE_DATE, "");
        int baselineSteps = prefs.getInt(KEY_BASELINE_STEPS, -1);

        if (!today.equals(savedDate) || baselineSteps < 0 || currentSensorSteps < baselineSteps) {
            // New day or device rebooted -> update baseline to current sensor count
            prefs.edit()
                .putString(KEY_BASELINE_DATE, today)
                .putInt(KEY_BASELINE_STEPS, currentSensorSteps)
                .putInt(KEY_LAST_STEPS, currentSensorSteps)
                .putInt(KEY_ACCUMULATED_DAILY, 0)
                .apply();
            return 0;
        }

        int dailySteps = Math.max(0, currentSensorSteps - baselineSteps);
        prefs.edit()
            .putInt(KEY_LAST_STEPS, currentSensorSteps)
            .putInt(KEY_ACCUMULATED_DAILY, dailySteps)
            .apply();
        return dailySteps;
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        if (event.sensor.getType() == Sensor.TYPE_STEP_COUNTER && event.values.length > 0) {
            int totalStepsSinceBoot = (int) event.values[0];
            calculateTodaySteps(totalStepsSinceBoot);
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {}

    @PluginMethod
    public void checkPermissions(PluginCall call) {
        JSObject ret = new JSObject();
        boolean hasPermission = true;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            hasPermission = ContextCompat.checkSelfPermission(
                getContext(),
                Manifest.permission.ACTIVITY_RECOGNITION
            ) == PackageManager.PERMISSION_GRANTED;
        }
        ret.put("granted", hasPermission);
        ret.put("hasSensor", stepCounterSensor != null);
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
        ret.put("hasSensor", stepCounterSensor != null);
        call.resolve(ret);
    }

    @PermissionCallback
    private void permissionCallback(PluginCall call) {
        checkPermissions(call);
    }

    @PluginMethod
    public void getDailySteps(PluginCall call) {
        String reqDate = call.getString("date", getTodayDateStr());
        Context ctx = getContext();
        SharedPreferences prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);

        boolean hasPermission = true;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            hasPermission = ContextCompat.checkSelfPermission(
                ctx,
                Manifest.permission.ACTIVITY_RECOGNITION
            ) == PackageManager.PERMISSION_GRANTED;
        }

        int todaySteps = prefs.getInt(KEY_ACCUMULATED_DAILY, 0);

        JSObject ret = new JSObject();
        ret.put("steps", todaySteps);
        ret.put("date", reqDate);
        ret.put("source", "samsung_health_sensor");
        ret.put("hasPermission", hasPermission);
        ret.put("hasSensor", stepCounterSensor != null);
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
}
