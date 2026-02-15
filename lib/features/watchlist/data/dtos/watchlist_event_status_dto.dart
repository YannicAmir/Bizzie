import 'package:bizzie/features/watchlist/domain/enums/watchlist_badge_type.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_event_status_dto.freezed.dart';
part 'watchlist_event_status_dto.g.dart';

@freezed
abstract class WatchlistEventStatusDto with _$WatchlistEventStatusDto {
  const WatchlistEventStatusDto._();

  const factory WatchlistEventStatusDto({
    required String badgeText,
    required String badgeType, // Store enum as String
    required DateTime eventDate,
    required DateTime lastUpdated,
  }) = _WatchlistEventStatusDto;

  factory WatchlistEventStatusDto.fromJson(Map<String, dynamic> json) =>
      _$WatchlistEventStatusDtoFromJson(json);

  WatchlistEventStatus toDomain() {
    return WatchlistEventStatus(
      badgeText: badgeText,
      badgeType: WatchlistBadgeType.values.firstWhere(
        (e) => e.name == badgeType,
        orElse: () => WatchlistBadgeType.neutral,
      ),
      eventDate: eventDate,
      lastUpdated: lastUpdated,
    );
  }

  static WatchlistEventStatusDto fromDomain(WatchlistEventStatus domain) {
    return WatchlistEventStatusDto(
      badgeText: domain.badgeText,
      badgeType: domain.badgeType.name,
      eventDate: domain.eventDate,
      lastUpdated: domain.lastUpdated,
    );
  }
}
