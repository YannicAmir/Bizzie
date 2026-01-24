import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_security_details_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_security/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_security/company_security_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_security/company_security_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetSecurityDetailsUseCase extends Mock
    implements GetSecurityDetailsUseCase {}

void main() {
  late CompanySecurityBloc bloc;
  late MockGetSecurityDetailsUseCase mockGetSecurityDetails;

  setUp(() {
    mockGetSecurityDetails = MockGetSecurityDetailsUseCase();
    bloc = CompanySecurityBloc(mockGetSecurityDetails);
  });

  const tTicker = 'AAPL';
  const tSecurityDetails = SecurityDetails(
    ticker: tTicker,
    name: 'Apple Inc.',
    sector: 'Technology',
    industry: 'Consumer Electronics',
    description: 'Apple description',
    currency: 'USD',
    isEtf: false,
    isActivelyTrading: true,
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanySecurityState.initial());
  });

  group('CompanySecurityBloc - loadRequested', () {
    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetSecurityDetails(tTicker),
        ).thenAnswer((_) async => const Right(tSecurityDetails));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySecurityState.loading(),
          isA<CompanySecurityState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.securityDetails,
              orElse: () => null,
            ),
            'securityDetails',
            tSecurityDetails,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetSecurityDetails(tTicker)).called(1);
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = ServerFailure('Server error');
        when(
          () => mockGetSecurityDetails(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySecurityState.loading(),
          const CompanySecurityState.failure(ServerFailure('Server error')),
        ];
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanySecurityState.loaded(tSecurityDetails),
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetSecurityDetails(any()));
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetSecurityDetails(tTicker),
        ).thenAnswer((_) async => const Right(tSecurityDetails));
        return bloc;
      },
      seed: () => const CompanySecurityState.loaded(tSecurityDetails),
      act: (bloc) {
        // act
        bloc.add(
          const CompanySecurityEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
        return [
          const CompanySecurityState.loading(),
          isA<CompanySecurityState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.securityDetails,
              orElse: () => null,
            ),
            'securityDetails',
            tSecurityDetails,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetSecurityDetails(tTicker)).called(1);
      },
    );
  });

  group('CompanySecurityBloc - stalenessCheckRequested', () {
    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetSecurityDetails(tTicker),
        ).thenAnswer((_) async => const Right(tSecurityDetails));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySecurityState.loading(),
          isA<CompanySecurityState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.securityDetails,
              orElse: () => null,
            ),
            'securityDetails',
            tSecurityDetails,
          ),
        ];
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanySecurityState.loaded(
        tSecurityDetails,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetSecurityDetails(any()));
      },
    );

    blocTest<CompanySecurityBloc, CompanySecurityState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetSecurityDetails(tTicker),
        ).thenAnswer((_) async => const Right(tSecurityDetails));
        return bloc;
      },
      seed: () => CompanySecurityState.loaded(
        tSecurityDetails,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanySecurityEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySecurityState.loading(),
          isA<CompanySecurityState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.securityDetails,
              orElse: () => null,
            ),
            'securityDetails',
            tSecurityDetails,
          ),
        ];
      },
    );
  });
}
