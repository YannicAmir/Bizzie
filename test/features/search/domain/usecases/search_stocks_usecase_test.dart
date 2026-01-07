import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/search/domain/services/stock_search_service.dart';
import 'package:bizzie/features/search/domain/usecases/search_stocks_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStockSearchService extends Mock implements StockSearchService {}

void main() {
  late SearchStocksUseCase useCase;
  late MockStockSearchService mockService;

  setUp(() {
    mockService = MockStockSearchService();
    useCase = SearchStocksUseCase(mockService);
  });

  const tQuery = 'Apple';
  final tStocks = [
    const StockSymbol(symbol: 'AAPL', name: 'Apple Inc.'),
    const StockSymbol(symbol: 'APLE', name: 'Apple Hospitality REIT'),
  ];

  group('SearchStocksUseCase', () {
    test('initialize_callsServiceInitialize', () async {
      // Arrange
      when(() => mockService.initialize()).thenAnswer((_) async {});

      // Act
      await useCase.initialize();

      // Assert
      verify(() => mockService.initialize()).called(1);
    });

    test('execute_callsServiceSearch_returnsStocks', () async {
      // Arrange
      when(() => mockService.search(any())).thenReturn(tStocks);

      // Act
      final result = await useCase.execute(tQuery);

      // Assert
      expect(result, tStocks);
      verify(() => mockService.search(tQuery)).called(1);
    });

    test('execute_emptyQuery_returnsEmptyList', () async {
      // Arrange
      when(() => mockService.search(any())).thenReturn([]);

      // Act
      final result = await useCase.execute('');

      // Assert
      expect(result, isEmpty);
      verify(() => mockService.search('')).called(1);
    });

    test('execute_serviceThrows_throwsException', () async {
      // Arrange
      when(
        () => mockService.search(any()),
      ).thenThrow(Exception('Search failed'));

      // Act & Assert
      expect(() => useCase.execute(tQuery), throwsException);
      verify(() => mockService.search(tQuery)).called(1);
    });
  });
}
