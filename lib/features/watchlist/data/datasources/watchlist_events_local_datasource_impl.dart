import 'dart:convert';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/watchlist/constants/watchlist_constants.dart';
import 'package:bizzie/features/watchlist/data/interfaces/i_watchlist_events_local_datasource.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_event_status_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _logger = BizzieLogger('WatchlistEventsLocalDataSource');

@LazySingleton(as: IWatchlistEventsLocalDataSource)
class WatchlistEventsLocalDataSourceImpl
    implements IWatchlistEventsLocalDataSource {
  final SharedPreferences _prefs;

  WatchlistEventsLocalDataSourceImpl(this._prefs);

  @override
  Future<Map<String, WatchlistEventStatusDto>> getCachedEvents() async {
    final jsonString = _prefs.getString(WatchlistConstants.eventsCacheKey);
    if (jsonString == null) return {};

    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      final events = jsonMap.map(
        (key, value) => MapEntry(
          key,
          WatchlistEventStatusDto.fromJson(value as Map<String, dynamic>),
        ),
      );

      _logger.info('Successfully retrieved ${events.length} events from cache');
      return events;
    } catch (e, stack) {
      _logger.severe(
        'Failed to decode watchlist events cache. Clearing corrupted data.',
        e,
        stack,
      );
      await _prefs.remove(WatchlistConstants.eventsCacheKey);
      return {};
    }
  }

  @override
  Future<void> cacheEvents(Map<String, WatchlistEventStatusDto> events) async {
    try {
      final jsonMap = events.map((key, value) => MapEntry(key, value.toJson()));
      await _prefs.setString(
        WatchlistConstants.eventsCacheKey,
        jsonEncode(jsonMap),
      );
      _logger.info('Successfully cached ${events.length} events');
    } catch (e, stack) {
      _logger.severe('Failed to cache watchlist events', e, stack);
    }
  }
}
