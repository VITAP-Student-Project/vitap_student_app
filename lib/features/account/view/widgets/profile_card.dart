import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/models/user.dart';

class ProfileCard extends StatelessWidget {
  final User? user;
  const ProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/pfp/default.png',
              ),
            ),
            const SizedBox(height: 18),
            Text(
              user?.profile.target?.studentName ?? "N/A",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
              child: Text(
                user?.profile.target?.applicationNumber ?? "N/A",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
