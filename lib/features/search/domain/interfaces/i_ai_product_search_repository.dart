import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:dartz/dartz.dart';

abstract class IAiProductSearchRepository {
  Future<Either<Failure, StockSymbol?>> findStockForProduct(String query);
}
