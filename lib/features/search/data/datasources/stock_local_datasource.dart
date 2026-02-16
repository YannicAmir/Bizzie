import 'dart:io';
import 'package:bizzie/core/constants/storage_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IStockLocalDataSource {
  Future<File> getLocalStockFile();

  Future<bool> hasLocalFile();

  int getLastUpdatedTime();

  Future<void> setLastUpdatedTime(int timestamp);
}

@Injectable(as: IStockLocalDataSource)
class StockLocalDataSource implements IStockLocalDataSource {
  final SharedPreferences _prefs;

  static const String _prefsKey = StorageConstants.stockListLastUpdated;
  static const String _localFileName = 'stock_list.json';

  StockLocalDataSource(this._prefs);

  @override
  Future<File> getLocalStockFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_localFileName');
  }

  @override
  Future<bool> hasLocalFile() async {
    final file = await getLocalStockFile();
    return await file.exists();
  }

  @override
  int getLastUpdatedTime() {
    return _prefs.getInt(_prefsKey) ?? 0;
  }

  @override
  Future<void> setLastUpdatedTime(int timestamp) async {
    await _prefs.setInt(_prefsKey, timestamp);
  }
}
