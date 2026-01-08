import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/utils/string_utils.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/watchlist/data/datasources/watchlist_local_datasource.dart';
import 'package:bizzie/features/watchlist/data/datasources/watchlist_remote_datasource.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IWatchlistRepository)
class WatchlistRepositoryImpl implements IWatchlistRepository {
  final IWatchlistRemoteDataSource _remoteDataSource;
  final IWatchlistLocalDataSource _localDataSource;
  final FirebaseMessaging _firebaseMessaging;
  final _logger = BizzieLogger('WatchlistRepositoryImpl');

  WatchlistRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._firebaseMessaging,
  );

  @override
  Future<Either<Failure, void>> addToWatchlist(
    Company company,
    String uid,
  ) async {
    try {
      final dto = WatchlistItemDto.fromDomain(company);

      await _remoteDataSource.addWatchlistItem(dto, uid);

      final topic = StringUtils.sanitizeTicker(company.ticker);
      if (topic.isNotEmpty) {
        await _firebaseMessaging.subscribeToTopic(topic);
      }

      final currentList = _localDataSource.getSubscribedTickers();
      if (!currentList.contains(company.ticker)) {
        final newList = List<String>.from(currentList)..add(company.ticker);
        await _localDataSource.cacheSubscribedTickers(newList);
      }

      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to add to watchlist: ${company.ticker}', e, stack);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWatchlist(
    String ticker,
    String uid,
  ) async {
    try {
      await _remoteDataSource.removeWatchlistItem(ticker, uid);

      final topic = StringUtils.sanitizeTicker(ticker);
      if (topic.isNotEmpty) {
        await _firebaseMessaging.unsubscribeFromTopic(topic);
      }

      final currentList = _localDataSource.getSubscribedTickers();
      if (currentList.contains(ticker)) {
        final newList = List<String>.from(currentList)..remove(ticker);
        await _localDataSource.cacheSubscribedTickers(newList);
      }

      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to remove from watchlist: $ticker', e, stack);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncSubscriptions(
    List<String> activeTickers,
  ) async {
    try {
      final localTickers = _localDataSource.getSubscribedTickers();
      final remoteTickers = activeTickers;

      final toSubscribe = remoteTickers.where((t) => !localTickers.contains(t));
      for (final ticker in toSubscribe) {
        final topic = StringUtils.sanitizeTicker(ticker);
        if (topic.isNotEmpty) {
          await _firebaseMessaging.subscribeToTopic(topic);
        }
      }

      final toUnsubscribe = localTickers.where(
        (t) => !remoteTickers.contains(t),
      );
      for (final ticker in toUnsubscribe) {
        final topic = StringUtils.sanitizeTicker(ticker);
        if (topic.isNotEmpty) {
          await _firebaseMessaging.unsubscribeFromTopic(topic);
        }
      }

      await _localDataSource.cacheSubscribedTickers(remoteTickers);

      return const Right(null);
    } catch (e, stack) {
      _logger.severe('Failed to sync watchlist subscriptions', e, stack);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Company>>> getWatchlistStream(String uid) {
    return _remoteDataSource.getWatchlistStream(uid).map((dtos) {
      try {
        final companies = dtos.map((dto) => dto.toDomain()).toList();
        return Right(companies);
      } catch (e, stack) {
        _logger.severe('Failed to map watchlist stream', e, stack);
        return Left(ServerFailure(e.toString()));
      }
    });
  }
}
