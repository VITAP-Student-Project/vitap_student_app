package com.udhay.vitapstudentapp

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

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

    override fun onEnabled(context: Context) {
        // No additional functionality needed
    }

    override fun onDisabled(context: Context) {
        // No additional functionality needed
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == REFRESH_ACTION) {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val thisAppWidgetComponentName = ComponentName(context, UpcomingClassWidget::class.java)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(thisAppWidgetComponentName)
            for (appWidgetId in appWidgetIds) {
                updateAppWidget(context, appWidgetManager, appWidgetId)
            }
        }
    }

    companion object {
        private const val REFRESH_ACTION = "com.udhay.vitapstudentapp.REFRESH_WIDGET"

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val courseName = context.getSharedPreferences("widget_prefs", Context.MODE_PRIVATE).getString("next_class", "No upcoming class") ?: "No upcoming class"
            val facultyName = context.getSharedPreferences("widget_prefs", Context.MODE_PRIVATE).getString("faculty_name", "") ?: ""
            val venue = context.getSharedPreferences("widget_prefs", Context.MODE_PRIVATE).getString("venue", "") ?: ""

            val views = RemoteViews(context.packageName, R.layout.upcoming_class_widget)
            views.setTextViewText(R.id.course_name, courseName)
            views.setTextViewText(R.id.faculty_name, facultyName)
            views.setTextViewText(R.id.venue, venue)

            val intent = Intent(context, UpcomingClassWidget::class.java).apply {
                action = REFRESH_ACTION
            }
            val pendingIntent = PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
            views.setOnClickPendingIntent(R.id.refresh_button, pendingIntent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}