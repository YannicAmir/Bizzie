import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_security_repository.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_upcoming_earnings_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockISecurityRepository extends Mock implements ISecurityRepository {}

void main() {
  late GetUpcomingEarningsUseCase useCase;
  late MockISecurityRepository mockRepository;

  setUp(() {
    mockRepository = MockISecurityRepository();
    useCase = GetUpcomingEarningsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tDate = DateTime(2024, 10, 10);

  group('GetUpcomingEarningsUseCase', () {
    test('call_success_returnsEarningsDate', () async {
      // arrange
      when(
        () => mockRepository.getUpcomingEarningsDate(tTicker),
      ).thenAnswer((_) async => Right(tDate));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right(tDate));
      verify(() => mockRepository.getUpcomingEarningsDate(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = ServerFailure('Server error');
      when(
        () => mockRepository.getUpcomingEarningsDate(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getUpcomingEarningsDate(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
