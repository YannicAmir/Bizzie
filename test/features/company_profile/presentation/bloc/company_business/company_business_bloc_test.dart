import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/business/domain/usecases/get_business_profile_usecase.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_bloc.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_event.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetBusinessProfileUseCase extends Mock
    implements GetBusinessProfileUseCase {}

void main() {
  late CompanyBusinessBloc bloc;
  late MockGetBusinessProfileUseCase mockGetBusinessProfileUseCase;

  setUp(() {
    mockGetBusinessProfileUseCase = MockGetBusinessProfileUseCase();
    bloc = CompanyBusinessBloc(mockGetBusinessProfileUseCase);
  });

  const tTicker = 'AAPL';
  final tBusinessProfile = BusinessProfile(
    symbol: tTicker,
    companyName: 'Apple Inc.',
    sector: 'Technology',
    industry: 'Consumer Electronics',
    description: 'Tech giant',
    ceo: 'Tim Cook',
    website: 'https://apple.com',
    address: '1 Infinite Loop',
    city: 'Cupertino',
    state: 'CA',
    zip: '95014',
    phone: '1-408-996-1010',
    fullTimeEmployees: '100000',
    executives: [],
    annualFilings: [],
    quarterlyFilings: [],
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyBusinessState.initial());
  });

  group('CompanyBusinessBloc - loadRequested', () {
    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetBusinessProfileUseCase(tTicker),
        ).thenAnswer((_) async => Right(tBusinessProfile));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyBusinessState.loading(),
          isA<CompanyBusinessState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.businessProfile,
              orElse: () => null,
            ),
            'businessProfile',
            tBusinessProfile,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetBusinessProfileUseCase(tTicker)).called(1);
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = ServerFailure('Server error');
        when(
          () => mockGetBusinessProfileUseCase(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyBusinessState.loading(),
          const CompanyBusinessState.failure(ServerFailure('Server error')),
        ];
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        when(
          () => mockGetBusinessProfileUseCase(tTicker),
        ).thenAnswer((_) async => Right(tBusinessProfile));
        return bloc;
      },
      seed: () => CompanyBusinessState.loaded(tBusinessProfile),
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetBusinessProfileUseCase(any()));
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetBusinessProfileUseCase(tTicker),
        ).thenAnswer((_) async => Right(tBusinessProfile));
        return bloc;
      },
      seed: () => CompanyBusinessState.loaded(tBusinessProfile),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyBusinessEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyBusinessState.loading(),
          isA<CompanyBusinessState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.businessProfile,
              orElse: () => null,
            ),
            'businessProfile',
            tBusinessProfile,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetBusinessProfileUseCase(tTicker)).called(1);
      },
    );
  });

  group('CompanyBusinessBloc - stalenessCheckRequested', () {
    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetBusinessProfileUseCase(tTicker),
        ).thenAnswer((_) async => Right(tBusinessProfile));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyBusinessState.loading(),
          isA<CompanyBusinessState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.businessProfile,
              orElse: () => null,
            ),
            'businessProfile',
            tBusinessProfile,
          ),
        ];
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyBusinessState.loaded(
        tBusinessProfile,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetBusinessProfileUseCase(any()));
      },
    );

    blocTest<CompanyBusinessBloc, CompanyBusinessState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetBusinessProfileUseCase(tTicker),
        ).thenAnswer((_) async => Right(tBusinessProfile));
        return bloc;
      },
      seed: () => CompanyBusinessState.loaded(
        tBusinessProfile,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyBusinessEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyBusinessState.loading(),
          isA<CompanyBusinessState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.businessProfile,
              orElse: () => null,
            ),
            'businessProfile',
            tBusinessProfile,
          ),
        ];
      },
    );
  });
}
