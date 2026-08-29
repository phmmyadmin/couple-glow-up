package com.openfit.app

import android.content.Context
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.time.TimeRangeFilter
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import java.time.LocalDate
import java.time.ZoneId
import java.time.temporal.ChronoUnit

class HealthConnectBridge(private val context: Context) {

    private val healthConnectClient: HealthConnectClient? by lazy {
        try {
            if (isAvailable()) {
                HealthConnectClient.getOrCreate(context)
            } else {
                null
            }
        } catch (e: Exception) {
            null
        }
    }

    fun isAvailable(): Boolean {
        return try {
            val status = HealthConnectClient.getSdkStatus(context)
            status == HealthConnectClient.SDK_AVAILABLE
        } catch (e: Exception) {
            false
        }
    }

    fun hasStepsPermission(): Boolean {
        return try {
            if (!isAvailable() || healthConnectClient == null) return false
            val requiredPermission = HealthPermission.getReadPermission(StepsRecord::class)
            runBlocking(Dispatchers.IO) {
                val granted = healthConnectClient?.permissionController?.getGrantedPermissions() ?: emptySet()
                requiredPermission in granted
            }
        } catch (e: Exception) {
            false
        }
    }

    /**
     * Reads aggregated steps for a specific date (YYYY-MM-DD) from Health Connect
     * Uses local system timezone to calculate start of day (00:00:00) and end of day (23:59:59.999)
     */
    fun getDailySteps(dateStr: String): Long {
        return try {
            if (!isAvailable() || healthConnectClient == null) return 0L

            runBlocking(Dispatchers.IO) {
                val zoneId = ZoneId.systemDefault()
                val parsedDate = try {
                    LocalDate.parse(dateStr)
                } catch (e: Exception) {
                    LocalDate.now(zoneId)
                }

                val startInstant = parsedDate.atStartOfDay(zoneId).toInstant()
                val endInstant = startInstant.plus(1, ChronoUnit.DAYS).minusMillis(1)

                val request = AggregateRequest(
                    metrics = setOf(StepsRecord.COUNT_TOTAL),
                    timeRangeFilter = TimeRangeFilter.between(startInstant, endInstant)
                )

                val response = healthConnectClient?.aggregate(request)
                response?.get(StepsRecord.COUNT_TOTAL) ?: 0L
            }
        } catch (e: Exception) {
            0L
        }
    }
}
