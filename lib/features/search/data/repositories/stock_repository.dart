import 'dart:io';
import 'package:bizzie/features/search/data/datasources/stock_local_datasource.dart';
import 'package:bizzie/features/search/data/datasources/stock_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/search/domain/interfaces/i_stock_repository.dart';
import 'package:bizzie/features/search/data/dtos/stock_symbol_dto.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

@LazySingleton(as: IStockRepository)
class StockRepository implements IStockRepository {
  final IStockRemoteDataSource _remoteDataSource;
  final IStockLocalDataSource _localDataSource;

  StockRepository(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, File>> getLocalStockListFile() async {
    try {
      final file = await _localDataSource.getLocalStockFile();
      if (await file.exists()) {
        return Right(file);
      } else {
        return Left(const Failure.cache('Stock list file not found'));
      }
    } catch (e) {
      return Left(Failure.cache(e.toString()));
    }
  }

  @override
  Future<bool> hasLocalFile() async {
    return _localDataSource.hasLocalFile();
  }

  @override
  Future<Either<Failure, void>> syncStockList() async {
    try {
      final remoteUpdated = await _remoteDataSource.getRemoteUpdatedTime();
      final localUpdated = _localDataSource.getLastUpdatedTime();
      final bool hasFile = await hasLocalFile();

      if (!hasFile || remoteUpdated > localUpdated) {
        final file = await _localDataSource.getLocalStockFile();

        await _remoteDataSource.downloadStockFile(file);

        await _localDataSource.setLastUpdatedTime(remoteUpdated);
      }

      return const Right(null);
    } catch (e) {
      return Left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StockSymbol>>> getAllStocks() async {
    try {
      final result = await getLocalStockListFile();
      return result.fold((failure) => Left(failure), (file) async {
        final content = await file.readAsString();
        final stocks = await compute(_parseStocks, content);
        return Right(stocks);
      });
    } catch (e) {
      return Left(Failure.cache(e.toString()));
    }
  }
}

List<StockSymbol> _parseStocks(String jsonContent) {
  final Map<String, dynamic> data = jsonDecode(jsonContent);
  final List<dynamic> list = data['stocks'] as List<dynamic>;
  return list
      .map((e) => StockSymbolDto.fromJson(e as Map<String, dynamic>).toDomain())
      .toList();
}
