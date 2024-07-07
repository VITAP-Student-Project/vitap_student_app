import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/widgets/timetable/my_tab_bar.dart';
import '../../utils/api/timetable_api.dart';
import '../../utils/provider/timetable_provider.dart';
import 'bottom_navigation_bar.dart';

class TimeTablePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Watch the timetableProvider
    final timetable = ref.watch(timetableProvider);

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 90,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBNB()),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              iconSize: 20,
            ),
            actions: [
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      "Refresh",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    value: 0,
                  ),
                ],
                onSelected: (value) {
                  if (value == 0) {
                    fetchTimetable("23BCE7625", "v+v2no@tOw", "AP2023247", ref);
                  }
                },
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Timetable",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "You have 3 classes Today",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 900,
                      width: MediaQuery.of(context).size.width,
                      child: DaysTabBar(),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
