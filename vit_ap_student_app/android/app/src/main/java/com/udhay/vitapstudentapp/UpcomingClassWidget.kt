package com.udhay.vitapstudentapp

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class UpcomingClassWidget : AppWidgetProvider() {
        override fun onUpdate(
                context: Context,
                appWidgetManager: AppWidgetManager,
                appWidgetIds: IntArray
        ) {
                try {
                        for (appWidgetId in appWidgetIds) {
                                updateAppWidget(context, appWidgetManager, appWidgetId)
                        }
                } catch (e: Exception) {
                        e.printStackTrace()
                        Log.e("UpcomingClassWidget", "Error updating widget: ${e.message}")
                }
        }

        companion object {
                fun updateAppWidget(
                        context: Context,
                        appWidgetManager: AppWidgetManager,
                        appWidgetId: Int
                ) {
                        try {
                                Log.d("UpcomingClassWidget", "updateAppWidget called")

                                // Get data using HomeWidgetPlugin
                                val widgetData = HomeWidgetPlugin.getData(context)
                                Log.d("UpcomingClassWidget", "Widget data: ${widgetData.all}")

                                // Get the values using the same keys as in Flutter
                                val courseName =
                                        widgetData.getString("next_class", "No Upcoming Class")
                                val facultyName = widgetData.getString("faculty_name", "")
                                val venue = widgetData.getString("venue", "")
                                val timing = widgetData.getString("class_timing", "")

                                // Debug logs
                                Log.d("UpcomingClassWidget", "Course Name: $courseName")
                                Log.d("UpcomingClassWidget", "Faculty Name: $facultyName")
                                Log.d("UpcomingClassWidget", "Venue: $venue")
                                Log.d("UpcomingClassWidget", "Timing: $timing")

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
                                Log.d("UpcomingClassWidget", "Widget updated successfully")
                        } catch (e: Exception) {
                                e.printStackTrace()
                                Log.e(
                                        "UpcomingClassWidget",
                                        "Error in updateAppWidget: ${e.message}"
                                )
                        }
                }
        }
}
