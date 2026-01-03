import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';

abstract class IOnboardingRepository {
  Future<List<Sector>> getSectors();

  Future<List<HistoricalPrice>> getSp500History();

  Future<(List<Brand>, List<Brand>)> getDailyBrands(Sector? userSector);

  /// Completes the onboarding process:
  /// 1. Creates the specific User document in Firestore.
  /// 2. Subscribes the user to relevant FCM topics foundation (Sector + Tickers).
  /// Note: This method does NOT handle Auth creation; that is handled by AuthRepository.
  /// It expects the Auth User ID to be available (or passed in).
  Future<void> completeOnboarding({
    required OnboardingData data,
    required String uid,
  });
}
