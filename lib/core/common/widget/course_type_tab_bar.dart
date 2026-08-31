import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/common/widget/app_tab_bar.dart';

/// The attendance page's tab bar.
///
/// Defaults to Theory and Lab. [tabs] is passed explicitly when the student has
/// something extra to show — a capstone or SDP registration adds a tab, and
/// only then.
class CourseTypeTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Optional: left null, the bar attaches to the nearest
  /// [DefaultTabController].
  final TabController? controller;
  final List<String> tabs;

  const CourseTypeTabBar({
    super.key,
    this.controller,
    this.tabs = const ['Theory', 'Lab'],
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppTabBar(controller: controller, tabs: tabs);
  }
}
