import 'package:flutter/material.dart';

/// A reusable tab bar widget for filtering between Theory and Lab courses
class CourseTypeTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;

  const CourseTypeTabBar({
    super.key,
    required this.controller,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  Widget _buildTab(BuildContext context, String label, String iconPath) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .secondaryContainer
            .withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TabBar(
        controller: controller,
        isScrollable: false,
        dividerColor: Theme.of(context).colorScheme.surface,
        labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        splashBorderRadius: BorderRadius.circular(14),
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        unselectedLabelColor:
            Theme.of(context).colorScheme.onSecondaryContainer,
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
          _buildTab(context, "Theory", "assets/images/icons/theory.png"),
          _buildTab(context, "Lab", "assets/images/icons/lab.png"),
        ],
      ),
    );
  }
}
