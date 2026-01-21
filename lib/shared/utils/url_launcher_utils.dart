import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static Future<void> launch(
    String urlString, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: mode);
    }
  }
}
