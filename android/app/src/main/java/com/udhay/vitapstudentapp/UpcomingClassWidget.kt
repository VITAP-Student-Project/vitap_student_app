package com.udhay.vitapstudentapp

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import java.text.SimpleDateFormat
import java.util.*
import org.json.JSONArray
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
                                val timetableJson = widgetData.getString("timetable", "{}")
                                val timetable = JSONObject(timetableJson)

                                // Use English day names to match JSON keys
                                val currentDay =
                                        SimpleDateFormat("EEEE", Locale.ENGLISH)
                                                .format(Calendar.getInstance().time)

                                // Handle case where day has no classes
                                val todayClasses = timetable.optJSONArray(currentDay) ?: JSONArray()

                                val nextClass = findNextClass(todayClasses)

                                val views =
                                        RemoteViews(
                                                context.packageName,
                                                R.layout.upcoming_class_widget
                                        )

                                if (nextClass != null) {
                                        views.setTextViewText(
                                                R.id.course_name,
                                                nextClass.courseName
                                        )
                                        views.setTextViewText(R.id.faculty_name, nextClass.faculty)
                                        views.setTextViewText(R.id.venue, nextClass.venue)
                                        views.setTextViewText(R.id.timing, nextClass.time)
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

                private fun findNextClass(classes: JSONArray): NextClass? {
                        val now = Calendar.getInstance()
                        val timeFormat = SimpleDateFormat("HH:mm", Locale.getDefault())
                        var nextClass: NextClass? = null

                        for (i in 0 until classes.length()) {
                                val cls = classes.getJSONObject(i)
                                val startTime = cls.optString("start_time", "")
                                val endTime = cls.optString("end_time", "")

                                if (startTime.isEmpty()) continue

                                try {
                                        val startTimeParsed = timeFormat.parse(startTime)
                                        val classStart =
                                                Calendar.getInstance().apply {
                                                        time = startTimeParsed!!
                                                        set(Calendar.YEAR, now.get(Calendar.YEAR))
                                                        set(Calendar.MONTH, now.get(Calendar.MONTH))
                                                        set(
                                                                Calendar.DAY_OF_MONTH,
                                                                now.get(Calendar.DAY_OF_MONTH)
                                                        )
                                                }

                                        // Skip past classes
                                        if (classStart.before(now)) continue

                                        // Find earliest upcoming class
                                        if (nextClass == null ||
                                                        classStart.before(nextClass.startTime)
                                        ) {
                                                nextClass =
                                                        NextClass(
                                                                courseName =
                                                                        cls.optString(
                                                                                "course_name",
                                                                                "Unknown Course"
                                                                        ),
                                                                faculty = cls.optString("faculty", "Unknown Faculty"),
                                                                venue = cls.optString("venue", "Unknown Venue"),
                                                                time = "$startTime - $endTime",
                                                                startTime = classStart
                                                        )
                                        }
                                } catch (e: Exception) {
                                        Log.e("TimeParse", "Error parsing time: $startTime")
                                }
                        }
                        return nextClass
                }

                // Helper data class
                private data class NextClass(
                        val courseName: String,
                        val faculty: String,
                        val venue: String,
                        val time: String,
                        val startTime: Calendar
                )
        }
}
