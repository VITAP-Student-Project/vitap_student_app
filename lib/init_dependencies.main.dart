part of 'init_dependencies.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await initObjectBox();
  await initServices();
  await RustLib.init();

  // Dotenv
  await dotenv.load(fileName: ".env");

  await HomeWidget.setAppGroupId('group.com.udhay.vitapstudentapp');

  await NotificationService.initialize();

  // Block Landscape View
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  // explicitly restore the status bar after initialization
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  // Init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Analytics
  await AnalyticsService.initialize();

  // Register the InterceptedClient
  serviceLocator.registerSingleton<http.Client>(Client());

  // Register ssl verification bypass client
  serviceLocator.registerSingleton<IOClient>(
    IOClient(
      HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true,
    ),
  );

  // Initialize Timezone
  tzlt.initializeTimeZones();
  var kolkata = tz.getLocation('Asia/Kolkata');
  tz.setLocalLocation(kolkata);
}

Future<void> initObjectBox() async {
  final objectbox = await ObjectBox.create();
  serviceLocator.registerSingleton<Store>(objectbox.store);
}

Future<void> initServices() async {
  serviceLocator.registerSingleton<FlutterSecureStorage>(
    FlutterSecureStorage(),
  );

  serviceLocator.registerSingleton<SecureStorageService>(
    SecureStorageService(serviceLocator<FlutterSecureStorage>()),
  );

  serviceLocator.registerSingleton<VtopClientService>(
    VtopClientService(),
  );
}
