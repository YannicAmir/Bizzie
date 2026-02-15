import 'package:bizzie/features/watchlist/data/dtos/watchlist_event_status_dto.dart';

abstract class IWatchlistEventsLocalDataSource {
  Future<Map<String, WatchlistEventStatusDto>> getCachedEvents();
  Future<void> cacheEvents(Map<String, WatchlistEventStatusDto> events);
}
