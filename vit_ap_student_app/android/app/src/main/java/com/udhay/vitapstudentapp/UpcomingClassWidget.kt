package com.udhay.vitapstudentapp

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import org.json.JSONArray
import java.text.SimpleDateFormat
import java.util.*
import org.json.JSONObject

class UpcomingClassWidget : AppWidgetProvider() {
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
                                val timetableJson = widgetData.getString("timetable", "{}") ?: "{}"
                                val timetable = JSONObject(timetableJson)

                                val currentDay = getCurrentDay()
                                val todayClasses = timetable.optJSONArray(currentDay) ?: return

                                val nextClass = findNextClass(todayClasses)

                                val views =
                                        RemoteViews(
                                                context.packageName,
                                                R.layout.upcoming_class_widget
                                        )
                                if (nextClass != null) {
                                        views.setTextViewText(
                                                R.id.course_name,
                                                nextClass["course_name"] as String
                                        )
                                        views.setTextViewText(
                                                R.id.faculty_name,
                                                nextClass["faculty"] as String
                                        )
                                        views.setTextViewText(
                                                R.id.venue,
                                                nextClass["venue"] as String
                                        )
                                        views.setTextViewText(
                                                R.id.timing,
                                                nextClass["timing"] as String
                                        )
                                } else {
                                        views.setTextViewText(R.id.course_name, "No Upcoming Class")
                                        views.setTextViewText(R.id.faculty_name, "")
                                        views.setTextViewText(R.id.venue, "")
                                        views.setTextViewText(R.id.timing, "")
                                }

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

                                appWidgetManager.updateAppWidget(appWidgetId, views)
                        } catch (e: Exception) {
                                Log.e("UpcomingClassWidget", "Error updating widget: ${e.message}")
                        }
                }

                private fun getCurrentDay(): String {
                        val calendar = Calendar.getInstance()
                        return SimpleDateFormat("EEEE", Locale.getDefault()).format(calendar.time)
                }

                private fun findNextClass(classes: JSONArray): Map<String, Any>? {
                        val now = Calendar.getInstance()
                        val timeFormat = SimpleDateFormat("HH:mm", Locale.getDefault())

                        for (i in 0 until classes.length()) {
                                val classObject = classes.getJSONObject(i)
                                val timeRange = classObject.keys().next()
                                val startTime = timeRange.split(" - ")[0]

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
                                        val classDetails = classObject.getJSONObject(timeRange)
                                        return mapOf(
                                                "course_name" to
                                                        classDetails.getString("course_name"),
                                                "faculty" to classDetails.getString("faculty"),
                                                "venue" to classDetails.getString("venue"),
                                                "timing" to timeRange
                                        )
                                }
                        }
                        return null
                }
        }
}
