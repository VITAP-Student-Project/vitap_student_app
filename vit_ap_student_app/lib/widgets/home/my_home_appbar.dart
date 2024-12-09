import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import '../../pages/features/bottom_navigation_bar.dart';
import '../../pages/profile/account_page.dart';
import '../../utils/provider/student_provider.dart';

class MyHomeSliverAppBar extends StatefulWidget {
  const MyHomeSliverAppBar({super.key});

  @override
  _MyHomeSliverAppBarState createState() => _MyHomeSliverAppBarState();
}

class _MyHomeSliverAppBarState extends State<MyHomeSliverAppBar> {
  @override
  void initState() {
    super.initState();
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    type: PageTransitionType.fade,
                    child: const AccountPage(),
                  ),
                );
              },
              child: Consumer(
                builder: (context, ref, child) {
                  final studentState = ref.watch(studentProvider);
                  return studentState.when(
                    data: (student) {
                      return CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          student.pfpPath,
                        ),
                      );
                    },
                    error: (error, _) {
                      return CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/pfp/default.png',
                        ),
                      );
                    },
                    loading: () {
                      return CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          'assets/images/pfp/default.png',
                        ),
                      );
                    },
                  );
                },
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            type: PageTransitionType.fade,
                            child: MyBNB(
                              initialIndex: 1,
                            ),
                          ),
                        );
                      },
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
