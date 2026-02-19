import 'package:bizzie/core/analytics/analytics_context.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/profile/domain/models/profile_display_data.dart';
import 'package:bizzie/features/profile/domain/usecases/get_profile_display_data_usecase.dart';
import 'package:bizzie/features/profile/presentation/analytics/profile_tracker.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_state.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetProfileDisplayDataUseCase extends Mock
    implements GetProfileDisplayDataUseCase {}

class MockUserRepository extends Mock implements IUserRepository {}

class MockAnalyticsContext extends Mock implements AnalyticsContext {}

class MockProfileTracker extends Mock implements ProfileTracker {}

void main() {
  late MockGetProfileDisplayDataUseCase mockGetProfileDisplayDataUseCase;
  late MockUserRepository mockUserRepository;
  late MockProfileTracker mockTracker;

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      ProfileDisplayData(
        displayName: '',
        sectorName: '',
        sectorDescription: '',
        joinedDate: DateTime.now(),
        sectorPe: null,
        sectorAverageChange: null,
        marketDataDate: null,
      ),
    );
  });

  setUp(() {
    mockTracker = MockProfileTracker();
    mockGetProfileDisplayDataUseCase = MockGetProfileDisplayDataUseCase();
    mockUserRepository = MockUserRepository();

    // Mock successful user stream initialization
    when(
      () => mockUserRepository.userStream,
    ).thenAnswer((_) => const Stream.empty());

    when(() => mockTracker.logProfileLoaded(any())).thenAnswer((_) async {});
    when(
      () => mockTracker.logProfileLoadFailure(
        type: any(named: 'type'),
        message: any(named: 'message'),
      ),
    ).thenAnswer((_) async {});
  });

  ProfileBloc buildBloc() => ProfileBloc(
    mockGetProfileDisplayDataUseCase,
    mockUserRepository,
    mockTracker,
  );

  group('ProfileBloc', () {
    test('initialState_is_correct', () {
      expect(buildBloc().state, const ProfileState.initial());
    });

    final tProfileData = ProfileDisplayData(
      displayName: 'Test User',
      sectorName: 'Technology',
      sectorDescription: 'Description',
      joinedDate: DateTime.now(),
      sectorPe: null,
      sectorAverageChange: null,
      marketDataDate: null,
    );

    blocTest<ProfileBloc, ProfileState>(
      'givenUseCaseSucceeds_whenStartedAdded_thenEmitLoadingThenLoadedAndLogSuccess',
      build: () {
        when(
          () => mockGetProfileDisplayDataUseCase(any()),
        ).thenAnswer((_) async => Right(tProfileData));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ProfileEvent.started()),
      expect: () => [
        const ProfileState.loading(),
        ProfileState.loaded(tProfileData),
      ],
      verify: (_) {
        verify(() => mockTracker.logProfileLoaded(tProfileData)).called(1);
      },
    );

    blocTest<ProfileBloc, ProfileState>(
      'givenUseCaseFails_whenStartedAdded_thenEmitLoadingThenFailureAndLogFailure',
      build: () {
        when(() => mockGetProfileDisplayDataUseCase(any())).thenAnswer(
          (_) async => const Left(ServerFailure('Failed fetching data')),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const ProfileEvent.started()),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.failure(ServerFailure('Failed fetching data')),
      ],
      verify: (_) {
        verify(
          () => mockTracker.logProfileLoadFailure(
            type: any(named: 'type'),
            message: any(named: 'message'),
          ),
        ).called(1);
      },
    );
  });
}
