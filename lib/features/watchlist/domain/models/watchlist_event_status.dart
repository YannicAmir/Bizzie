import 'package:bizzie/features/watchlist/domain/enums/watchlist_badge_type.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_event_status.freezed.dart';

@freezed
abstract class WatchlistEventStatus with _$WatchlistEventStatus {
  const factory WatchlistEventStatus({
    required String badgeText,
    required WatchlistBadgeType badgeType,
    required DateTime eventDate,
    required DateTime lastUpdated,
  }) = _WatchlistEventStatus;

  factory WatchlistEventStatus.fromUpcomingEarnings(UpcomingEarnings earnings) {
    return WatchlistEventStatus(
      badgeText: 'Earnings',
      badgeType: WatchlistBadgeType.neutral,
      eventDate: earnings.date ?? DateTime.now(),
      lastUpdated: DateTime.now(),
    );
  }
}
