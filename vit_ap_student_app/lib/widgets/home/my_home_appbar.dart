import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomeSliverAppBar extends StatefulWidget {
  const MyHomeSliverAppBar({super.key});

  @override
  _MyHomeSliverAppBarState createState() => _MyHomeSliverAppBarState();
}

class _MyHomeSliverAppBarState extends State<MyHomeSliverAppBar> {
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath =
          prefs.getString('pfpPath') ?? 'assets/images/pfp/default.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100,
      elevation: 0,
      automaticallyImplyLeading: false,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.2,
        centerTitle: true,
        titlePadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                _profileImagePath ?? 'assets/images/pfp/default.png',
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                      ),
                      splashRadius: 30,
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {},
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_none_outlined,
                        size: 20,
                      ),
                      splashRadius: 30,
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
