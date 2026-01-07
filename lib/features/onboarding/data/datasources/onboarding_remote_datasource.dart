import 'package:bizzie/features/onboarding/data/dtos/daily_brands_dto.dart';
import 'package:bizzie/features/onboarding/data/dtos/user_dto.dart';
import 'package:bizzie/features/watchlist/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class IOnboardingRemoteDataSource {
  Future<void> saveUserProfile(
    UserDto user,
    List<WatchlistItemDto> watchlistItems,
  );
  Future<DailyBrandsDto?> fetchDailyBrands();
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
    final batch = _firestoreService.instance.batch();

    final userRef = _firestoreService.instance
        .collection('users')
        .doc(user.uid);
    final userData = user.toJson();
    userData['createdAt'] = FieldValue.serverTimestamp();
    batch.set(userRef, userData);

    for (final item in watchlistItems) {
      final itemRef = userRef.collection('watchlist').doc(item.ticker);
      batch.set(itemRef, item.toJson());
    }

    await batch.commit();
  }

  @override
  Future<DailyBrandsDto?> fetchDailyBrands() async {
    final snapshot = await _firestoreService.instance
        .collection('daily_brands')
        .orderBy('date', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return DailyBrandsDto.fromJson(snapshot.docs.first.data());
  }
}
