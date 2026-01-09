import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/search/domain/interfaces/i_ai_product_search_repository.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/search/domain/usecases/find_stock_for_product_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIAiProductSearchRepository extends Mock
    implements IAiProductSearchRepository {}

void main() {
  late FindStockForProductUseCase useCase;
  late MockIAiProductSearchRepository mockRepository;

  setUp(() {
    mockRepository = MockIAiProductSearchRepository();
    useCase = FindStockForProductUseCase(mockRepository);
  });

  const tQuery = 'MacBook Pro';
  const tStock = StockSymbol(symbol: 'AAPL', name: 'Apple Inc.');

  group('FindStockForProductUseCase', () {
    test('execute_matchFound_returnsRightStockSymbol', () async {
      // Arrange
      when(
        () => mockRepository.findStockForProduct(any()),
      ).thenAnswer((_) async => const Right(tStock));

      // Act
      final result = await useCase.execute(tQuery);

      // Assert
      expect(result, const Right(tStock));
      verify(() => mockRepository.findStockForProduct(tQuery)).called(1);
    });

    test('execute_noMatch_returnsRightNull', () async {
      // Arrange
      when(
        () => mockRepository.findStockForProduct(any()),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase.execute(tQuery);

      // Assert
      expect(result, const Right(null));
      verify(() => mockRepository.findStockForProduct(tQuery)).called(1);
    });

    test('execute_repositoryFails_returnsLeftFailure', () async {
      // Arrange
      when(
        () => mockRepository.findStockForProduct(any()),
      ).thenAnswer((_) async => Left(ServerFailure('API Error')));

      // Act
      final result = await useCase.execute(tQuery);

      // Assert
      expect(result, isA<Left<Failure, StockSymbol?>>());
      verify(() => mockRepository.findStockForProduct(tQuery)).called(1);
    });
  });
}
