import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/dividends/domain/interfaces/i_dividend_repository.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_info.dart';
import 'package:bizzie/features/company_profile/dividends/domain/usecases/get_dividend_info_usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIDividendRepository extends Mock implements IDividendRepository {}

void main() {
  late GetDividendInfoUseCase useCase;
  late MockIDividendRepository mockRepository;

  setUp(() {
    mockRepository = MockIDividendRepository();
    useCase = GetDividendInfoUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tDividendInfo = DividendInfo(symbol: tTicker, history: []);

  group('GetDividendInfoUseCase', () {
    test('call_success_returnsDividendInfo', () async {
      // Arrange
      when(() => mockRepository.getDividendInfo(tTicker)).thenAnswer(
        (_) async => Right((tDividendInfo, CompanyProfileDataOrigin.cache)),
      );

      // Act
      final result = await useCase(tTicker);

      // Assert
      expect(result, Right((tDividendInfo, CompanyProfileDataOrigin.cache)));
      verify(() => mockRepository.getDividendInfo(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // Arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getDividendInfo(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(tTicker);

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getDividendInfo(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
