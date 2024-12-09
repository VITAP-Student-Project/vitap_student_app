import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/provider/student_provider.dart';

class MyHomeSliverGreeting extends ConsumerStatefulWidget {
  const MyHomeSliverGreeting({super.key});

  @override
  _MyHomeSliverGreetingState createState() => _MyHomeSliverGreetingState();
}

class _MyHomeSliverGreetingState extends ConsumerState<MyHomeSliverGreeting> {
  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProvider);
    return studentState.when(
      data: (studentData) {
        final String _username = studentData.profile.studentName;
        return SliverToBoxAdapter(
          child: _buildGreeting(context, _username),
        );
      },
      loading: () {
        return SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
      error: (error, stack) {
        return SliverToBoxAdapter(
          child: _buildGreeting(context, "null"),
        );
      },
    );
  }

  Widget _buildGreeting(BuildContext context, String _username) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello 👋,",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  '$_username',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
