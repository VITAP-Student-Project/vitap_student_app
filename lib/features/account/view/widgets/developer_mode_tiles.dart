import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/providers/developer_options_notifier.dart';
import 'package:vit_ap_student_app/core/providers/user_preferences_notifier.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/show_toast.dart';

class DeveloperModeTiles extends ConsumerWidget {
  const DeveloperModeTiles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final developerOptionsAsync = ref.watch(developerOptionsNotifierProvider);

    return developerOptionsAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Loader(),
        ),
      ),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Error loading developer options: $error",
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
      data: (state) => _DeveloperOptionsContent(state: state),
    );
  }
}

class _DeveloperOptionsContent extends ConsumerWidget {
  final DeveloperOptionsState state;

  const _DeveloperOptionsContent({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Debug Information Section
        _buildSubheading(context, "Debug Information", Iconsax.info_circle),
        _buildInfoRow(context, "App Version", state.appVersion),
        _buildInfoRow(context, "Build Number", state.buildNumber),
        _buildInfoRow(context, "Device Info", state.deviceInfo),
        _buildInfoRow(context, "Flutter Version", state.flutterVersion),
        _buildInfoRow(context, "ObjectBox Version", state.objectBoxVersion),

        const SizedBox(height: 16),

        // Network & API Section
        _buildSubheading(context, "Network & API", Iconsax.global),
        _buildInfoRow(context, "VTOP Session", state.vtopSessionStatus),
        _buildActionRow(
          context,
          "Refresh Session Info",
          onTap: () async {
            await ref
                .read(developerOptionsNotifierProvider.notifier)
                .refreshVtopSession();
            if (context.mounted) {
              showToast(context, "Session info refreshed");
            }
          },
        ),
        _buildActionRow(
          context,
          "Force Session Reset",
          onTap: () async {
            try {
              await ref
                  .read(developerOptionsNotifierProvider.notifier)
                  .forceSessionReset();
              if (context.mounted) {
                showToast(
                    context, "✅ Session cleared, will refresh on next request");
              }
              AnalyticsService.logEvent('force_session_refresh');
            } catch (e) {
              if (context.mounted) {
                showToast(context, "Failed to refresh session");
              }
            }
          },
        ),

        const SizedBox(height: 16),

        // Storage & Database Section
        _buildSubheading(context, "Storage & Database", Iconsax.data),
        _buildInfoRow(context, "ObjectBox Size", state.objectBoxSize),
        _buildInfoRow(context, "Secure Storage Keys", state.secureStorageKeys),
        _buildActionRow(
          context,
          "Clear All Local Data",
          isDestructive: true,
          onTap: () => _showClearDataDialog(context, ref),
        ),
        _buildActionRow(
          context,
          "View Raw User Object",
          onTap: () => _showRawUserObject(context, ref),
        ),
        _buildActionRow(
          context,
          "View Raw User Preferences",
          onTap: () => _showRawUserPreferences(context, ref),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSubheading(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(
    BuildContext context,
    String label, {
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isDestructive
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: isDestructive
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  void _showRawUserObject(BuildContext context, WidgetRef ref) {
    final user = ref.read(currentUserNotifierProvider);

    if (user == null) {
      showToast(context, "No user data available");
      return;
    }

    final userJson = const JsonEncoder.withIndent('  ').convert(user.toJson());

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            const Text("Raw User Object"),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: userJson));
                showToast(dialogContext, "Copied to clipboard");
              },
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: SelectableText(
            userJson,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showRawUserPreferences(BuildContext context, WidgetRef ref) {
    final prefs = ref.read(userPreferencesNotifierProvider);

    final prefsMap = {
      'id': prefs.id,
      'pfpPath': prefs.pfpPath,
      'isTimetableNotificationsEnabled': prefs.isTimetableNotificationsEnabled,
      'isExamScheduleNotificationEnabled':
          prefs.isExamScheduleNotificationEnabled,
      'timetableNotificationDelay': prefs.timetableNotificationDelay,
      'examScheduleNotificationDelay': prefs.examScheduleNotificationDelay,
      'isPrivacyEnabled': prefs.isPrivacyEnabled,
      'isDarkModeEnabled': prefs.isDarkModeEnabled,
      'lastSync': prefs.lastSync?.toIso8601String(),
      'attendanceLastSync': prefs.attendanceLastSync?.toIso8601String(),
      'marksLastSync': prefs.marksLastSync?.toIso8601String(),
      'examScheduleLastSync': prefs.examScheduleLastSync?.toIso8601String(),
      'isFirstLaunch': prefs.isFirstLaunch,
    };

    final prefsJson = const JsonEncoder.withIndent('  ').convert(prefsMap);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            const Text("Raw Preferences"),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: prefsJson));
                showToast(dialogContext, "Copied to clipboard");
              },
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: SelectableText(
            prefsJson,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Clear All Data"),
        content: const Text(
          "This will delete all local data including cached information. "
          "You will need to sync again after this action. Are you sure?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                await ref
                    .read(developerOptionsNotifierProvider.notifier)
                    .clearAllLocalData();
                if (context.mounted) {
                  showToast(context, "✅ All local data cleared");
                }
                AnalyticsService.logEvent('clear_all_local_data');
              } catch (e) {
                if (context.mounted) {
                  showToast(context, "Failed to clear data: $e");
                }
              }
            },
            child: Text(
              "Clear",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
