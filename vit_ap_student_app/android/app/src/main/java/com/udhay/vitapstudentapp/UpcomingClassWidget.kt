package com.udhay.vitapstudentapp

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale
import org.json.JSONArray

class UpcomingClassWidget : AppWidgetProvider() {
        override fun onReceive(context: Context, intent: Intent) {
                super.onReceive(context, intent)

                when (intent.action) {
                        Intent.ACTION_SCREEN_ON,
                        Intent.ACTION_BOOT_COMPLETED,
                        AppWidgetManager.ACTION_APPWIDGET_UPDATE -> {
                                val appWidgetManager = AppWidgetManager.getInstance(context)
                                val componentName =
                                        ComponentName(context, UpcomingClassWidget::class.java)
                                val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)

                                // Update all widget instances
                                onUpdate(context, appWidgetManager, appWidgetIds)
                        }
                }
        }

        override fun onUpdate(
                context: Context,
                appWidgetManager: AppWidgetManager,
                appWidgetIds: IntArray
        ) {
                for (appWidgetId in appWidgetIds) {
                        updateAppWidget(context, appWidgetManager, appWidgetId)
                }
        }

        companion object {
                fun updateAppWidget(
                        context: Context,
                        appWidgetManager: AppWidgetManager,
                        appWidgetId: Int
                ) {
                        try {
                                val widgetData = HomeWidgetPlugin.getData(context)

                                // Directly retrieve today's classes from HomeWidget
                                val todayClassesJson =
                                        widgetData.getString("today_classes", "[]") ?: "[]"
                                val todayClasses = parseClassesList(todayClassesJson)

                                // Find next class
                                val nextClass = findNextClass(todayClasses)

                                // Use next class details or fallback
                                val courseName =
                                        nextClass?.get("course_name") ?: "No Upcoming Class"
                                val facultyName = nextClass?.get("faculty") ?: ""
                                val venue = nextClass?.get("venue") ?: ""
                                val timing = nextClass?.get("timing") ?: ""

                                // Update widget views
                                val views =
                                        RemoteViews(
                                                context.packageName,
                                                R.layout.upcoming_class_widget
                                        )
                                views.setTextViewText(R.id.course_name, courseName)
                                views.setTextViewText(R.id.faculty_name, facultyName)
                                views.setTextViewText(R.id.venue, venue)
                                views.setTextViewText(R.id.timing, timing)

                                // Refresh button setup
                                val intent =
                                        Intent(context, UpcomingClassWidget::class.java).apply {
                                                action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                                                putExtra(
                                                        AppWidgetManager.EXTRA_APPWIDGET_IDS,
                                                        intArrayOf(appWidgetId)
                                                )
                                        }
                                val pendingIntent =
                                        PendingIntent.getBroadcast(
                                                context,
                                                appWidgetId,
                                                intent,
                                                PendingIntent.FLAG_UPDATE_CURRENT or
                                                        PendingIntent.FLAG_IMMUTABLE
                                        )
                                views.setOnClickPendingIntent(R.id.refresh_button, pendingIntent)

                                // Update the widget
                                appWidgetManager.updateAppWidget(appWidgetId, views)
                        } catch (e: Exception) {
                                Log.e(
                                        "UpcomingClassWidget",
                                        "Error in updateAppWidget: ${e.message}"
                                )
                        }
                }

                // Helper function to parse classes list
                private fun parseClassesList(jsonString: String): List<Map<String, Any>> {
                        return try {
                                val jsonArray = JSONArray(jsonString)
                                (0 until jsonArray.length()).map { index ->
                                        val classItem = jsonArray.getJSONObject(index)
                                        val timeRange = classItem.keys().next() as String
                                        val classDetails = classItem.getJSONObject(timeRange)

                                        mapOf(
                                                timeRange to
                                                        mapOf(
                                                                "course_name" to
                                                                        classDetails.getString(
                                                                                "course_name"
                                                                        ),
                                                                "faculty" to
                                                                        classDetails.getString(
                                                                                "faculty"
                                                                        ),
                                                                "venue" to
                                                                        classDetails.getString(
                                                                                "venue"
                                                                        )
                                                        )
                                        )
                                }
                        } catch (e: Exception) {
                                Log.e("UpcomingClassWidget", "Error parsing classes: ${e.message}")
                                emptyList()
                        }
                }

                // Helper function to find next class
                private fun findNextClass(classes: List<Map<String, Any>>): Map<String, String>? {
                        val now = Calendar.getInstance()
                        val timeFormat = SimpleDateFormat("HH:mm", Locale.getDefault())

                        for (classItem in classes) {
                                val timeRange = classItem.keys.first()
                                val startTime = timeRange.split(" - ")[0]

                                try {
                                        val classStartTime = timeFormat.parse(startTime)
                                        val classStartCalendar =
                                                Calendar.getInstance().apply {
                                                        time = classStartTime
                                                        set(Calendar.YEAR, now.get(Calendar.YEAR))
                                                        set(Calendar.MONTH, now.get(Calendar.MONTH))
                                                        set(
                                                                Calendar.DAY_OF_MONTH,
                                                                now.get(Calendar.DAY_OF_MONTH)
                                                        )
                                                }

                                        if (classStartCalendar.timeInMillis > now.timeInMillis) {
                                                val classDetails =
                                                        classItem[timeRange] as Map<String, String>
                                                return mapOf(
                                                        "course_name" to
                                                                classDetails["course_name"]!!,
                                                        "faculty" to classDetails["faculty"]!!,
                                                        "venue" to classDetails["venue"]!!,
                                                        "timing" to timeRange
                                                )
                                        }
                                } catch (e: Exception) {
                                        Log.e(
                                                "UpcomingClassWidget",
                                                "Error parsing class time: ${e.message}"
                                        )
                                }
                        }

                        return null
                }
        }
}
