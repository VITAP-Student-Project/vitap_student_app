import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:vit_ap_student_app/core/common/widget/bottom_navigation_bar.dart';
import 'package:vit_ap_student_app/core/providers/current_user.dart';
import 'package:vit_ap_student_app/core/providers/theme_mode_notifier.dart';
import 'package:vit_ap_student_app/features/auth/view/pages/login_page.dart';
import 'package:vit_ap_student_app/init_dependencies.dart';
import 'package:wiredash/wiredash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HomeWidget.setAppGroupId('group.com.udhay.vitapstudentapp');
  // NotificationService notificationService = await NotificationService();
  // notificationService.initNotifications();

  await initDependencies();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // _initializeNotifications();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // NotificationManager.dispose();
    super.dispose();
  }

  // Future<void> _initializeNotifications() async {
  //   final studentState = ref.read(studentProvider);
  //   studentState.when(
  //     data: (student) async {
  //       final Timetable timetable = student.timetable;
  //       if (timetable == Timetable.empty()) {
  //         final notificationManager = NotificationManager();
  //         notificationManager.initialize(ref);
  //         NotificationManager.checkAndRefreshIfNeeded(ref);
  //       }
  //     },
  //     error: (error, _) {},
  //     loading: () {},
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn =
        ref.read(currentUserNotifierProvider.notifier).isLoggedIn;
        final themeMode = ref.watch(themeModeProvider);
    return Wiredash(
      projectId: 'vit-ap-student-app-uh1uuvl',
      secret: dotenv.env['WIREDASH_SECRET_KEY']!,
      child: MaterialApp(
        themeAnimationCurve: Curves.easeInOut,
        debugShowCheckedModeBanner: false,
        theme: themeMode,
        title: 'VIT-AP Companion',
        home: isLoggedIn ? BottomNavBar() : LoginPage(),
      ),
    );
  }
}
