import 'package:injectable/injectable.dart';
import 'package:bizzie/features/search/domain/interfaces/i_stock_repository.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('StockSearchService');

@lazySingleton
class StockSearchService {
  final IStockRepository _repository;

  List<StockSymbol> _allStocks = [];
  bool _isInitialized = false;

  StockSearchService(this._repository);

  Future<void> initialize() async {
    if (_isInitialized) return;

    _logger.info('Initializing StockSearchService');

    final hasFile = await _repository.hasLocalFile();

    if (!hasFile) {
      _logger.info('No local stock list found, syncing...');
      await _repository.syncStockList();
    } else {
      _logger.info('Local stock list found. Starting background sync.');
      _repository.syncStockList();
    }

    final result = await _repository.getAllStocks();

    result.fold(
      (failure) {
        _logger.severe('Failed to load stock list: ${failure.errorMessage}');
      },
      (stocks) {
        _logger.info('Stock list loaded successfully: ${stocks.length} items');
        _allStocks = stocks;
        _isInitialized = true;
      },
    );
  }

  List<StockSymbol> search(String query) {
    if (query.isEmpty) return [];

    final q = query.toLowerCase();

    final matches = _allStocks.where((s) {
      final sLower = s.symbol.toLowerCase();
      final nLower = s.name.toLowerCase();
      return sLower.contains(q) || nLower.contains(q);
    }).toList();

    matches.sort((a, b) {
      final aSym = a.symbol.toLowerCase();
      final bSym = b.symbol.toLowerCase();
      final aName = a.name.toLowerCase();
      final bName = b.name.toLowerCase();

      // Rank 0: Exact Symbol Match
      final aExactSym = aSym == q;
      final bExactSym = bSym == q;
      if (aExactSym && !bExactSym) return -1;
      if (!aExactSym && bExactSym) return 1;

      // Rank 1: Symbol Starts With
      final aStartsSym = aSym.startsWith(q);
      final bStartsSym = bSym.startsWith(q);
      if (aStartsSym && !bStartsSym) return -1;
      if (!aStartsSym && bStartsSym) return 1;

      // Rank 2: Name Starts With
      final aStartsName = aName.startsWith(q);
      final bStartsName = bName.startsWith(q);
      if (aStartsName && !bStartsName) return -1;
      if (!aStartsName && bStartsName) return 1;

      // Rank 3: Contains (Implicit tie-breaker)
      // Tie-breaker: Alphabetical by Symbol
      return aSym.compareTo(bSym);
    });

    return matches.take(7).toList();
  }
}
