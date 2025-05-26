import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/home_app_bar.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/home_greeting.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserNotifierProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const HomeAppBar(),
          SliverToBoxAdapter(
            child: HomeGreeting(
              username: user?.profile.target?.studentName ?? "NaN",
            ),
          ),
        ],
      ),
    );
  }
}
