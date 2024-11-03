import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:timeline_tile/timeline_tile.dart';

class MyExamSchedule extends StatefulWidget {
  const MyExamSchedule({super.key});

  @override
  State<MyExamSchedule> createState() => _MyExamScheduleState();
}

class _MyExamScheduleState extends State<MyExamSchedule>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> _examSchedule = {};
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadExamDetails();
    _tabController = TabController(length: 7, vsync: this, initialIndex: 0);
  }

  Future<void> _loadExamDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _examSchedule = jsonDecode(prefs.getString('exam_schedule') ?? '{}');
    });
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
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
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildExamTimeline('CAT1'),
            _buildExamTimeline('CAT2'),
            _buildExamTimeline('FAT'),
          ],
        ),
      ),
    );
  }

  Widget _buildExamTimeline(String examType) {
    final exams = _examSchedule[examType] as Map<String, dynamic>?;

    if (exams == null || exams.isEmpty) {
      return Center(
        child: Text(
          'No timetable found for $examType',
          style: const TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }

    final examList = exams.values.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: examList.length,
      itemBuilder: (context, index) {
        final exam = examList[index] as Map<String, dynamic>;
        final isFirst = index == 0;
        final isLast = index == examList.length - 1;

        return _buildTimelineTile(
          exam: exam,
          isFirst: isFirst,
          isLast: isLast,
        );
      },
    );
  }

  Widget _buildTimelineTile({
    required Map<String, dynamic> exam,
    required bool isFirst,
    required bool isLast,
  }) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.05,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
        iconStyle: IconStyle(
          fontSize: 5.0,
          iconData: Icons.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
        indicatorXY: 0.13,
        width: 12,
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 5),
      ),
      beforeLineStyle: LineStyle(
        color: Theme.of(context).colorScheme.tertiary,
        thickness: 1.5,
      ),
      endChild: Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.zero,
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${exam['date']} - ${exam['exam_time']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  exam['course_title'] ?? 'Unavailable',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  'Course Code: ${exam['course_code'] ?? '-'}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  'Venue: ${exam['venue'] ?? 'Unavailable'}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  'Seat Number: ${exam['seat_number'] ?? 'Unavailable'}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  'Session: ${exam['session'] ?? '-'} | Slot: ${exam['slot'] ?? '-'}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
