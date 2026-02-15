import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/watchlist/constants/watchlist_constants.dart';
import 'package:bizzie/features/watchlist/data/interfaces/i_watchlist_events_local_datasource.dart';
import 'package:bizzie/features/watchlist/data/interfaces/i_watchlist_events_remote_datasource.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_api_dtos.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_event_status_dto.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/i_watchlist_events_repository.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/features/watchlist/domain/services/watchlist_event_evaluator.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('WatchlistEventsRepository');

@LazySingleton(as: IWatchlistEventsRepository)
class WatchlistEventsRepositoryImpl implements IWatchlistEventsRepository {
  final IWatchlistEventsLocalDataSource _localDataSource;
  final IWatchlistEventsRemoteDataSource _remoteDataSource;
  final WatchlistEventEvaluator _evaluator;

  WatchlistEventsRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._evaluator,
  );

  @override
  Future<Either<Failure, Map<String, WatchlistEventStatus>>> getWatchlistEvents(
    List<String> tickers,
  ) async {
    try {
      if (tickers.isEmpty) return right({});

      // 1. Identify what we have vs. what we need
      final cachedEventsDto = await _localDataSource.getCachedEvents();
      final validEvents = _getValidatedCache(tickers, cachedEventsDto);

      final tickersToFetch = tickers
          .where((t) => !validEvents.containsKey(t))
          .toList();

      Map<String, WatchlistEventStatusDto> finalEventsDto = Map.from(
        validEvents,
      );

      // 2. Fetch and merge remote data if needed
      if (tickersToFetch.isNotEmpty) {
        final remoteResults = await _fetchAndEvaluateRemote(tickersToFetch);
        finalEventsDto.addAll(remoteResults);

        // 3. Update cache with new results
        if (remoteResults.isNotEmpty) {
          await _localDataSource.cacheEvents(finalEventsDto);
        }
      }

      // 4. Map to Domain
      final domainEvents = finalEventsDto.map(
        (key, value) => MapEntry(key, value.toDomain()),
      );

      return right(domainEvents);
    } catch (e) {
      _logger.severe('Critical error in getWatchlistEvents', e);
      return left(Failure.server(e.toString()));
    }
  }

  /// Filters cached events based on TTL and identifies missing tickers.
  Map<String, WatchlistEventStatusDto> _getValidatedCache(
    List<String> tickers,
    Map<String, WatchlistEventStatusDto> cachedEventsDto,
  ) {
    final Map<String, WatchlistEventStatusDto> validEvents = {};
    final now = DateTime.now();

    for (final ticker in tickers) {
      final cached = cachedEventsDto[ticker];
      if (cached != null) {
        final age = now.difference(cached.lastUpdated);
        if (age < WatchlistConstants.eventCacheTtl) {
          validEvents[ticker] = cached;
        }
      }
    }

    return validEvents;
  }

  // Orchestrates remote fetching, evaluation, and mapping to DTOs.
  Future<Map<String, WatchlistEventStatusDto>> _fetchAndEvaluateRemote(
    List<String> tickers,
  ) async {
    try {
      final results = await Future.wait([
        _remoteDataSource.getUpcomingEarnings(tickers).catchError((e) {
          _logger.severe('Failed to fetch earnings', e);
          return <WatchlistEarningsDto>[];
        }),
        _remoteDataSource.getSecFilings(tickers).catchError((e) {
          _logger.severe('Failed to fetch filings', e);
          return <WatchlistFilingDto>[];
        }),
      ]);

      final earningsList = results[0] as List<WatchlistEarningsDto>;
      final filingsList = results[1] as List<WatchlistFilingDto>;

      final earningsMap = {for (var e in earningsList) e.symbol: e};
      final filingsMap = {for (var f in filingsList) f.symbol: f};

      final Map<String, WatchlistEventStatusDto> evaluated = {};

      for (final ticker in tickers) {
        final status = _evaluator.evaluate(
          earnings: earningsMap[ticker],
          filing: filingsMap[ticker],
        );

        if (status != null) {
          evaluated[ticker] = WatchlistEventStatusDto.fromDomain(status);
        }
      }

      return evaluated;
    } catch (e) {
      _logger.severe('Error in _fetchAndEvaluateRemote', e);
      return {};
    }
  }
}
