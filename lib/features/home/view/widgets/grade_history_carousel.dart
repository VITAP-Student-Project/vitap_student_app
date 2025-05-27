import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/models/grade_history.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';

class GradeHistoryCarousel extends ConsumerStatefulWidget {
  const GradeHistoryCarousel({super.key});

  @override
  MyGradesTileState createState() => MyGradesTileState();
}

class MyGradesTileState extends ConsumerState<GradeHistoryCarousel> {
  Map<String, dynamic>? gradesMap;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPrivacyModeEnabled = false; //ref.watch(privacyModeProvider);

    if (isPrivacyModeEnabled) {
      return const SizedBox(height: 0);
    }

    final user = ref.watch(currentUserNotifierProvider);
    final GradeHistory? gradeHistory = user?.gradeHistory.target;

    if (gradeHistory == null) return const SizedBox.shrink();
    return _buildCreditsEarned(gradeHistory);
  }

  Widget _buildCreditsEarned(GradeHistory gradesHistory) {
    final cgpa = gradesHistory.cgpa;
    final creditsEarned =
        int.tryParse(gradesHistory.creditsEarned.split(".")[0]) ?? 0;
    final creditsRegistered =
        int.tryParse(gradesHistory.creditsRegistered.split(".")[0]) ?? 0;

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Theme.of(context).colorScheme.surfaceContainerLow,
            ),
            width: 170,
            height: 125,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0)
                  _buildTileContent(
                      context, cgpa.toString(), 'Overall CGPA earned')
                else if (index == 1)
                  _buildTileContent(context, creditsEarned.toString(),
                      'Overall credits earned')
                else if (index == 2)
                  _buildTileContent(context, creditsRegistered.toString(),
                      'Overall credits registered'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTileContent(BuildContext context, String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 44,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
