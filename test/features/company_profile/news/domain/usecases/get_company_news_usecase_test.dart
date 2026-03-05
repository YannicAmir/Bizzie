import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/news/domain/interfaces/i_news_repository.dart';
import 'package:bizzie/features/company_profile/news/domain/models/company_news.dart';
import 'package:bizzie/features/company_profile/news/domain/usecases/get_company_news_usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockINewsRepository extends Mock implements INewsRepository {}

void main() {
  late GetCompanyNewsUseCase useCase;
  late MockINewsRepository mockRepository;

  setUp(() {
    mockRepository = MockINewsRepository();
    useCase = GetCompanyNewsUseCase(mockRepository);
  });

  const tTicker = 'AAPL';
  final tCompanyNews = CompanyNews(symbol: tTicker, articles: []);

  group('GetCompanyNewsUseCase', () {
    test('call_success_returnsCompanyNews', () async {
      // arrange
      when(() => mockRepository.getCompanyNews(tTicker)).thenAnswer(
        (_) async => Right((tCompanyNews, CompanyProfileDataOrigin.cache)),
      );

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, Right((tCompanyNews, CompanyProfileDataOrigin.cache)));
      verify(() => mockRepository.getCompanyNews(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsServerFailure', () async {
      // arrange
      const tFailure = Failure.server('Server error');
      when(
        () => mockRepository.getCompanyNews(tTicker),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTicker);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getCompanyNews(tTicker)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
