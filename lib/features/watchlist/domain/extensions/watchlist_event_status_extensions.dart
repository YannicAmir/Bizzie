import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';

extension WatchlistEventStatusAnalyticsExtensions on WatchlistEventStatus {
  String get analyticsEventText {
    if (badgeText.length > 24) {
      return '${badgeText.substring(0, 21)}...';
    }
    return badgeText;
  }

  bool get isUpcoming {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);
    return !eventDay.isBefore(today);
  }
}
