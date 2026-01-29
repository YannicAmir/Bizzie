import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_upcoming_earnings_usecase.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUpcomingEarningsUseCase extends Mock
    implements GetUpcomingEarningsUseCase {}

void main() {
  late UpcomingEarningsBloc bloc;
  late MockGetUpcomingEarningsUseCase mockGetUpcomingEarnings;

  setUp(() {
    mockGetUpcomingEarnings = MockGetUpcomingEarningsUseCase();
    bloc = UpcomingEarningsBloc(mockGetUpcomingEarnings);
  });

  const tTicker = 'AAPL';
  final tDate = DateTime(2024, 10, 10);

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const UpcomingEarningsState.initial());
  });

  group('UpcomingEarningsBloc - loadRequested', () {
    blocTest<UpcomingEarningsBloc, UpcomingEarningsState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetUpcomingEarnings(any()),
        ).thenAnswer((_) async => Right(tDate));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const UpcomingEarningsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const UpcomingEarningsState.loading(),
          isA<UpcomingEarningsState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.earningsDate, orElse: () => null),
            'earningsDate',
            tDate,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetUpcomingEarnings(tTicker)).called(1);
      },
    );

    blocTest<UpcomingEarningsBloc, UpcomingEarningsState>(
      'loadRequested_noDateFound_emitsLoadingAndEmpty',
      build: () {
        // arrange
        when(
          () => mockGetUpcomingEarnings(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const UpcomingEarningsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const UpcomingEarningsState.loading(),
          const UpcomingEarningsState.empty(),
        ];
      },
    );

    blocTest<UpcomingEarningsBloc, UpcomingEarningsState>(
      'loadRequested_serverFailure_emitsLoadingAndFailure',
      build: () {
        // arrange
        when(
          () => mockGetUpcomingEarnings(any()),
        ).thenAnswer((_) async => const Left(Failure.server('error')));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const UpcomingEarningsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const UpcomingEarningsState.loading(),
          const UpcomingEarningsState.failure(Failure.server('error')),
        ];
      },
    );

    blocTest<UpcomingEarningsBloc, UpcomingEarningsState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => UpcomingEarningsState.loaded(tDate),
      act: (bloc) {
        // act
        bloc.add(const UpcomingEarningsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetUpcomingEarnings(any()));
      },
    );

    blocTest<UpcomingEarningsBloc, UpcomingEarningsState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetUpcomingEarnings(any()),
        ).thenAnswer((_) async => Right(tDate));
        return bloc;
      },
      seed: () => UpcomingEarningsState.loaded(tDate),
      act: (bloc) {
        // act
        bloc.add(
          const UpcomingEarningsEvent.loadRequested(
            tTicker,
            forceRefresh: true,
          ),
        );
      },
      expect: () {
        // assert
        return [
          const UpcomingEarningsState.loading(),
          isA<UpcomingEarningsState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.earningsDate, orElse: () => null),
            'earningsDate',
            tDate,
          ),
        ];
      },
    );
  });

  group('UpcomingEarningsBloc - stalenessCheckRequested', () {
    blocTest<UpcomingEarningsBloc, UpcomingEarningsState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetUpcomingEarnings(any()),
        ).thenAnswer((_) async => Right(tDate));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const UpcomingEarningsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const UpcomingEarningsState.loading(),
          isA<UpcomingEarningsState>(),
        ];
      },
    );

    blocTest<UpcomingEarningsBloc, UpcomingEarningsState>(
      'stalenessCheckRequested_staleDate_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetUpcomingEarnings(any()),
        ).thenAnswer((_) async => Right(tDate));
        return bloc;
      },
      seed: () => UpcomingEarningsState.loaded(
        tDate,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const UpcomingEarningsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const UpcomingEarningsState.loading(),
          isA<UpcomingEarningsState>(),
        ];
      },
    );

    blocTest<UpcomingEarningsBloc, UpcomingEarningsState>(
      'stalenessCheckRequested_freshDate_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => UpcomingEarningsState.loaded(
        tDate,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      act: (bloc) {
        // act
        bloc.add(const UpcomingEarningsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetUpcomingEarnings(any()));
      },
    );

    blocTest<UpcomingEarningsBloc, UpcomingEarningsState>(
      'stalenessCheckRequested_failureState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetUpcomingEarnings(any()),
        ).thenAnswer((_) async => Right(tDate));
        return bloc;
      },
      seed: () => const UpcomingEarningsState.failure(Failure.server('error')),
      act: (bloc) {
        // act
        bloc.add(const UpcomingEarningsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const UpcomingEarningsState.loading(),
          isA<UpcomingEarningsState>(),
        ];
      },
    );

    blocTest<UpcomingEarningsBloc, UpcomingEarningsState>(
      'stalenessCheckRequested_emptyState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetUpcomingEarnings(any()),
        ).thenAnswer((_) async => Right(tDate));
        return bloc;
      },
      seed: () => const UpcomingEarningsState.empty(),
      act: (bloc) {
        // act
        bloc.add(const UpcomingEarningsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const UpcomingEarningsState.loading(),
          isA<UpcomingEarningsState>(),
        ];
      },
    );
  });
}
