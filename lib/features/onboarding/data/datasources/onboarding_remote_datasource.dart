import 'dart:async';

import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/data/dtos/onboarding_skip_config.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/onboarding/data/datasources/dummy_price_data.dart';
import 'package:bizzie/features/onboarding/data/dtos/historical_price_dto.dart';
import 'package:bizzie/features/onboarding/data/dtos/onboarding_profile_update_dto.dart';
import 'package:bizzie/features/onboarding/data/interfaces/i_onboarding_remote_datasource.dart';
import 'package:bizzie/core/data/dtos/user_dto.dart';
import 'package:bizzie/core/data/dtos/watchlist_item_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('OnboardingRemoteDataSource');

@Injectable(as: IOnboardingRemoteDataSource)
class OnboardingRemoteDataSource implements IOnboardingRemoteDataSource {
  final FirestoreService _firestoreService;
  final IConfigService _configService;

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
  OnboardingSkipConfig getOnboardingSkipConfig() {
    return _configService.onboardingSkipConfig;
  }

  @override
  List<HistoricalPriceDto> getSp500History() {
    return dummyData.map(HistoricalPriceDto.fromJson).toList();
  }

  @override
  Future<bool> userProfileExists(String uid) async {
    try {
      final profile = await _firestoreService.getDocument<Map<String, dynamic>>(
        path: _userPath(uid),
        fromJson: (json) => json,
        toJson: (data) => data,
      );
      return profile != null;
    } catch (e, s) {
      _logger.severe('Failed to check user profile for UID: $uid', e, s);
      rethrow;
    }
  }

  @override
  Future<void> saveUserProfile(
    UserDto user,
    List<WatchlistItemDto> watchlistItems, {
    bool awaitServerAck = true,
  }) async {
    _logger.info('Starting user profile save for UID: ${user.uid}');
    try {
      final batch = _firestoreService.batch();

      final userPath = _userPath(user.uid);
      final userData = user.toJson();
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

      await _completeWrite(
        batch.commit(),
        uid: user.uid,
        awaitServerAck: awaitServerAck,
        onSaved: () => _logger.info(
          'Successfully saved user profile and ${watchlistItems.length} watchlist items',
        ),
      );
    } catch (e, s) {
      _logSaveFailed(user.uid, e, s);
      rethrow;
    }
  }

  @override
  Future<void> updateOnboardingProfile(
    String uid,
    OnboardingProfileUpdateDto update, {
    bool awaitServerAck = true,
  }) async {
    final data = update.toJson();
    if (data.isEmpty) {
      _logger.info('No onboarding profile fields to update for UID: $uid');
      return;
    }

    _logger.info(
      'Updating onboarding profile fields ${data.keys} for UID: $uid',
    );
    try {
      await _completeWrite(
        _firestoreService.updateDocument(path: _userPath(uid), data: data),
        uid: uid,
        awaitServerAck: awaitServerAck,
        onSaved: () => _logger.info('Successfully updated onboarding profile'),
      );
    } catch (e, s) {
      _logSaveFailed(uid, e, s);
      rethrow;
    }
  }

  String _userPath(String uid) => '${FirestoreConstants.users}/$uid';

  Future<void> _completeWrite(
    Future<void> write, {
    required String uid,
    required bool awaitServerAck,
    required void Function() onSaved,
  }) async {
    if (!awaitServerAck) {
      unawaited(
        write.then(
          (_) => onSaved(),
          onError: (Object e, StackTrace s) => _logSaveFailed(uid, e, s),
        ),
      );
      return;
    }

    await write;
    onSaved();
  }

  void _logSaveFailed(String uid, Object error, StackTrace stackTrace) {
    _logger.severe(
      'Failed to save user profile for UID: $uid',
      error,
      stackTrace,
    );
  }
}
