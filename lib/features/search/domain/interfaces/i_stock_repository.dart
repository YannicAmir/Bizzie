import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';

abstract class IStockRepository {
  Future<Either<Failure, void>> syncStockList();

  Future<Either<Failure, File>> getLocalStockListFile();

  Future<bool> hasLocalFile();
}
