import 'dart:convert';
import 'package:bizzie/features/onboarding/data/datasources/dummy_price_data.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';

@LazySingleton(as: IOnboardingRepository)
class OnboardingRepositoryImpl implements IOnboardingRepository {
  final FirebaseFirestore _firestore;
  final FirebaseMessaging _firebaseMessaging;
  // We access RemoteConfig instance directly since we moved fetch to bootstrap
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  OnboardingRepositoryImpl(this._firestore, this._firebaseMessaging);

  @override
  Future<List<HistoricalPrice>> getSp500History() async {
    return dummyData.map((e) => HistoricalPrice.fromJson(e)).toList();
  }

  @override
  Future<List<String>> getSectors() async {
    // We assume fetchAndActivate() was called in bootstrap
    final jsonString = _remoteConfig.getString('stock_market_sectors');
    if (jsonString.isEmpty) {
      // Fallback
      return [
        "Technology",
        "Health Care",
        "Financials",
        "Real Estate",
        "Energy",
        "Materials",
        "Consumer Discretionary",
        "Industrials",
        "Utilities",
        "Consumer Staples",
        "Communication Services",
      ];
    }

    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((e) => e.toString()).toList();
    } catch (e) {
      return [];
    }
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
      final sanitizedSector = _sanitizeTopic(data.selectedSector);
      if (sanitizedSector.isNotEmpty) {
        await _firebaseMessaging.subscribeToTopic(sanitizedSector);
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
      'favoriteSector': _sanitizeTopic(data.selectedSector),
      'favoriteSectorDisplay': data.selectedSector,
      'watchlist': data.detectedCompanies.map((c) => c.toJson()).toList(),
      'investingExperience': data.investingExperience.name,
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
