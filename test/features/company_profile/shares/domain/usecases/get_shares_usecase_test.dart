import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shares/domain/interfaces/i_shares_repository.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/share_stats.dart';
import 'package:bizzie/features/company_profile/shares/domain/usecases/get_shares_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockISharesRepository extends Mock implements ISharesRepository {}

void main() {
  late GetSharesUseCase usecase;
  late MockISharesRepository mockRepository;

  setUp(() {
    mockRepository = MockISharesRepository();
    usecase = GetSharesUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  const tShareStats = ShareStats(
    currentSharesOutstanding: 15640.0,
    annualWeightedAverageShares: [
      FinancialDataPoint(date: '2018-10-01', period: 'FY', value: 18000.0),
    ],
    quarterlyWeightedAverageShares: [
      FinancialDataPoint(date: '2022-07-01', period: 'Q3', value: 16000.0),
    ],
  );

  test('should get share stats from the repository', () async {
    // arrange
    when(
      () => mockRepository.getShareStats(any()),
    ).thenAnswer((_) async => const Right(tShareStats));

    // act
    final result = await usecase(tTicker);

    // assert
    expect(result, const Right(tShareStats));
    verify(() => mockRepository.getShareStats(tTicker));
    verifyNoMoreInteractions(mockRepository);
  });

  test(
    'should return a Failure when the repository call is unsuccessful',
    () async {
      // arrange
      const tFailure = ServerFailure('Server Failure');
      when(
        () => mockRepository.getShareStats(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getShareStats(tTicker));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
