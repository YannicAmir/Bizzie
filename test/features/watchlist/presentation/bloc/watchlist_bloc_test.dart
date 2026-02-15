import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/watchlist/domain/models/add_to_watchlist_params.dart';
import 'package:bizzie/features/watchlist/domain/models/remove_from_watchlist_params.dart';
import 'package:bizzie/features/watchlist/domain/models/sync_watchlist_params.dart';
import 'package:bizzie/features/watchlist/domain/usecases/add_to_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_enriched_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/remove_from_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/sync_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:bizzie/features/watchlist/domain/enums/watchlist_badge_type.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_events_usecase.dart';

class MockGetWatchlistUseCase extends Mock implements GetWatchlistUseCase {}

class MockGetWatchlistEventsUseCase extends Mock
    implements GetWatchlistEventsUseCase {}

class MockGetEnrichedWatchlistUseCase extends Mock
    implements GetEnrichedWatchlistUseCase {}

class MockAddToWatchlistUseCase extends Mock implements AddToWatchlistUseCase {}

class MockRemoveFromWatchlistUseCase extends Mock
    implements RemoveFromWatchlistUseCase {}

class MockSyncWatchlistUseCase extends Mock implements SyncWatchlistUseCase {}

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late WatchlistBloc bloc;
  late MockGetWatchlistUseCase mockGetWatchlistUseCase;
  late MockGetEnrichedWatchlistUseCase mockGetEnrichedWatchlistUseCase;
  late MockGetWatchlistEventsUseCase mockGetWatchlistEventsUseCase;
  late MockAddToWatchlistUseCase mockAddToWatchlistUseCase;
  late MockRemoveFromWatchlistUseCase mockRemoveFromWatchlistUseCase;
  late MockSyncWatchlistUseCase mockSyncWatchlistUseCase;
  late MockAuthRepository mockAuthRepository;

  setUpAll(() {
    registerFallbackValue(
      const AddToWatchlistParams(
        company: Company(ticker: 'T', name: 'T'),
        uid: 'u',
      ),
    );
    registerFallbackValue(
      const RemoveFromWatchlistParams(ticker: 'T', uid: 'u'),
    );
    registerFallbackValue(const SyncWatchlistParams(activeTickers: []));
  });

  setUp(() {
    mockGetWatchlistUseCase = MockGetWatchlistUseCase();
    mockGetEnrichedWatchlistUseCase = MockGetEnrichedWatchlistUseCase();
    mockGetWatchlistEventsUseCase = MockGetWatchlistEventsUseCase();
    mockAddToWatchlistUseCase = MockAddToWatchlistUseCase();
    mockRemoveFromWatchlistUseCase = MockRemoveFromWatchlistUseCase();
    mockSyncWatchlistUseCase = MockSyncWatchlistUseCase();
    mockAuthRepository = MockAuthRepository();

    // Default stubbing for GetWatchlistEventsUseCase to return empty map
    when(
      () => mockGetWatchlistEventsUseCase(any()),
    ).thenAnswer((_) async => const Right({}));

    bloc = WatchlistBloc(
      mockGetWatchlistUseCase,
      mockGetEnrichedWatchlistUseCase,
      mockGetWatchlistEventsUseCase,
      mockAddToWatchlistUseCase,
      mockRemoveFromWatchlistUseCase,
      mockSyncWatchlistUseCase,
      mockAuthRepository,
    );
  });

  tearDown(() {
    bloc.close();
  });

  const tUid = 'testUid';
  const tUser = UserModel(id: tUid, email: 't@t.com', displayName: 'Test');

  group('WatchlistBloc', () {
    test('initialState_isInitial', () {
      expect(bloc.state, const WatchlistState.initial());
    });

    blocTest<WatchlistBloc, WatchlistState>(
      'loadRequested_userAuthenticated_emitsLoadingThenLoaded',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUser);
        when(
          () => mockGetEnrichedWatchlistUseCase(tUid),
        ).thenAnswer((_) => Stream.value(const Right(([], {}))));
        return bloc;
      },
      act: (bloc) => bloc.add(const WatchlistEvent.loadRequested(uid: tUid)),
      expect: () => [
        const WatchlistState.loading(),
        const WatchlistState.loaded([]),
      ],
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'loadRequested_userNotAuthenticated_emitsFailure',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(null);
        return bloc;
      },
      act: (bloc) => bloc.add(const WatchlistEvent.loadRequested()),
      expect: () => [
        WatchlistState.failure(Failure.server("User not authenticated")),
      ],
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'loadRequested_useCaseFailure_emitsLoadingThenFailure',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUser);
        when(
          () => mockGetEnrichedWatchlistUseCase(tUid),
        ).thenAnswer((_) => Stream.value(const Left(Failure.server('Error'))));
        return bloc;
      },
      act: (bloc) => bloc.add(const WatchlistEvent.loadRequested(uid: tUid)),
      expect: () => [
        const WatchlistState.loading(),
        const WatchlistState.failure(Failure.server('Error')),
      ],
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'addRequested_success_callsUseCaseAndEmitsNothing',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUser);
        when(
          () => mockAddToWatchlistUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const WatchlistEvent.addRequested(ticker: 'AAPL', name: 'Apple'),
      ),
      expect: () => [], // No state emitted on success, relies on stream
      verify: (_) {
        verify(() => mockAddToWatchlistUseCase(any())).called(1);
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'addRequested_failure_emitsFailureState',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUser);
        when(
          () => mockAddToWatchlistUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('Add Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const WatchlistEvent.addRequested(ticker: 'AAPL', name: 'Apple'),
      ),
      expect: () => [const WatchlistState.failure(Failure.server('Add Error'))],
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'removeRequested_success_callsUseCaseAndEmitsNothing',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUser);
        when(
          () => mockRemoveFromWatchlistUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(const WatchlistEvent.removeRequested("AAPL")),
      expect: () => [], // No state emitted on success
      verify: (_) {
        verify(() => mockRemoveFromWatchlistUseCase(any())).called(1);
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'removeRequested_failure_emitsFailureState',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUser);
        when(
          () => mockRemoveFromWatchlistUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('Remove Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const WatchlistEvent.removeRequested("AAPL")),
      expect: () => [
        const WatchlistState.failure(Failure.server('Remove Error')),
      ],
    );
    blocTest<WatchlistBloc, WatchlistState>(
      'removeRequested_failure_emitsFailureState',
      build: () {
        when(() => mockAuthRepository.currentUser).thenReturn(tUser);
        when(
          () => mockRemoveFromWatchlistUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('Remove Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const WatchlistEvent.removeRequested("AAPL")),
      expect: () => [
        const WatchlistState.failure(Failure.server('Remove Error')),
      ],
    );

    group('LoadWatchlistEvents', () {
      blocTest<WatchlistBloc, WatchlistState>(
        'loadWatchlistEvents_success_emitsLoadedWithNewEvents',
        build: () {
          when(() => mockGetWatchlistEventsUseCase(any())).thenAnswer(
            (_) async => Right({
              'AAPL': WatchlistEventStatus(
                badgeText: 'Earnings',
                badgeType: WatchlistBadgeType.neutral,
                eventDate: DateTime.now(),
                lastUpdated: DateTime.now(),
              ),
            }),
          );
          return bloc;
        },
        seed: () => const WatchlistState.loaded([
          Company(ticker: 'AAPL', name: 'Apple'),
        ]),
        act: (bloc) =>
            bloc.add(const WatchlistEvent.loadWatchlistEvents(['AAPL'])),
        expect: () => [
          isA<WatchlistState>().having(
            (p0) => p0.maybeMap(
              loaded: (s) => s.events.containsKey('AAPL'),
              orElse: () => false,
            ),
            'has event',
            true,
          ),
        ],
      );

      blocTest<WatchlistBloc, WatchlistState>(
        'loadWatchlistEvents_failure_logsWarningAndEmitsNothing',
        build: () {
          when(
            () => mockGetWatchlistEventsUseCase(any()),
          ).thenAnswer((_) async => const Left(Failure.server('Error')));
          return bloc;
        },
        seed: () => const WatchlistState.loaded([
          Company(ticker: 'AAPL', name: 'Apple'),
        ]),
        act: (bloc) =>
            bloc.add(const WatchlistEvent.loadWatchlistEvents(['AAPL'])),
        expect: () => [],
      );

      blocTest<WatchlistBloc, WatchlistState>(
        'loadWatchlistEvents_notLoaded_doesNothing',
        build: () => bloc,
        act: (bloc) =>
            bloc.add(const WatchlistEvent.loadWatchlistEvents(['AAPL'])),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockGetWatchlistEventsUseCase(any()));
        },
      );
    });

    group('Reset', () {
      blocTest<WatchlistBloc, WatchlistState>(
        'reset_emitsInitial',
        build: () => bloc,
        seed: () => const WatchlistState.loaded([]),
        act: (bloc) => bloc.add(const WatchlistEvent.reset()),
        expect: () => [const WatchlistState.initial()],
      );
    });

    group('SyncRequested', () {
      blocTest<WatchlistBloc, WatchlistState>(
        'syncRequested_success_callsSyncUseCase',
        build: () {
          when(() => mockAuthRepository.currentUser).thenReturn(tUser);
          when(
            () => mockGetWatchlistUseCase(tUid),
          ).thenAnswer((_) async => Stream.value(const Right([])));
          when(
            () => mockSyncWatchlistUseCase(any()),
          ).thenAnswer((_) async => const Right(null));
          return bloc;
        },
        act: (bloc) => bloc.add(const WatchlistEvent.syncRequested()),
        expect: () => [],
        verify: (_) {
          verify(() => mockSyncWatchlistUseCase(any())).called(1);
        },
      );
    });
  });
}
