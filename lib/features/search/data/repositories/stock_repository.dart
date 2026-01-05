import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/search/domain/interfaces/i_stock_repository.dart';

@LazySingleton(as: IStockRepository)
class StockRepository implements IStockRepository {
  final FirebaseStorage _storage;
  final SharedPreferences _prefs;

  static const String _storagePath = 'system_data/stock_list.json';
  static const String _prefsKey = 'stock_list_last_updated';
  static const String _localFileName = 'stock_list.json';

  StockRepository(this._storage, this._prefs);

  @override
  Future<Either<Failure, File>> getLocalStockListFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_localFileName');
      if (await file.exists()) {
        return Right(file);
      } else {
        return Left(const CacheFailure('Stock list file not found'));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<bool> hasLocalFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_localFileName');
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, void>> syncStockList() async {
    try {
      final ref = _storage.ref().child(_storagePath);
      final metadata = await ref.getMetadata();
      final remoteUpdated = metadata.updated?.millisecondsSinceEpoch ?? 0;
      final localUpdated = _prefs.getInt(_prefsKey) ?? 0;
      final bool hasFile = await hasLocalFile();

      if (!hasFile || remoteUpdated > localUpdated) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$_localFileName');

        await ref.writeToFile(file);

        await _prefs.setInt(_prefsKey, remoteUpdated);
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
