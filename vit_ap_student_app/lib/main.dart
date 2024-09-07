import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/utils/api/firebase_messaging_api.dart';
import 'package:wiredash/wiredash.dart';
import 'pages/onboarding/onboarding_page.dart';
import 'pages/features/home_page.dart';
import 'pages/features/login_page.dart';
import 'pages/features/bottom_navigation_bar.dart';
import 'pages/features/profile_page.dart';
import 'utils/auth/user_auth.dart';
import 'utils/provider/providers.dart';
import 'utils/provider/theme_provider.dart';
import 'pages/quick_access/biometric_page.dart';
import 'firebase_options.dart';
import 'utils/services/notification_service.dart';
import 'utils/services/schedule_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await MobileAds.instance.initialize();
  NotificationService notiService = await NotificationService();
  notiService.initNotifications();
  await FirebaseMsgApi().initNotifications();
  await dotenv.load(fileName: "assets/.env");

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timetable = ref.read(timetableProvider);
    if (timetable.isNotEmpty) {
      scheduleClassNotifications(ref);
    }
    final theme = ref.watch(themeProvider);
    return Wiredash(
      projectId: 'vit-ap-student-app-uh1uuvl',
      secret: dotenv.env['WIREDASH_SECRET_KEY']!,
      child: MaterialApp(
        themeAnimationCurve: Curves.easeInOut,
        debugShowCheckedModeBanner: false,
        theme: theme,
        title: 'VIT-AP Student App',
        home: AuthPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/main': (context) => const MyBNB(),
          '/home': (context) => HomePage(),
          '/gettingstarted': (context) => const GettingStartedPage(),
          '/profile': (context) => const ProfilePage(),
          '/biometric': (context) => const BiometricPage(),
        },
      ),
    );
  }
}
