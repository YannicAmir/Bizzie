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
import 'package:bizzie/features/watchlist/domain/usecases/remove_from_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/sync_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWatchlistUseCase extends Mock implements GetWatchlistUseCase {}

class MockAddToWatchlistUseCase extends Mock implements AddToWatchlistUseCase {}

class MockRemoveFromWatchlistUseCase extends Mock
    implements RemoveFromWatchlistUseCase {}

class MockSyncWatchlistUseCase extends Mock implements SyncWatchlistUseCase {}

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late WatchlistBloc bloc;
  late MockGetWatchlistUseCase mockGetWatchlistUseCase;
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
    mockAddToWatchlistUseCase = MockAddToWatchlistUseCase();
    mockRemoveFromWatchlistUseCase = MockRemoveFromWatchlistUseCase();
    mockSyncWatchlistUseCase = MockSyncWatchlistUseCase();
    mockAuthRepository = MockAuthRepository();

    bloc = WatchlistBloc(
      mockGetWatchlistUseCase,
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
          () => mockGetWatchlistUseCase(tUid),
        ).thenAnswer((_) async => Stream.value(const Right([])));
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
        when(() => mockGetWatchlistUseCase(tUid)).thenAnswer(
          (_) async => Stream.value(const Left(Failure.server('Error'))),
        );
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
  });
}
