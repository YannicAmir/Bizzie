import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/roe/domain/interfaces/i_roe_repository.dart';
import 'package:bizzie/features/company_profile/roe/domain/models/roe.dart';
import 'package:bizzie/features/company_profile/roe/domain/usecases/get_roe_usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIRoeRepository extends Mock implements IRoeRepository {}

void main() {
  late GetRoeUseCase useCase;
  late MockIRoeRepository mockRepository;

  setUp(() {
    mockRepository = MockIRoeRepository();
    useCase = GetRoeUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tRoeList = <Roe>[];

  group('GetRoeUseCase', () {
    test('call_success_returnsRoeList', () async {
      // arrange
      when(() => mockRepository.getRoeMetrics(tTicker)).thenAnswer(
        (_) async => Right((tRoeList, CompanyProfileDataOrigin.cache)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right((tRoeList, CompanyProfileDataOrigin.cache)));
      verify(() => mockRepository.getRoeMetrics(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getRoeMetrics(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getRoeMetrics(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
