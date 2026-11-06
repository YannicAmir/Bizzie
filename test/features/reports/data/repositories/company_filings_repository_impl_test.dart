import 'package:bizzie/core/domain/models/company_filings.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/data/interfaces/i_reports_remote_datasource.dart';
import 'package:bizzie/features/reports/data/repositories/company_filings_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportsRemoteDataSource extends Mock
    implements IReportsRemoteDataSource {}

const tTicker = 'AAPL';

void main() {
  late CompanyFilingsRepositoryImpl sut;
  late MockReportsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockReportsRemoteDataSource();
    sut = CompanyFilingsRepositoryImpl(mockRemoteDataSource);
    when(
      () => mockRemoteDataSource.getFinancialReportsStream(any()),
    ).thenAnswer((_) => Stream.value([]));
    when(
      () => mockRemoteDataSource.getSecFilingsStream(any()),
    ).thenAnswer((_) => Stream.value([]));
  });

  group('CompanyFilingsRepositoryImpl', () {
    test('getCompanyFilings_bothStreamsEmit_returnsRightForTicker', () async {
      // arrange - stubs from setUp

      // act
      final result = await sut.getCompanyFilings(tTicker).first;

      // assert
      expect(result, const Right<Failure, CompanyFilings>(CompanyFilings()));
      verify(
        () => mockRemoteDataSource.getFinancialReportsStream([tTicker]),
      ).called(1);
      verify(
        () => mockRemoteDataSource.getSecFilingsStream([tTicker]),
      ).called(1);
    });

    test(
      'getCompanyFilings_serverException_returnsLeftServerFailure',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getSecFilingsStream(any()),
        ).thenAnswer((_) => Stream.error(ServerException(message: 'boom')));

        // act
        final result = await sut.getCompanyFilings(tTicker).first;

        // assert
        expect(
          result,
          const Left<Failure, CompanyFilings>(Failure.server('boom')),
        );
      },
    );

    test(
      'getCompanyFilings_unexpectedError_returnsLeftServerFailure',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getFinancialReportsStream(any()),
        ).thenAnswer((_) => Stream.error(Exception('boom')));

        // act
        final result = await sut.getCompanyFilings(tTicker).first;

        // assert
        expect(result.isLeft(), isTrue);
      },
    );
  });
}
