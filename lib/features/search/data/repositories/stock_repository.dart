import 'dart:io';
import 'package:bizzie/features/search/data/datasources/stock_local_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/search/domain/interfaces/i_stock_repository.dart';

@LazySingleton(as: IStockRepository)
class StockRepository implements IStockRepository {
  final FirebaseStorage _storage;
  final IStockLocalDataSource _localDataSource;

  static const String _storagePath = 'system_data/stock_list.json';

  StockRepository(this._storage, this._localDataSource);

  @override
  Future<Either<Failure, File>> getLocalStockListFile() async {
    try {
      final file = await _localDataSource.getLocalStockFile();
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
    return _localDataSource.hasLocalFile();
  }

  @override
  Future<Either<Failure, void>> syncStockList() async {
    try {
      final ref = _storage.ref().child(_storagePath);
      final metadata = await ref.getMetadata();
      final remoteUpdated = metadata.updated?.millisecondsSinceEpoch ?? 0;
      final localUpdated = _localDataSource.getLastUpdatedTime();
      final bool hasFile = await hasLocalFile();

      if (!hasFile || remoteUpdated > localUpdated) {
        final file = await _localDataSource.getLocalStockFile();

        await ref.writeToFile(file);

        await _localDataSource.setLastUpdatedTime(remoteUpdated);
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
