import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_security_quote_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/watch_security_quote_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecurityQuoteRepository extends Mock
    implements ISecurityQuoteRepository {}

const tTicker = 'AAPL';
const tSecurityQuote = SecurityQuote(
  ticker: tTicker,
  price: 189.5,
  change: 2.25,
  changePercent: 1.2,
  sessionDate: '2026-11-06',
);
const tFailure = Failure.server('error');

void main() {
  late WatchSecurityQuoteUseCase sut;
  late MockSecurityQuoteRepository mockRepository;

  setUp(() {
    mockRepository = MockSecurityQuoteRepository();
    sut = WatchSecurityQuoteUseCase(mockRepository);
  });

  group('WatchSecurityQuoteUseCase', () {
    test('call_repositoryEmitsRight_emitsRightQuote', () async {
      // arrange
      when(() => mockRepository.watchSecurityQuote(tTicker)).thenAnswer(
        (_) =>
            Stream.value(const Right<Failure, SecurityQuote?>(tSecurityQuote)),
      );

      // act
      final stream = sut(tTicker);

      // assert
      await expectLater(
        stream,
        emitsInOrder([
          const Right<Failure, SecurityQuote?>(tSecurityQuote),
          emitsDone,
        ]),
      );
      verify(() => mockRepository.watchSecurityQuote(tTicker)).called(1);
    });

    test('call_repositoryEmitsLeft_emitsLeftFailure', () async {
      // arrange
      when(() => mockRepository.watchSecurityQuote(tTicker)).thenAnswer(
        (_) => Stream.value(const Left<Failure, SecurityQuote?>(tFailure)),
      );

      // act
      final stream = sut(tTicker);

      // assert
      await expectLater(
        stream,
        emitsInOrder([
          const Left<Failure, SecurityQuote?>(tFailure),
          emitsDone,
        ]),
      );
    });
  });
}
