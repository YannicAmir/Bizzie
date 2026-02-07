import 'dart:convert';
import 'package:bizzie/features/market/data/dtos/market_data_snapshot.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('MarketLocalDataSource');
const String _kMarketDataKey = 'market_data_snapshot';

abstract class MarketLocalDataSource {
  Future<MarketDataSnapshot?> getLastKnownMarketData();
  Future<void> cacheMarketData(MarketDataSnapshot data);
}

@LazySingleton(as: MarketLocalDataSource)
class MarketLocalDataSourceImpl implements MarketLocalDataSource {
  final SharedPreferences _prefs;

  MarketLocalDataSourceImpl(this._prefs);

  @override
  Future<MarketDataSnapshot?> getLastKnownMarketData() async {
    try {
      final jsonString = _prefs.getString(_kMarketDataKey);
      if (jsonString == null) return null;

      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return MarketDataSnapshot.fromJson(jsonMap);
    } catch (e, s) {
      _logger.severe('Failed to read cached market data', e, s);
      return null;
    }
  }

  @override
  Future<void> cacheMarketData(MarketDataSnapshot data) async {
    try {
      final jsonString = jsonEncode(data.toJson());
      await _prefs.setString(_kMarketDataKey, jsonString);
      _logger.info('Cached market data for date: ${data.date}');
    } catch (e, s) {
      _logger.severe('Failed to cache market data', e, s);
    }
  }
}
