part of 'init_dependencies.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await initObjectBox();
  await initServices();
  await RustLib.init();

  // Dotenv
  await dotenv.load(fileName: '.env');

  // Init Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  serviceLocator.registerSingleton<SupabaseRepository>(
    SupabaseRepository(
      Supabase.instance.client,
      serviceLocator<SecureStorageService>(),
      serviceLocator<Store>(),
    ),
  );

  await HomeWidget.setAppGroupId('group.com.udhay.vitapstudentapp');

  await NotificationService.initialize();

  // Block Landscape View
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  // explicitly restore the status bar after initialization
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  // Init Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (!e.toString().contains('duplicate-app')) {
      print('Firebase init error: $e');
    }
  }

  // Register analytics and honour the persisted opt-out before anything is
  // able to log. The store is already open, so preferences can be read
  // directly rather than waiting for the Riverpod container.
  final analytics = FirebaseAnalyticsService();
  serviceLocator.registerSingleton<AnalyticsService>(analytics);
  final storedPreferences = serviceLocator<Store>()
      .box<UserPreferences>()
      .query()
      .build()
      .findFirst();
  await analytics.initialize(
    enabled: storedPreferences?.analyticsEnabled ?? true,
  );

  // Register the InterceptedClient
  serviceLocator.registerSingleton<http.Client>(Client());

  // Register SSL client that trusts the VTOP server certificate
  serviceLocator.registerSingleton<IOClient>(
    IOClient(
      HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) =>
                host == ServerConstants.vtopDomain,
    ),
  );

  // Initialize Timezone
  tzlt.initializeTimeZones();
  final kolkata = tz.getLocation('Asia/Kolkata');
  tz.setLocalLocation(kolkata);
}

Future<void> initObjectBox() async {
  final objectbox = await ObjectBox.create();
  serviceLocator.registerSingleton<Store>(objectbox.store);
}

Future<void> initServices() async {
  serviceLocator.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(),
  );

  serviceLocator.registerSingleton<SecureStorageService>(
    SecureStorageService(serviceLocator<FlutterSecureStorage>()),
  );

  serviceLocator.registerSingleton<VtopClientService>(VtopClientService());

  // Hydrate the demo-mode flag so it can be read synchronously everywhere.
  await DemoService.init();

  serviceLocator.registerSingleton<ConnectionChecker>(
    ConnectionCheckerImpl(InternetConnection()),
  );
}
