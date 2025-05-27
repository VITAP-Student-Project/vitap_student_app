part of 'init_dependencies.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await initObjectBox();
  await initServices();

  // Dotenv
  await dotenv.load(fileName: "assets/.env");

  // Register HttpRequestInterceptor
  serviceLocator.registerSingleton<HttpRequestInterceptor>(
    HttpRequestInterceptor(),
  );

  // Register the InterceptedClient
  serviceLocator.registerSingleton<http.Client>(
    InterceptedClient.build(
      interceptors: [serviceLocator<HttpRequestInterceptor>()],
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
}
