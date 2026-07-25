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

    final wrappedScheme = RegExp(
      r'^https?://([a-z][a-z0-9+.\-]*://.+)$',
      caseSensitive: false,
    ).firstMatch(finalUrl);
    if (wrappedScheme != null) {
      _logger.warning(
        'Detected wrapped URL scheme, unwrapping: "$finalUrl"',
      );
      finalUrl = wrappedScheme.group(1)!;
    }

    Uri? uri = Uri.tryParse(finalUrl);

    if (uri != null && !uri.hasScheme) {
      _logger.info('No scheme found, prepending https://');
      finalUrl = 'https://$finalUrl';
      uri = Uri.tryParse(finalUrl);
    }

    if (uri == null) {
      _logger.warning('Launch failed: could not parse URL "$finalUrl"');
      onError?.call('Could not open the link.');
      return;
    }

    _logger.info('Attempting to launch: "$finalUrl"');

    try {
      final canLaunch = await canLaunchUrl(uri);
      if (!canLaunch) {
        _logger.warning(
          'canLaunchUrl returned false, attempting launch anyway',
        );
      }

      final launched = await launchUrl(uri, mode: mode);
      if (!launched) {
        _logger.severe('Launch failed for "$finalUrl"');
        onError?.call('Could not open the link.');
      }
    } catch (e) {
      _logger.severe('Exception during launch: $e');
      onError?.call('Could not open the link.');
    }
  }
}
