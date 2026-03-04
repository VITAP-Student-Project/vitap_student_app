import 'package:package_info_plus/package_info_plus.dart';

Future<String> packageVersion() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
