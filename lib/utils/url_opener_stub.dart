import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl(String link) async {
  return launchUrl(Uri.parse(link), mode: LaunchMode.platformDefault);
}
