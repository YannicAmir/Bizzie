import 'package:bizzie/core/constants/storage_constants.dart';
import 'package:bizzie/features/watchlist/data/interfaces/i_watchlist_local_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: IWatchlistLocalDataSource)
class WatchlistLocalDataSource implements IWatchlistLocalDataSource {
  final SharedPreferences _prefs;

  static const _kSubscribedTickersKey = StorageConstants.userSubscribedTickers;

  WatchlistLocalDataSource(this._prefs);

  @override
  Future<void> cacheSubscribedTickers(List<String> tickers) async {
    await _prefs.setStringList(_kSubscribedTickersKey, tickers);
  }

  @override
  List<String> getSubscribedTickers() {
    return _prefs.getStringList(_kSubscribedTickersKey) ?? [];
  }
}
