import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/security_quote_dto.dart';
import 'package:bizzie/features/company_profile/security/data/interfaces/i_security_quote_remote_datasource.dart';
import 'package:bizzie/features/company_profile/security/data/repositories/security_quote_repository_impl.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecurityQuoteRemoteDataSource extends Mock
    implements ISecurityQuoteRemoteDataSource {}

const tTicker = 'AAPL';

const tSecurityQuoteDto = SecurityQuoteDto(
  ticker: tTicker,
  price: 189.5,
  change: 2.25,
  changePercent: 1.2,
  sessionDate: '2026-11-06',
);

const tSecurityQuote = SecurityQuote(
  ticker: tTicker,
  price: 189.5,
  change: 2.25,
  changePercent: 1.2,
  sessionDate: '2026-11-06',
);

const tUpdatedSecurityQuoteDto = SecurityQuoteDto(
  ticker: tTicker,
  price: 190.1,
  change: 2.85,
  changePercent: 1.52,
  sessionDate: '2026-11-06',
);

const tUpdatedSecurityQuote = SecurityQuote(
  ticker: tTicker,
  price: 190.1,
  change: 2.85,
  changePercent: 1.52,
  sessionDate: '2026-11-06',
);

const tSecurityQuoteDtoWithoutChange = SecurityQuoteDto(
  ticker: tTicker,
  price: 189.5,
  sessionDate: '2026-11-06',
);

const tSecurityQuoteWithoutChange = SecurityQuote(
  ticker: tTicker,
  price: 189.5,
  change: null,
  changePercent: null,
  sessionDate: '2026-11-06',
);

void main() {
  late SecurityQuoteRepositoryImpl sut;
  late MockSecurityQuoteRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockSecurityQuoteRemoteDataSource();
    sut = SecurityQuoteRepositoryImpl(mockRemoteDataSource);
  });

  group('SecurityQuoteRepositoryImpl', () {
    group('watchSecurityQuote', () {
      test(
        'watchSecurityQuote_datasourceEmitsDto_emitsRightMappedQuote',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getSecurityQuoteStream(tTicker),
          ).thenAnswer((_) => Stream.value(tSecurityQuoteDto));

          // act
          final stream = sut.watchSecurityQuote(tTicker);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              const Right<Failure, SecurityQuote?>(tSecurityQuote),
              emitsDone,
            ]),
          );
          verify(
            () => mockRemoteDataSource.getSecurityQuoteStream(tTicker),
          ).called(1);
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );

      test(
        'watchSecurityQuote_datasourceEmitsUpdates_emitsEachMappedQuote',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getSecurityQuoteStream(tTicker),
          ).thenAnswer(
            (_) => Stream.fromIterable([
              tSecurityQuoteDto,
              tUpdatedSecurityQuoteDto,
            ]),
          );

          // act
          final stream = sut.watchSecurityQuote(tTicker);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              const Right<Failure, SecurityQuote?>(tSecurityQuote),
              const Right<Failure, SecurityQuote?>(tUpdatedSecurityQuote),
              emitsDone,
            ]),
          );
        },
      );

      test(
        'watchSecurityQuote_datasourceEmitsDtoWithoutChange_emitsRightQuoteWithNullChange',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getSecurityQuoteStream(tTicker),
          ).thenAnswer((_) => Stream.value(tSecurityQuoteDtoWithoutChange));

          // act
          final stream = sut.watchSecurityQuote(tTicker);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              const Right<Failure, SecurityQuote?>(tSecurityQuoteWithoutChange),
              emitsDone,
            ]),
          );
        },
      );

      test('watchSecurityQuote_datasourceEmitsNull_emitsRightNull', () async {
        // arrange
        when(
          () => mockRemoteDataSource.getSecurityQuoteStream(tTicker),
        ).thenAnswer((_) => Stream.value(null));

        // act
        final stream = sut.watchSecurityQuote(tTicker);

        // assert
        await expectLater(
          stream,
          emitsInOrder([const Right<Failure, SecurityQuote?>(null), emitsDone]),
        );
      });

      test(
        'watchSecurityQuote_datasourceStreamErrors_emitsLeftServerFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getSecurityQuoteStream(tTicker),
          ).thenAnswer((_) => Stream.error(Exception('Network error')));

          // act
          final stream = sut.watchSecurityQuote(tTicker);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              const Left<Failure, SecurityQuote?>(
                Failure.server('Exception: Network error'),
              ),
              emitsDone,
            ]),
          );
        },
      );

      test(
        'watchSecurityQuote_datasourcePermissionDenied_emitsLeftPermissionFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getSecurityQuoteStream(tTicker),
          ).thenAnswer((_) => Stream.error(PermissionDeniedException()));

          // act
          final stream = sut.watchSecurityQuote(tTicker);

          // assert
          await expectLater(
            stream,
            emitsInOrder([
              const Left<Failure, SecurityQuote?>(Failure.permission()),
              emitsDone,
            ]),
          );
        },
      );
    });
  });
}
