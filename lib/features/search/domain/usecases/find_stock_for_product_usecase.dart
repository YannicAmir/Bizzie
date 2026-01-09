import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/search/domain/interfaces/i_ai_product_search_repository.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';

@injectable
class FindStockForProductUseCase {
  final IAiProductSearchRepository _repository;

  FindStockForProductUseCase(this._repository);

  Future<Either<Failure, StockSymbol?>> execute(String query) async {
    return _repository.findStockForProduct(query);
  }
}
