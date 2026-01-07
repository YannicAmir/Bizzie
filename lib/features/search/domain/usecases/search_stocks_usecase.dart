import 'package:injectable/injectable.dart';
import 'package:bizzie/features/search/domain/services/stock_search_service.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';

@injectable
class SearchStocksUseCase {
  final StockSearchService _service;

  SearchStocksUseCase(this._service);

  Future<void> initialize() => _service.initialize();

  Future<List<StockSymbol>> execute(String query) async {
    return _service.search(query);
  }
}
