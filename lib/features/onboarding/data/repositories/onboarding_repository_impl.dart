import 'package:bizzie/core/network/network_info.dart';
import 'package:bizzie/features/onboarding/data/datasources/dummy_price_data.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';

@LazySingleton(as: IOnboardingRepository)
class OnboardingRepositoryImpl implements IOnboardingRepository {
  final FirebaseFirestore _firestore;
  final FirebaseMessaging _firebaseMessaging;
  final NetworkInfo _networkInfo;

  OnboardingRepositoryImpl(
    this._firestore,
    this._firebaseMessaging,
    this._networkInfo,
  );

  @override
  Future<List<HistoricalPrice>> getSp500History() async {
    return dummyData.map((e) => HistoricalPrice.fromJson(e)).toList();
  }

  @override
  Future<(List<Brand>, List<Brand>)> getDailyBrands(Sector? userSector) async {
    try {
      if (await _networkInfo.isConnected) {
        final collection = _firestore.collection('daily_brands');

        // Fetch the latest daily brand document
        final snapshot = await collection
            .orderBy('date', descending: true)
            .limit(1)
            .get();

        if (snapshot.docs.isEmpty) {
          return _getMockBrands(userSector);
        }

        final data = snapshot.docs.first.data();
        final sectorsList = data['sectors'] as List<dynamic>? ?? [];

        List<Brand> globalBrands = [];
        List<Brand> sectorBrands = [];

        for (final sectorMap in sectorsList) {
          final sectorName = sectorMap['name'] as String? ?? '';
          final productsList = sectorMap['products'] as List<dynamic>? ?? [];

          final brands = productsList.map((p) {
            final pMap = p as Map<String, dynamic>;
            return Brand(
              name: pMap['name'] as String? ?? '',
              company: pMap['company'] as String? ?? '',
              ticker: pMap['ticker'] as String? ?? '',
              description: pMap['description'] as String? ?? '',
              sector: sectorName,
            );
          }).toList();

          if (sectorName == 'All Sectors') {
            globalBrands.addAll(brands);
          } else if (userSector != null &&
              sectorName.toLowerCase() ==
                  userSector.displayName.toLowerCase()) {
            sectorBrands.addAll(brands);
          }
        }

        return (globalBrands, sectorBrands);
      } else {
        return _getMockBrands(userSector);
      }
    } catch (e) {
      // Log error (should use a logger in real app)
      return _getMockBrands(userSector);
    }
  }

  (List<Brand>, List<Brand>) _getMockBrands(Sector? userSector) {
    // Fallback Mock Data
    final global = [
      Brand(
        name: 'Apple',
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
      // Add some generic mock brands based on sector just to show something
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
    // In a real app, this might come from RemoteConfig or API.
    // Converting the hardcoded logic to return Sectors.
    return Sector.values;
  }

  @override
  Future<List<Company>> getTickersFromBrands(String brandsText) async {
    // Dummy implementation as AI Service is removed
    // In a real scenario, this would call a backend endpoint
    await Future.delayed(const Duration(seconds: 1)); // Simulate latency

    // Simple mock logic: return some companies based on text presence, or just generic ones
    final List<Company> mockCompanies = [];
    final lowerText = brandsText.toLowerCase();

    if (lowerText.contains('apple')) {
      mockCompanies.add(const Company(ticker: 'AAPL', name: 'Apple Inc.'));
    }
    if (lowerText.contains('microsoft')) {
      mockCompanies.add(const Company(ticker: 'MSFT', name: 'Microsoft Corp.'));
    }
    if (lowerText.contains('google')) {
      mockCompanies.add(const Company(ticker: 'GOOGL', name: 'Alphabet Inc.'));
    }
    if (lowerText.contains('tesla')) {
      mockCompanies.add(const Company(ticker: 'TSLA', name: 'Tesla, Inc.'));
    }

    // Default if nothing matches
    if (mockCompanies.isEmpty) {
      mockCompanies.add(
        const Company(ticker: 'SPY', name: 'SPDR S&P 500 ETF Trust'),
      );
    }

    return mockCompanies;
  }

  @override
  Future<void> completeOnboarding({
    required OnboardingData data,
    required String uid,
    required String fcmToken,
  }) async {
    // 1. Prepare Data
    // UUID Generation
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

    // 2. Initial FCM Token Map
    Map<String, String> tokensMap = {};
    if (fcmToken.isNotEmpty) {
      tokensMap[deviceUuid] = fcmToken;
    }

    // 3. Subscription Logic (Topics)
    if (fcmToken.isNotEmpty) {
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

    // 4. Create User Document
    final userDocPath = _firestore.collection('users').doc(uid);

    final userMap = {
      'uid': uid,
      'name': data.firstName,
      'favoriteSector': data.selectedSector != null
          ? _sanitizeTopic(data.selectedSector!.displayName)
          : '',
      'favoriteSectorDisplay': data.selectedSector?.displayName ?? '',
      'watchlist': data.detectedCompanies.map((c) => c.toJson()).toList(),
      'investingExperience': data.investingExperience?.name ?? 'beginner',
      'createdAt': FieldValue.serverTimestamp(),
      'isSubscribed': false,
      'fcmTokens': tokensMap,
    };

    await userDocPath.set(userMap);
  }

  String _sanitizeTopic(String input) {
    return input
        .trim()
        .replaceAll(' ', '_')
        .replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '')
        .toLowerCase();
  }
}
