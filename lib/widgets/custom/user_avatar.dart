import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/provider/student_provider.dart';

class UserAvatar extends ConsumerStatefulWidget {
  const UserAvatar({super.key});

  @override
  ConsumerState<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends ConsumerState<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProvider);
    return studentState.when(data: (student) {
      return CircleAvatar(
        radius: 60,
        backgroundImage: AssetImage(student.pfpPath),
      );
    }, error: (error, stackTrace) {
      return CircleAvatar(
        radius: 60,
        backgroundImage: AssetImage('assets/images/pfp/default.png'),
      );
    }, loading: () {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: CircularProgressIndicator(),
      );
    });
  }
}
