import 'package:url_launcher/url_launcher.dart';

void directToWeb(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}
