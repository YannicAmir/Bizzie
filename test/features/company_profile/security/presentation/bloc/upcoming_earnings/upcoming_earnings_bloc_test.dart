import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_upcoming_earnings_usecase.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUpcomingEarningsUseCase extends Mock
    implements GetUpcomingEarningsUseCase {}

class MockWatchActiveTabUseCase extends Mock implements WatchActiveTabUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  late UpcomingEarningsBloc bloc;
  late MockGetUpcomingEarningsUseCase mockGetUpcomingEarnings;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;

  setUp(() {
    mockGetUpcomingEarnings = MockGetUpcomingEarningsUseCase();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();

    when(() => mockWatchActiveTabUseCase(any()))
        .thenAnswer((_) => const Stream.empty());
    bloc = UpcomingEarningsBloc(
      mockGetUpcomingEarnings,
      mockWatchActiveTabUseCase,
    );
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
        ).thenAnswer((_) async => Right((tDate, CompanyProfileDataOrigin.api)));
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
        when(() => mockGetUpcomingEarnings(any())).thenAnswer(
          (_) async => const Right((null, CompanyProfileDataOrigin.api)),
        );
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
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => UpcomingEarningsState.loaded(
        tDate,
        dataSource: CompanyProfileDataOrigin.api,
      ),
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
        ).thenAnswer((_) async => Right((tDate, CompanyProfileDataOrigin.api)));
        return bloc;
      },
      seed: () => UpcomingEarningsState.loaded(
        tDate,
        dataSource: CompanyProfileDataOrigin.api,
      ),
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
      'stalenessCheckRequested_staleDate_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetUpcomingEarnings(any()),
        ).thenAnswer((_) async => Right((tDate, CompanyProfileDataOrigin.api)));
        return bloc;
      },
      seed: () => UpcomingEarningsState.loaded(
        tDate,
        dataSource: CompanyProfileDataOrigin.api,
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
        dataSource: CompanyProfileDataOrigin.api,
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
  });
}
