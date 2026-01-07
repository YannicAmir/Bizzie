import 'package:injectable/injectable.dart';
import 'package:bizzie/features/search/data/datasources/ai_product_search_service.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';

@injectable
class FindStockForProductUseCase {
  final AiProductSearchService _aiService;

  FindStockForProductUseCase(this._aiService);

  Future<StockSymbol?> execute(String query) async {
    return _aiService.findStockForProduct(query);
  }
}
