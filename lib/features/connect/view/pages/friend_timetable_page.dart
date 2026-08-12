import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vit_ap_student_app/core/models/timetable.dart';
import 'package:vit_ap_student_app/features/timetable/view/widgets/schedule_list.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/connect/utils/time_sync_calculator.dart';

class FriendTimetablePage extends ConsumerStatefulWidget {
  final String friendName;
  final String friendRegNo;
  final Timetable timetable;

  const FriendTimetablePage({
    super.key,
    required this.friendName,
    required this.friendRegNo,
    required this.timetable,
  });

  @override
  ConsumerState<FriendTimetablePage> createState() => _FriendTimetablePageState();
}

class _FriendTimetablePageState extends ConsumerState<FriendTimetablePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _viewMode = 0; // 0 for Timetable, 1 for Common Free Time

  @override
  void initState() {
    super.initState();
    final int currentDayIndex = DateTime.now().weekday % 7;
    _tabController = TabController(
      length: 7,
      vsync: this,
      initialIndex: currentDayIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _getTodayClassesCount(Timetable timetable) {
    final day = DateFormat('EEEE').format(DateTime.now());
    return (timetable.toJson()[day] as List<dynamic>?)?.length ?? 0;
  }

  Widget _buildTab(String label) {
    return Container(
      height: 40,
      width: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Tab(child: Text(label, style: const TextStyle())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: true,
              expandedHeight: 75,
              centerTitle: false,
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.friendName}\'s Timetable',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _getTodayClassesCount(widget.timetable) == 0
                        ? 'No classes today'
                        : 'They have ${_getTodayClassesCount(widget.timetable)} classes Today',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(value: 0, label: Text('Their Timetable'), icon: Icon(Iconsax.calendar_1_copy)),
                      ButtonSegment(value: 1, label: Text('Common Free Time'), icon: Icon(Iconsax.clock_copy)),
                    ],
                    selected: {_viewMode},
                    onSelectionChanged: (Set<int> newSelection) {
                      setState(() {
                        _viewMode = newSelection.first;
                      });
                    },
                    style: SegmentedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      selectedBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      selectedForegroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  dividerColor: Theme.of(context).colorScheme.surface,
                  labelPadding: const EdgeInsets.all(0),
                  splashBorderRadius: BorderRadius.circular(14),
                  labelStyle: const TextStyle(fontSize: 18),
                  unselectedLabelColor: Theme.of(context).colorScheme.onSecondaryContainer,
                  labelColor: Theme.of(context).colorScheme.onSecondaryContainer,
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  splashFactory: InkRipple.splashFactory,
                  overlayColor: WidgetStateColor.resolveWith(
                    (states) => Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  tabs: [
                    _buildTab('S'),
                    _buildTab('M'),
                    _buildTab('T'),
                    _buildTab('W'),
                    _buildTab('T'),
                    _buildTab('F'),
                    _buildTab('S'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          children: [
            _buildContentForDay('Sunday'),
            _buildContentForDay('Monday'),
            _buildContentForDay('Tuesday'),
            _buildContentForDay('Wednesday'),
            _buildContentForDay('Thursday'),
            _buildContentForDay('Friday'),
            _buildContentForDay('Saturday'),
          ],
        ),
      ),
    );
  }

  Widget _buildContentForDay(String day) {
    if (_viewMode == 0) {
      return ScheduleList(day: day, overrideTimetable: widget.timetable);
    } else {
      final user = ref.watch(currentUserProvider);
      final myTimetable = user?.timetable.target;
      if (myTimetable == null) {
        return const Center(child: Text('Your timetable is not synced locally.'));
      }
      
      final freeBlocks = TimeSyncCalculator.getCommonFreeTime(myTimetable, widget.timetable, day);
      
      if (freeBlocks.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.clock_copy, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
              const SizedBox(height: 16),
              Text('No Common Free Time', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('You both are completely busy on $day.', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemCount: freeBlocks.length,
        itemBuilder: (context, index) {
          final block = freeBlocks[index];
          // Calculate duration for visualization
          final durationMins = block.endMinute - block.startMinute;
          final durationText = durationMins >= 60 
              ? '${durationMins ~/ 60}h ${durationMins % 60 > 0 ? '${durationMins % 60}m' : ''}'
              : '${durationMins}m';

          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Iconsax.clock_copy, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Common Free Time',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          block.formattedTime,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      durationText,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
