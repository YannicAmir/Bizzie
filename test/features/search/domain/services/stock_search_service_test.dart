import 'package:bizzie/features/search/domain/interfaces/i_stock_repository.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/search/domain/services/stock_search_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStockRepository extends Mock implements IStockRepository {}

void main() {
  late StockSearchService service;
  late MockStockRepository mockRepository;

  final tStocks = [
    const StockSymbol(symbol: 'MS', name: 'Morgan Stanley'),
    const StockSymbol(symbol: 'MSA', name: 'MSA Safety Incorporated'),
    const StockSymbol(symbol: 'MSFT', name: 'Microsoft Corporation'),
    const StockSymbol(symbol: 'FL', name: 'Foot Locker, Inc.'),
    const StockSymbol(symbol: 'FLA', name: 'Fluidra, S.A.'),
    const StockSymbol(symbol: 'AAPL', name: 'Apple Inc.'),
  ];

  setUp(() async {
    mockRepository = MockStockRepository();
    service = StockSearchService(mockRepository);

    when(() => mockRepository.hasLocalFile()).thenAnswer((_) async => true);
    when(
      () => mockRepository.syncStockList(),
    ).thenAnswer((_) async => const Right(null));
    when(
      () => mockRepository.getAllStocks(),
    ).thenAnswer((_) async => Right(tStocks));

    await service.initialize();
  });

  group('StockSearchService Ranking', () {
    test('search_exactSymbolMatch_returnsExactMatchFirst', () {
      // arrange
      const query = 'MS';

      // act
      final results = service.search(query);

      // assert
      // Currently, MSA might come first if it "starts with" and ranks same as MS
      // But we want MS (the exact match) to be #1
      expect(results.first.symbol, 'MS');
    });

    test('search_multipleStarts_returnsExactMatchThenStartsByAlphabetical', () {
      // arrange
      const query = 'FL';

      // act
      final results = service.search(query);

      // assert
      expect(results.first.symbol, 'FL');
      expect(results[1].symbol, 'FLA');
    });

    test('search_caseInsensitiveExactMatch_returnsExactMatchFirst', () {
      // arrange
      const query = 'ms';

      // act
      final results = service.search(query);

      // assert
      expect(results.first.symbol, 'MS');
    });

    test(
      'search_rankingHierarchy_prioritizesStartsBySymbolOverStartsByName',
      () async {
        // arrange
        final customStocks = [
          const StockSymbol(symbol: 'AAPL', name: 'Apple Inc.'),
          const StockSymbol(symbol: 'A', name: 'Agilent Technologies'),
        ];

        when(
          () => mockRepository.getAllStocks(),
        ).thenAnswer((_) async => Right(customStocks));

        final localService = StockSearchService(mockRepository);

        // act
        await localService.initialize();
        final results = localService.search('A');

        // assert
        expect(results.first.symbol, 'A');
        expect(results[1].symbol, 'AAPL');
      },
    );
  });
}
