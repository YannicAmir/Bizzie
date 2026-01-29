import 'package:bizzie/features/onboarding/data/dtos/user_dto.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('OnboardingRemoteDataSource');

abstract class IOnboardingRemoteDataSource {
  Future<void> saveUserProfile(
    UserDto user,
    List<WatchlistItemDto> watchlistItems,
  );

  bool getOnboardingConfig(String key);
  List<String> getStockMarketSectors();
}

@Injectable(as: IOnboardingRemoteDataSource)
class OnboardingRemoteDataSource implements IOnboardingRemoteDataSource {
  final FirestoreService _firestoreService;
  final ConfigService _configService;

  OnboardingRemoteDataSource(this._firestoreService, this._configService);

  @override
  bool getOnboardingConfig(String key) {
    return _configService.getBool(key);
  }

  @override
  List<String> getStockMarketSectors() {
    return _configService.stockMarketSectors;
  }

  @override
  Future<void> saveUserProfile(
    UserDto user,
    List<WatchlistItemDto> watchlistItems,
  ) async {
    _logger.info('Starting user profile save for UID: ${user.uid}');
    try {
      final batch = _firestoreService.batch();

      final userPath = 'users/${user.uid}';
      final userData = user.toJson();
      // Keep FieldValue dependency for now as it's SDK specific, but used via service batch
      userData['createdAt'] = FieldValue.serverTimestamp();

      batch.setRaw(path: userPath, data: userData);

      for (final item in watchlistItems) {
        final itemPath = '$userPath/watchlist/${item.ticker}';
        batch.setDocument<WatchlistItemDto>(
          path: itemPath,
          value: item,
          toJson: (i) => i.toJson(),
        );
      }

      await batch.commit();
      _logger.info(
        'Successfully saved user profile and ${watchlistItems.length} watchlist items',
      );
    } catch (e, s) {
      _logger.severe('Failed to save user profile for UID: ${user.uid}', e, s);
      rethrow;
    }
  }
}
