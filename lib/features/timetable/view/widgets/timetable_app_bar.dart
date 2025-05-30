import 'package:flutter/material.dart';

class TimetableAppBar extends SliverAppBar {
  TimetableAppBar({
    super.key,
    required BuildContext context,
    required int classesCount,
    required VoidCallback onRefresh,
  }) : super(
          expandedHeight: 90,
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
              onSelected: (value) => value == 0 ? onRefresh() : null,
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Timetable",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    classesCount == 0
                        ? "No classes today"
                        : "You have $classesCount classes Today",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
