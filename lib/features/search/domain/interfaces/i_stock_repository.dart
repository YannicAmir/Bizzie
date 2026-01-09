import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';

abstract class IStockRepository {
  Future<Either<Failure, void>> syncStockList();

  Future<Either<Failure, File>> getLocalStockListFile();

  Future<bool> hasLocalFile();

  Future<Either<Failure, List<StockSymbol>>> getAllStocks();
}
