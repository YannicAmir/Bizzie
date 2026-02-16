import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:url_launcher/url_launcher.dart';

final _logger = BizzieLogger('UrlLauncherUtils');

class UrlLauncherUtils {
  static Future<void> launch(
    String urlString, {
    LaunchMode mode = LaunchMode.externalApplication,
    void Function(String message)? onError,
  }) async {
    String finalUrl = urlString.trim();

    if (finalUrl.isEmpty) {
      _logger.warning('Launch failed: URL is empty');
      onError?.call('Link not available.');
      return;
    }

    if (!finalUrl.startsWith('http://') && !finalUrl.startsWith('https://')) {
      _logger.info('No scheme found, prepending https://');
      finalUrl = 'https://$finalUrl';
    }

    final Uri uri = Uri.parse(finalUrl);
    _logger.info('Attempting to launch: "$finalUrl"');

    try {
      final canLaunch = await canLaunchUrl(uri);

      if (canLaunch) {
        await launchUrl(uri, mode: mode);
      } else {
        _logger.warning(
          'canLaunchUrl returned false, attempting fallback launch',
        );
        final launched = await launchUrl(uri, mode: mode);
        if (!launched) {
          _logger.severe('Fallback launch failed');
          onError?.call('Could not open the link.');
        }
      }
    } catch (e) {
      _logger.severe('Exception during launch: $e');
      onError?.call('Error: $e');
    }
  }
}
