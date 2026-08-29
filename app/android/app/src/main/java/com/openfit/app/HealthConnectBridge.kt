package com.openfit.app

import android.content.Context
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.request.ReadRecordsRequest
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
     * Reads aggregated steps for a specific date (YYYY-MM-DD) from Health Connect / Samsung Health.
     * Uses dual-strategy:
     * 1. aggregate(StepsRecord.COUNT_TOTAL) for deduplicated system total
     * 2. readRecords(ReadRecordsRequest) as fallback sum
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
                val timeFilter = TimeRangeFilter.between(startInstant, endInstant)

                var totalSteps = 0L

                // 1. Primary strategy: Aggregate metric (deduplicated)
                try {
                    val request = AggregateRequest(
                        metrics = setOf(StepsRecord.COUNT_TOTAL),
                        timeRangeFilter = timeFilter
                    )
                    val response = healthConnectClient?.aggregate(request)
                    totalSteps = response?.get(StepsRecord.COUNT_TOTAL) ?: 0L
                } catch (e: Exception) {
                    totalSteps = 0L
                }

                // 2. Secondary strategy: Direct records reading fallback
                if (totalSteps <= 0L) {
                    try {
                        val readRequest = ReadRecordsRequest(
                            recordType = StepsRecord::class,
                            timeRangeFilter = timeFilter
                        )
                        val recordsResponse = healthConnectClient?.readRecords(readRequest)
                        val records = recordsResponse?.records ?: emptyList()
                        totalSteps = records.sumOf { it.count }
                    } catch (e: Exception) {
                        // ignore
                    }
                }

                totalSteps
            }
        } catch (e: Exception) {
            0L
        }
    }
}
