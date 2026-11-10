import 'dart:async';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/watch_security_quote_usecase.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/security_quote/security_quote_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/security_quote/security_quote_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/security_quote/security_quote_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchSecurityQuoteUseCase extends Mock
    implements WatchSecurityQuoteUseCase {}

class MockGetAuthStream extends Mock implements GetAuthStream {}

MockGetAuthStream stubbedGetAuthStream() {
  final mock = MockGetAuthStream();
  when(() => mock()).thenAnswer((_) => const Stream.empty());
  return mock;
}

void main() {
  late SecurityQuoteBloc bloc;
  late MockWatchSecurityQuoteUseCase mockWatchSecurityQuote;

  setUp(() {
    mockWatchSecurityQuote = MockWatchSecurityQuoteUseCase();
    bloc = SecurityQuoteBloc(mockWatchSecurityQuote, stubbedGetAuthStream());
  });

  tearDown(() => bloc.close());

  const tTicker = 'AAPL';
  const tQuote = SecurityQuote(
    ticker: tTicker,
    price: 190.12,
    change: 2.12,
    changePercent: 1.13,
    sessionDate: '2026-11-09',
  );
  const tRefreshedQuote = SecurityQuote(
    ticker: tTicker,
    price: 191.00,
    change: 3.00,
    changePercent: 1.60,
    sessionDate: '2026-11-09',
  );
  const tFailure = Failure.server('error');

  void stubWatchQuote(Stream<Either<Failure, SecurityQuote?>> stream) {
    when(() => mockWatchSecurityQuote(tTicker)).thenAnswer((_) => stream);
  }

  test('initialState_isCorrect', () {
    // arrange
    // act
    // assert
    expect(bloc.state, const SecurityQuoteState.initial());
  });

  group('SecurityQuoteBloc - loadRequested', () {
    blocTest<SecurityQuoteBloc, SecurityQuoteState>(
      'loadRequested_quoteFound_emitsLoadingAndLoaded',
      build: () {
        // arrange
        stubWatchQuote(Stream.value(const Right(tQuote)));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SecurityQuoteEvent.loadRequested(tTicker)),
      // assert
      expect: () => const [
        SecurityQuoteState.loading(),
        SecurityQuoteState.loaded(tQuote),
      ],
    );

    blocTest<SecurityQuoteBloc, SecurityQuoteState>(
      'loadRequested_quoteUpdates_emitsEachLiveQuote',
      build: () {
        // arrange
        stubWatchQuote(
          Stream.fromIterable(const [Right(tQuote), Right(tRefreshedQuote)]),
        );
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SecurityQuoteEvent.loadRequested(tTicker)),
      // assert
      expect: () => const [
        SecurityQuoteState.loading(),
        SecurityQuoteState.loaded(tQuote),
        SecurityQuoteState.loaded(tRefreshedQuote),
      ],
    );

    blocTest<SecurityQuoteBloc, SecurityQuoteState>(
      'loadRequested_noQuote_emitsLoadingAndUnavailable',
      build: () {
        // arrange
        stubWatchQuote(Stream.value(const Right(null)));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SecurityQuoteEvent.loadRequested(tTicker)),
      // assert
      expect: () => const [
        SecurityQuoteState.loading(),
        SecurityQuoteState.unavailable(),
      ],
    );

    blocTest<SecurityQuoteBloc, SecurityQuoteState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        stubWatchQuote(Stream.value(const Left(tFailure)));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SecurityQuoteEvent.loadRequested(tTicker)),
      // assert
      expect: () => const [
        SecurityQuoteState.loading(),
        SecurityQuoteState.failure(tFailure),
      ],
    );

    blocTest<SecurityQuoteBloc, SecurityQuoteState>(
      'loadRequested_failureAfterQuote_keepsStaleQuote',
      build: () {
        // arrange
        stubWatchQuote(
          Stream.fromIterable(const [Right(tQuote), Left(tFailure)]),
        );
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SecurityQuoteEvent.loadRequested(tTicker)),
      // assert
      expect: () => const [
        SecurityQuoteState.loading(),
        SecurityQuoteState.loaded(tQuote),
      ],
    );

    blocTest<SecurityQuoteBloc, SecurityQuoteState>(
      'loadRequested_streamErrors_emitsLoadingAndFailure',
      build: () {
        // arrange
        stubWatchQuote(Stream.error(Exception('stream failed')));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SecurityQuoteEvent.loadRequested(tTicker)),
      // assert
      expect: () => const [
        SecurityQuoteState.loading(),
        SecurityQuoteState.failure(Failure.server('Exception: stream failed')),
      ],
    );
  });

  group('SecurityQuoteBloc - reset', () {
    blocTest<SecurityQuoteBloc, SecurityQuoteState>(
      'reset_fromLoaded_emitsInitial',
      build: () => bloc,
      seed: () => const SecurityQuoteState.loaded(tQuote),
      // act
      act: (bloc) => bloc.add(const SecurityQuoteEvent.reset()),
      // assert
      expect: () => const [SecurityQuoteState.initial()],
    );

    final controller = StreamController<Either<Failure, SecurityQuote?>>();
    blocTest<SecurityQuoteBloc, SecurityQuoteState>(
      'reset_whileWatching_cancelsSubscription',
      build: () {
        // arrange
        stubWatchQuote(controller.stream);
        return bloc;
      },
      // act
      act: (bloc) async {
        bloc.add(const SecurityQuoteEvent.loadRequested(tTicker));
        await Future<void>.delayed(Duration.zero);
        controller.add(const Right(tQuote));
        await Future<void>.delayed(Duration.zero);
        bloc.add(const SecurityQuoteEvent.reset());
        await Future<void>.delayed(Duration.zero);
        controller.add(const Right(tRefreshedQuote));
      },
      // assert
      expect: () => const [
        SecurityQuoteState.loading(),
        SecurityQuoteState.loaded(tQuote),
        SecurityQuoteState.initial(),
      ],
      tearDown: controller.close,
    );
  });
}
