import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_event.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_info.dart';
import 'package:bizzie/features/company_profile/dividends/domain/usecases/get_dividend_info_usecase.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_bloc.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_event.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDividendInfoUseCase extends Mock
    implements GetDividendInfoUseCase {}

void main() {
  late CompanyDividendsBloc bloc;
  late MockGetDividendInfoUseCase mockGetDividendInfo;

  setUp(() {
    mockGetDividendInfo = MockGetDividendInfoUseCase();
    bloc = CompanyDividendsBloc(mockGetDividendInfo);
  });

  const tTicker = 'AAPL';
  final tDividendInfo = DividendInfo(
    symbol: tTicker,
    history: [
      DividendEvent(date: '2023-01-01', dividend: 0.25, adjDividend: 0.25),
    ],
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyDividendsState.initial());
  });

  group('CompanyDividendsBloc - loadRequested', () {
    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetDividendInfo(tTicker),
        ).thenAnswer((_) async => Right(tDividendInfo));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyDividendsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyDividendsState.loading(),
          isA<CompanyDividendsState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.dividendInfo, orElse: () => null),
            'dividendInfo',
            tDividendInfo,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetDividendInfo(tTicker)).called(1);
      },
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'loadRequested_failure_emitsLoadingAndError',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetDividendInfo(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyDividendsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyDividendsState.loading(),
          const CompanyDividendsState.error(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyDividendsState.loaded(tDividendInfo),
      act: (bloc) {
        // act
        bloc.add(const CompanyDividendsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetDividendInfo(any()));
      },
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetDividendInfo(tTicker),
        ).thenAnswer((_) async => Right(tDividendInfo));
        return bloc;
      },
      seed: () => CompanyDividendsState.loaded(tDividendInfo),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyDividendsEvent.loadRequested(
            tTicker,
            forceRefresh: true,
          ),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyDividendsState.loading(),
          isA<CompanyDividendsState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.dividendInfo, orElse: () => null),
            'dividendInfo',
            tDividendInfo,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetDividendInfo(tTicker)).called(1);
      },
    );
  });

  group('CompanyDividendsBloc - stalenessCheckRequested', () {
    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetDividendInfo(tTicker),
        ).thenAnswer((_) async => Right(tDividendInfo));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyDividendsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyDividendsState.loading(),
          isA<CompanyDividendsState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.dividendInfo, orElse: () => null),
            'dividendInfo',
            tDividendInfo,
          ),
        ];
      },
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyDividendsState.loaded(
        tDividendInfo,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyDividendsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetDividendInfo(any()));
      },
    );

    blocTest<CompanyDividendsBloc, CompanyDividendsState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetDividendInfo(tTicker),
        ).thenAnswer((_) async => Right(tDividendInfo));
        return bloc;
      },
      seed: () => CompanyDividendsState.loaded(
        tDividendInfo,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyDividendsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyDividendsState.loading(),
          isA<CompanyDividendsState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.dividendInfo, orElse: () => null),
            'dividendInfo',
            tDividendInfo,
          ),
        ];
      },
    );
  });
}
