import 'package:bizzie/features/search/data/datasources/ai_product_search_service.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/search/domain/usecases/find_stock_for_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAiProductSearchService extends Mock
    implements AiProductSearchService {}

void main() {
  late FindStockForProductUseCase useCase;
  late MockAiProductSearchService mockAiService;

  setUp(() {
    mockAiService = MockAiProductSearchService();
    useCase = FindStockForProductUseCase(mockAiService);
  });

  const tQuery = 'MacBook Pro';
  const tStock = StockSymbol(symbol: 'AAPL', name: 'Apple Inc.');

  group('FindStockForProductUseCase', () {
    test('execute_matchFound_returnsStockSymbol', () async {
      // Arrange
      when(
        () => mockAiService.findStockForProduct(any()),
      ).thenAnswer((_) async => tStock);

      // Act
      final result = await useCase.execute(tQuery);

      // Assert
      expect(result, tStock);
      verify(() => mockAiService.findStockForProduct(tQuery)).called(1);
    });

    test('execute_noMatch_returnsNull', () async {
      // Arrange
      when(
        () => mockAiService.findStockForProduct(any()),
      ).thenAnswer((_) async => null);

      // Act
      final result = await useCase.execute(tQuery);

      // Assert
      expect(result, isNull);
      verify(() => mockAiService.findStockForProduct(tQuery)).called(1);
    });

    test('execute_serviceThrows_rethrowsException', () async {
      // Arrange
      when(
        () => mockAiService.findStockForProduct(any()),
      ).thenThrow(Exception('AI Error'));

      // Act & Assert
      expect(() => useCase.execute(tQuery), throwsException);
      verify(() => mockAiService.findStockForProduct(tQuery)).called(1);
    });
  });
}
