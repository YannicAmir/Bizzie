import 'package:bizzie/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/search/data/datasources/ai_product_search_service.dart';
import 'package:bizzie/features/search/domain/interfaces/i_ai_product_search_repository.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';

@LazySingleton(as: IAiProductSearchRepository)
class AiProductSearchRepository implements IAiProductSearchRepository {
  final AiProductSearchService _service;

  AiProductSearchRepository(this._service);

  @override
  Future<Either<Failure, StockSymbol?>> findStockForProduct(
    String query,
  ) async {
    try {
      final dto = await _service.findStockForProduct(query);
      return Right(dto?.toDomain());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
