import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/provider/student_provider.dart';
import '../../utils/model/exam_schedule_model.dart';

class MyExamSchedule extends ConsumerStatefulWidget {
  const MyExamSchedule({super.key});

  @override
  ConsumerState<MyExamSchedule> createState() => _MyExamScheduleState();
}

class _MyExamScheduleState extends ConsumerState<MyExamSchedule>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  Future<void> refreshExamSchedule() async {
    await ref.read(studentProvider.notifier).refreshExamSchedule(ref);
  }

  Widget _buildTab(String label) {
    return Container(
      height: 40,
      width: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _tabController.index == _tabController.indexIsChanging
            ? Colors.orange.shade700
            : Colors.orange.shade300.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Tab(
          child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProvider);

    return Scaffold(
      appBar: AppBar(
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
                refreshExamSchedule();
              }
            },
          ),
        ],
        title: const Text('Exam Schedule'),
        bottom: TabBar(
          dividerColor: Theme.of(context).colorScheme.surface,
          labelPadding: const EdgeInsets.all(0),
          splashBorderRadius: BorderRadius.circular(14),
          labelStyle: const TextStyle(fontSize: 18),
          unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
          labelColor: Theme.of(context).colorScheme.surface,
          controller: _tabController,
          indicator: BoxDecoration(
            color: Colors.orange.shade700,
            borderRadius: BorderRadius.circular(18),
          ),
          splashFactory: InkRipple.splashFactory,
          overlayColor: WidgetStateColor.resolveWith(
            (states) => Colors.orange.shade100,
          ),
          tabs: [
            _buildTab("CAT - 1"),
            _buildTab("CAT - 2"),
            _buildTab("FAT"),
          ],
        ),
      ),
      body: studentState.when(
        data: (student) {
          if (student.examSchedule[0].isError) {
            return Center(
              child: Text(student.examSchedule[0].errorMessage!),
            );
          }
          return TabBarView(
            controller: _tabController,
            children: [
              _buildExamList(student.examSchedule, 'CAT1'),
              _buildExamList(student.examSchedule, 'CAT2'),
              _buildExamList(student.examSchedule, 'FAT'),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildExamList(List<ExamSchedule> examSchedules, String examType) {
    final filteredSchedules = examSchedules
        .where((schedule) => schedule.examType == examType)
        .expand((schedule) => schedule.subjects)
        .toList();

    if (filteredSchedules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/lottie/cat_sleep.json',
              frameRate: const FrameRate(60),
              width: 120,
            ),
            Text(
              textAlign: TextAlign.center,
              'Timetable not yet available for $examType',
              style: const TextStyle(fontSize: 14),
            ),
            TextButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text(
                "Refresh",
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: filteredSchedules.length,
      itemBuilder: (context, index) {
        final exam = filteredSchedules[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          exam.courseTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        exam.date,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: [
                      _buildDetailChip('Code', exam.courseCode),
                      _buildDetailChip('Slot', exam.slot),
                      _buildDetailChip('Time', exam.examTime),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: [
                      _buildDetailChip('Session', exam.session),
                      _buildDetailChip('Venue', exam.venue),
                      _buildDetailChip('Seat', exam.seatNumber),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
