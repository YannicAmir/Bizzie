import 'package:bizzie/core/domain/interfaces/i_company_filings_repository.dart';
import 'package:bizzie/core/domain/models/company_filings.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/ai_reports/domain/usecases/get_company_filings_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCompanyFilingsRepository extends Mock
    implements ICompanyFilingsRepository {}

const tTicker = 'AAPL';

void main() {
  late GetCompanyFilingsUseCase sut;
  late MockCompanyFilingsRepository mockRepository;

  setUp(() {
    mockRepository = MockCompanyFilingsRepository();
    sut = GetCompanyFilingsUseCase(mockRepository);
  });

  group('GetCompanyFilingsUseCase', () {
    test('call_repositorySucceeds_emitsCompanyFilings', () async {
      // arrange
      when(
        () => mockRepository.getCompanyFilings(any()),
      ).thenAnswer((_) => Stream.value(const Right(CompanyFilings())));

      // act
      final result = await sut(tTicker).first;

      // assert
      expect(result, const Right<Failure, CompanyFilings>(CompanyFilings()));
      verify(() => mockRepository.getCompanyFilings(tTicker)).called(1);
    });

    test('call_repositoryFails_emitsFailure', () async {
      // arrange
      const tFailure = Failure.server('Test Error');
      when(
        () => mockRepository.getCompanyFilings(any()),
      ).thenAnswer((_) => Stream.value(const Left(tFailure)));

      // act
      final result = await sut(tTicker).first;

      // assert
      expect(result, const Left<Failure, CompanyFilings>(tFailure));
    });
  });
}
