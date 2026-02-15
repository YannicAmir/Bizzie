import 'package:bizzie/features/watchlist/data/dtos/watchlist_api_dtos.dart';
import 'package:bizzie/features/watchlist/domain/enums/watchlist_badge_type.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WatchlistEventEvaluator {
  WatchlistEventStatus? evaluate({
    required WatchlistEarningsDto? earnings,
    required WatchlistFilingDto? filing,
  }) {
    if (earnings != null) {
      final now = DateTime.now();
      final isExpired =
          earnings.expireAt != null && now.isAfter(earnings.expireAt!);

      if (!isExpired) {
        return WatchlistEventStatus(
          badgeText: 'Earnings',
          badgeType: WatchlistBadgeType.neutral,
          eventDate: earnings.date,
          lastUpdated: now,
        );
      }
    }

    if (filing != null) {
      String badgeText = filing.formType.toUpperCase();
      WatchlistBadgeType badgeType = WatchlistBadgeType.warning;

      if (filing.formType == '8-K') {
        if (filing.topic?.isNotEmpty ?? false) {
          badgeText = filing.topic!;
        } else {
          badgeText = '8-K';
        }
      }

      return WatchlistEventStatus(
        badgeText: badgeText,
        badgeType: badgeType,
        eventDate: filing.filingDate,
        lastUpdated: DateTime.now(),
      );
    }

    return null;
  }
}
