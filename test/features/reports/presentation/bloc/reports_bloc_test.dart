import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/domain/usecases/get_dashboard_reports_usecase.dart';
import 'package:bizzie/features/reports/domain/usecases/get_user_activity_use_case.dart';
import 'package:bizzie/features/reports/domain/usecases/mark_reports_viewed_use_case.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/user/domain/models/user_activity.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/watchlist_repository.dart';
import 'package:bizzie/features/user/domain/usecases/watch_user_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDashboardReportsUseCase extends Mock
    implements GetDashboardReportsUseCase {}

class MockIWatchlistRepository extends Mock implements IWatchlistRepository {}

class MockIAuthRepository extends Mock implements IAuthRepository {}

class MockGetUserActivityUseCase extends Mock
    implements GetUserActivityUseCase {}

class MockMarkReportsViewedUseCase extends Mock
    implements MarkReportsViewedUseCase {}

class MockWatchUserUseCase extends Mock implements WatchUserUseCase {}

class MockUserModel extends Mock implements UserModel {}

void main() {
  late ReportsBloc bloc;
  late MockGetDashboardReportsUseCase mockGetReportsUseCase;
  late MockIWatchlistRepository mockWatchlistRepository;
  late MockIAuthRepository mockAuthRepository;
  late MockGetUserActivityUseCase mockGetUserActivityUseCase;
  late MockMarkReportsViewedUseCase mockMarkReportsViewedUseCase;
  late MockWatchUserUseCase mockWatchUser;
  late MockUserModel mockUser;

  setUp(() {
    mockGetReportsUseCase = MockGetDashboardReportsUseCase();
    mockWatchlistRepository = MockIWatchlistRepository();
    mockAuthRepository = MockIAuthRepository();
    mockGetUserActivityUseCase = MockGetUserActivityUseCase();
    mockMarkReportsViewedUseCase = MockMarkReportsViewedUseCase();
    mockWatchUser = MockWatchUserUseCase();
    mockUser = MockUserModel();

    when(() => mockAuthRepository.currentUser).thenReturn(mockUser);
    when(() => mockUser.id).thenReturn('test_uid');
    when(() => mockWatchUser.call()).thenAnswer((_) => const Stream.empty());

    bloc = ReportsBloc(
      mockGetReportsUseCase,
      mockWatchlistRepository,
      mockAuthRepository,
      mockGetUserActivityUseCase,
      mockMarkReportsViewedUseCase,
      mockWatchUser,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initialState_isCorrect', () {
    expect(bloc.state, const ReportsState.initial());
  });

  group('ReportsBloc - Started', () {
    const tUserActivity = UserActivity(lastViewedReports: null);

    blocTest<ReportsBloc, ReportsState>(
      'started_subscribesToStreamsAndEmitsLoadingLoaded',
      build: () {
        when(
          () => mockGetUserActivityUseCase(any()),
        ).thenAnswer((_) => Stream.value(const Right(tUserActivity)));
        when(
          () => mockWatchlistRepository.getWatchlistStream(any()),
        ).thenAnswer((_) => Stream.value(const Right([])));
        when(
          () => mockGetReportsUseCase(any()),
        ).thenAnswer((_) => Stream.value(const Right(ReportsFeed())));
        return bloc;
      },
      act: (bloc) => bloc.add(const ReportsEvent.started(uid: 'test_uid')),
      expect: () => [
        const ReportsState.loading(),
        const ReportsState.loaded(
          ReportsFeed(),
          lastViewedReports: null,
          todaysFilings: [],
        ),
      ],
      verify: (_) {
        verify(() => mockGetUserActivityUseCase('test_uid')).called(1);
        verify(
          () => mockWatchlistRepository.getWatchlistStream('test_uid'),
        ).called(1);
        verify(() => mockGetReportsUseCase([])).called(1);
      },
    );
  });

  group('ReportsBloc - ReportsUpdated', () {
    const tReportsFeed = ReportsFeed();

    blocTest<ReportsBloc, ReportsState>(
      'reportsUpdated_success_emitsLoaded',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const ReportsEvent.reportsUpdated(Right(tReportsFeed))),
      expect: () => [
        const ReportsState.loaded(
          tReportsFeed,
          lastViewedReports: null,
          todaysFilings: [],
        ),
      ],
    );

    blocTest<ReportsBloc, ReportsState>(
      'reportsUpdated_failure_emitsFailure',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ReportsEvent.reportsUpdated(Left(Failure.server("Error"))),
      ),
      expect: () => [const ReportsState.failure(Failure.server("Error"))],
    );
  });
}
