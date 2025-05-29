import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/models/user.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/marks_detail_bottom_sheet.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/marks_viewmodel.dart';

class MarksPage extends ConsumerStatefulWidget {
  const MarksPage({super.key});

  @override
  ConsumerState<MarksPage> createState() => _MarksPageState();
}

class _MarksPageState extends ConsumerState<MarksPage> {
  DateTime? lastSynced;

  @override
  void initState() {
    super.initState();
     AnalyticsService.logScreen('MarksPage');
    loadLastSynced();
  }

  Future<void> loadLastSynced() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastSyncedString = prefs.getString('marksLastSynced');
    if (lastSyncedString != null) {
      setState(() {
        lastSynced = DateTime.parse(lastSyncedString);
      });
    }
  }

  Future<void> saveLastSynced() async {
    if (lastSynced != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('marksLastSynced', lastSynced!.toIso8601String());
    }
  }

  Future<void> refreshMarksData() async {
    ref.watch(marksViewModelProvider.notifier).refreshMarks();
    await AnalyticsService.logEvent('refresh_marks');
    saveLastSynced();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(currentUserNotifierProvider);

    final isLoading = ref
        .watch(marksViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      marksViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {},
          loading: () {},
          error: (error, st) {
            showSnackBar(
              context,
              error.toString(),
              SnackBarType.error,
            );
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Marks",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Refresh",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 0) {
                refreshMarksData();
              }
            },
          ),
        ],
      ),
      body: isLoading ? Loader() : _buildBody(user),
    );
  }

  Widget _buildBody(User? user) {
    if (user == null) {
      return _errorMarksContent();
    }

    final marks = user.marks;
    if (marks.isEmpty) {
      return _emptyMarksContent();
    }

    return ListView.builder(
      itemCount: marks.length,
      itemBuilder: (context, index) {
        final course = marks[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: ListTile(
            isThreeLine: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
            tileColor: Theme.of(context).colorScheme.surfaceContainerLow,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  course.courseTitle,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                course.courseType.contains("Theory")
                    ? Image.asset(
                        "assets/images/icons/theory.png",
                        height: 24,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Image.asset(
                          "assets/images/icons/lab.png",
                          height: 24,
                        ),
                      ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  course.faculty,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              course.courseCode,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            onTap: () {
              showMarksDetailBottomSheet(course, context);
            },
          ),
        );
      },
    );
  }

  // TODO: Isolate this with an issue button for unexpected behavior
  Widget _errorMarksContent() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Lottie.asset(
              'assets/images/lottie/404_astronaut.json',
              frameRate: const FrameRate(60),
              width: 250,
            ),
          ),
          const Text(
            'Oops!',
            style: TextStyle(fontSize: 32),
          ),
          const Text(
            'Page not found',
            style: TextStyle(fontSize: 32),
          ),
          const Text(
            'The page you are looking for does not exist or some other error occurred',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  // TODO: Isolate this empty widget
  Widget _emptyMarksContent() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/images/lottie/empty.json',
              frameRate: const FrameRate(60),
              width: 275,
            ),
          ),
          Text(
            'Marks not found',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            'Keep calm and come back later! 🕒😌',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
