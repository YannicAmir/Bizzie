import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/onboarding/data/datasources/dummy_price_data.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';

import 'package:bizzie/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:bizzie/features/onboarding/data/dtos/user_dto.dart';

@LazySingleton(as: IOnboardingRepository)
class OnboardingRepositoryImpl implements IOnboardingRepository {
  final IOnboardingRemoteDataSource _remoteDataSource;
  final FirebaseMessaging _firebaseMessaging;
  final _logger = BizzieLogger('OnboardingRepositoryImpl');

  OnboardingRepositoryImpl(this._remoteDataSource, this._firebaseMessaging);

  @override
  Future<List<HistoricalPrice>> getSp500History() async {
    return dummyData.map((e) => HistoricalPrice.fromJson(e)).toList();
  }

  @override
  Future<(List<Brand>, List<Brand>)> getDailyBrands(Sector? userSector) async {
    _logger.info('DEBUG: Repository getDailyBrands called');
    final dailyBrandsDto = await _remoteDataSource.fetchDailyBrands();

    if (dailyBrandsDto == null) {
      _logger.warning('DEBUG: dailyBrandsDto is NULL - using mocks');
      return _getMockBrands(userSector);
    }

    _logger.info(
      'DEBUG: DTO Sectors found: ${dailyBrandsDto.sectors.map((s) => s.name).toList()}',
    );
    _logger.info('DEBUG: User Sector: ${userSector?.displayName}');

    final globalBrands = <Brand>[];
    final sectorBrands = <Brand>[];

    for (final sectorDto in dailyBrandsDto.sectors) {
      final brands = sectorDto.products.map((p) {
        return Brand(
          name: p.name,
          company: p.company,
          ticker: p.ticker,
          sector: sectorDto.name,
          description: p.description,
        );
      }).toList();

      if (sectorDto.name == 'All Sectors') {
        globalBrands.addAll(brands);
      } else if (userSector != null &&
          sectorDto.name == userSector.displayName) {
        sectorBrands.addAll(brands);
      }
    }

    return (globalBrands, sectorBrands);
  }

  (List<Brand>, List<Brand>) _getMockBrands(Sector? userSector) {
    final global = [
      Brand(
        name: 'iPhone',
        company: 'Apple Inc.',
        ticker: 'AAPL',
        sector: 'Information Technology',
        description: 'Tech Giant',
      ),
      Brand(
        name: 'Tesla',
        company: 'Tesla Inc.',
        ticker: 'TSLA',
        sector: 'Consumer Discretionary',
        description: 'EV Manufacturer',
      ),
      Brand(
        name: 'Nike',
        company: 'Nike Inc.',
        ticker: 'NKE',
        sector: 'Consumer Discretionary',
        description: 'Sportswear',
      ),
      Brand(
        name: 'Coca-Cola',
        company: 'The Coca-Cola Company',
        ticker: 'KO',
        sector: 'Consumer Staples',
        description: 'Beverage',
      ),
      Brand(
        name: 'Netflix',
        company: 'Netflix Inc.',
        ticker: 'NFLX',
        sector: 'Communication Services',
        description: 'Streaming',
      ),
    ];

    final sectorSpecific = <Brand>[];
    if (userSector != null) {
      sectorSpecific.add(
        Brand(
          name: '${userSector.displayName} Brand A',
          company: 'Company A',
          ticker: 'AAA',
          sector: userSector.displayName,
          description: 'Mock Description',
        ),
      );
      sectorSpecific.add(
        Brand(
          name: '${userSector.displayName} Brand B',
          company: 'Company B',
          ticker: 'BBB',
          sector: userSector.displayName,
          description: 'Mock Description',
        ),
      );
      sectorSpecific.add(
        Brand(
          name: '${userSector.displayName} Consumer',
          company: 'Company C',
          ticker: 'CCC',
          sector: userSector.displayName,
          description: 'Mock Description',
        ),
      );
    }

    return (global, sectorSpecific);
  }

  @override
  Future<List<Sector>> getSectors() async {
    final sectorStrings = _remoteDataSource.getStockMarketSectors();
    return sectorStrings
        .map((s) => Sector.fromString(s))
        .whereType<Sector>()
        .toList();
  }

  @override
  Future<void> completeOnboarding({
    required OnboardingData data,
    required String uid,
  }) async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceUuid;
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceUuid = iosInfo.identifierForVendor ?? 'unknown_ios_device';
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceUuid = androidInfo.id;
    } else {
      deviceUuid = 'unknown_platform_device';
    }

    String? fcmToken;
    try {
      fcmToken = await _firebaseMessaging.getToken();
    } catch (e) {
      _logger.severe('Failed to fetch FCM token: $e');
    }

    Map<String, String> tokensMap = {};
    if (fcmToken != null && fcmToken.isNotEmpty) {
      tokensMap[deviceUuid] = fcmToken;
    }

    if (fcmToken != null && fcmToken.isNotEmpty) {
      final selectedSector = data.selectedSector;
      if (selectedSector != null) {
        final sanitizedSector = _sanitizeTopic(selectedSector.displayName);
        if (sanitizedSector.isNotEmpty) {
          await _firebaseMessaging.subscribeToTopic(sanitizedSector);
        }
      }

      for (final company in data.detectedCompanies) {
        final sanitizedTicker = _sanitizeTopic(company.ticker);
        if (sanitizedTicker.isNotEmpty) {
          await _firebaseMessaging.subscribeToTopic(sanitizedTicker);
        }
      }
    }

    final userDto = UserDto(
      uid: uid,
      name: data.firstName,
      favoriteSector: data.selectedSector != null
          ? _sanitizeTopic(data.selectedSector!.displayName)
          : '',
      favoriteSectorDisplay: data.selectedSector?.displayName ?? '',
      watchlist: data.detectedCompanies.map((c) => c.toJson()).toList(),
      investingExperience: data.investingExperience?.name ?? 'beginner',
      isSubscribed: false,
      fcmTokens: tokensMap,
    );

    await _remoteDataSource.saveUserProfile(userDto);
  }

  String _sanitizeTopic(String input) {
    return input
        .trim()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '')
        .toLowerCase();
  }
}
