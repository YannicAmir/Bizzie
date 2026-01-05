import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import 'package:bizzie/features/search/domain/interfaces/i_stock_repository.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('StockSearchService');

List<StockSymbol> _parseStocks(String jsonContent) {
  final Map<String, dynamic> data = jsonDecode(jsonContent);
  final List<dynamic> list = data['stocks'] as List<dynamic>;
  return list
      .map((e) => StockSymbol.fromJson(e as Map<String, dynamic>))
      .toList();
}

@lazySingleton
class StockSearchService {
  final IStockRepository _repository;

  List<StockSymbol> _allStocks = [];
  bool _isInitialized = false;

  StockSearchService(this._repository);

  Future<void> initialize() async {
    if (_isInitialized) return;

    final hasFile = await _repository.hasLocalFile();

    if (!hasFile) {
      await _repository.syncStockList();
    } else {
      _repository.syncStockList();
    }

    final fileResult = await _repository.getLocalStockListFile();

    await fileResult.fold(
      (failure) async {
        _logger.severe('Failed to load stock list: ${failure.message}');
      },
      (file) async {
        try {
          final content = await file.readAsString();
          _allStocks = await compute(_parseStocks, content);
          _isInitialized = true;
        } catch (e) {
          _logger.severe('Failed to parse stock list: $e');
        }
      },
    );
  }

  List<StockSymbol> search(String query) {
    if (query.isEmpty) return [];

    final q = query.toLowerCase();

    // We want a single pass or efficient filtering.
    // Given 37k items, a full iteration is fast (~5-10ms).
    // Note: We need to limit to 7 items total.
    // We can collect matches into buckets and stop early?
    // Or just filter all and sort?
    // Filtering 37k items is cheap. Sorting all matches might be slightly more expensive but okay.
    // Optimization: "Short-circuit" if we have enough Rank 1 matches?
    // Let's implement the standard filter + sort + take(7) approach first.

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
