import 'package:bizzie/core/data/dtos/onboarding_skip_config.dart';
import 'package:bizzie/features/onboarding/data/dtos/historical_price_dto.dart';
import 'package:bizzie/features/onboarding/data/dtos/onboarding_profile_update_dto.dart';
import 'package:bizzie/core/data/dtos/user_dto.dart';
import 'package:bizzie/core/data/dtos/watchlist_item_dto.dart';

abstract class IOnboardingRemoteDataSource {
  Future<bool> userProfileExists(String uid);

  Future<void> saveUserProfile(
    UserDto user,
    List<WatchlistItemDto> watchlistItems, {
    bool awaitServerAck = true,
  });

  Future<void> updateOnboardingProfile(
    String uid,
    OnboardingProfileUpdateDto update, {
    bool awaitServerAck = true,
  });

  bool getOnboardingConfig(String key);
  List<String> getStockMarketSectors();
  OnboardingSkipConfig getOnboardingSkipConfig();
  List<HistoricalPriceDto> getSp500History();
}
