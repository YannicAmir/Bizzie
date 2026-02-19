import 'package:bizzie/core/analytics/models/app_rating_prompt_context.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_in_app_review_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/app_ratings/domain/usecases/track_rating_conditions_usecase.dart';
import 'package:bizzie/features/app_ratings/presentation/analytics/app_ratings_tracker.dart';
import 'package:bizzie/features/app_ratings/presentation/bloc/app_ratings_bloc.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart'
    as auth_user;
import 'package:bizzie/features/auth/domain/usecases/get_current_user.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart'
    as user_model;
import 'package:bizzie/features/user/domain/usecases/get_user_usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTrackRatingConditionsUseCase extends Mock
    implements TrackRatingConditionsUseCase {}

class MockInAppReviewService extends Mock implements IInAppReviewService {}

class MockAppRatingsTracker extends Mock implements AppRatingsTracker {}

class MockGetCurrentUser extends Mock implements GetCurrentUser {}

class MockGetUserUseCase extends Mock implements GetUserUseCase {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      const AppRatingPromptContext(
        ticker: '',
        companyName: '',
        sector: '',
        industry: '',
        experienceLevel: '',
        favoriteSector: '',
        isPremium: false,
        watchlistCount: 0,
        notificationsEnabled: false,
        interactionCount: 0,
        promptAttempts: 0,
        currentTab: '',
        thresholdCount: 0,
      ),
    );
    registerFallbackValue(AppRatingStatus.inProgress);
  });

  late MockTrackRatingConditionsUseCase mockUseCase;
  late MockInAppReviewService mockReviewService;
  late MockAppRatingsTracker mockTracker;
  late MockGetCurrentUser mockGetCurrentUser;
  late MockGetUserUseCase mockGetUserUseCase;
  late MockConfigService mockConfigService;
  late AppRatingsBloc bloc;

  final tCompany = const CompanyProfile(
    symbol: 'AAPL',
    companyName: 'Apple Inc.',
    sector: 'Technology',
    industry: 'Consumer Electronics',
  );

  final tAuthUser = const auth_user.UserModel(
    id: '123',
    email: 'test@example.com',
  );

  final tUserModel = user_model.UserModel(
    uid: '123',
    name: 'Test User',
    favoriteSector: 'Technology',
    investingExperience: InvestingExperience.intermediate,
    isSubscribed: true,
    notificationsEnabled: true,
    watchlist: [],
    createdAt: DateTime.now(),
  );

  setUp(() {
    mockUseCase = MockTrackRatingConditionsUseCase();
    mockReviewService = MockInAppReviewService();
    mockTracker = MockAppRatingsTracker();
    mockGetCurrentUser = MockGetCurrentUser();
    mockGetUserUseCase = MockGetUserUseCase();
    mockConfigService = MockConfigService();

    bloc = AppRatingsBloc(
      mockUseCase,
      mockReviewService,
      mockTracker,
      mockGetCurrentUser,
      mockGetUserUseCase,
      mockConfigService,
    );

    when(() => mockGetCurrentUser()).thenReturn(tAuthUser);
    when(
      () => mockGetUserUseCase(any()),
    ).thenAnswer((_) async => Right(tUserModel));
    when(() => mockUseCase.getInteractionCount()).thenAnswer((_) async => 5);
    when(() => mockUseCase.getPromptAttempts()).thenAnswer((_) async => 0);
    when(() => mockConfigService.reviewPromptEventCount).thenReturn(3);
    when(() => mockReviewService.requestReview()).thenAnswer((_) async {});
    when(
      () => mockTracker.logInteraction(
        ticker: any(named: 'ticker'),
        count: any(named: 'count'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logPromptShown(context: any(named: 'context')),
    ).thenAnswer((_) async {});
    when(() => mockTracker.updateStatus(any())).thenAnswer((_) async {});
  });

  tearDown(() {
    bloc.close();
  });

  group('AppRatingsBloc', () {
    test('initial state should be AppRatingsState.initial', () {
      expect(bloc.state, const AppRatingsState.initial());
    });

    blocTest<AppRatingsBloc, AppRatingsState>(
      'interactionDetected_shouldRequestReview_emitsRequestReviewThenIdleAndLogsAnalytics',
      build: () {
        when(
          () => mockUseCase(any()),
        ).thenAnswer((_) async => const Right(RatingConditionsResult.prompt));
        return bloc;
      },
      act: (bloc) => bloc.add(
        AppRatingsEvent.interactionDetected(
          company: tCompany,
          currentTab: 'financials',
        ),
      ),
      expect: () => [
        const AppRatingsState.requestReview(),
        const AppRatingsState.idle(),
      ],
      verify: (_) {
        verify(
          () => mockTracker.updateStatus(AppRatingStatus.completed),
        ).called(1);
        verify(
          () => mockTracker.logInteraction(ticker: 'AAPL', count: 5),
        ).called(1);
        verify(
          () => mockTracker.logPromptShown(context: any(named: 'context')),
        ).called(1);
        verify(() => mockReviewService.requestReview()).called(1);
      },
    );

    blocTest<AppRatingsBloc, AppRatingsState>(
      'interactionDetected_firstInteraction_updatesStatusToInProgress',
      build: () {
        when(
          () => mockUseCase(any()),
        ).thenAnswer((_) async => const Right(RatingConditionsResult.noPrompt));
        when(
          () => mockUseCase.getInteractionCount(),
        ).thenAnswer((_) async => 1);
        when(() => mockUseCase.getPromptAttempts()).thenAnswer((_) async => 0);
        return bloc;
      },
      act: (bloc) => bloc.add(
        AppRatingsEvent.interactionDetected(
          company: tCompany,
          currentTab: 'financials',
        ),
      ),
      expect: () => [const AppRatingsState.idle()],
      verify: (_) {
        verify(
          () => mockTracker.updateStatus(AppRatingStatus.inProgress),
        ).called(1);
        verify(
          () => mockTracker.logInteraction(ticker: 'AAPL', count: 1),
        ).called(1);
      },
    );

    blocTest<AppRatingsBloc, AppRatingsState>(
      'interactionDetected_shouldNotRequestReview_emitsIdleAndLogsInteractionOnly',
      build: () {
        when(
          () => mockUseCase(any()),
        ).thenAnswer((_) async => const Right(RatingConditionsResult.noPrompt));
        when(
          () => mockUseCase.getInteractionCount(),
        ).thenAnswer((_) async => 5);
        when(() => mockUseCase.getPromptAttempts()).thenAnswer((_) async => 0);
        return bloc;
      },
      act: (bloc) => bloc.add(
        AppRatingsEvent.interactionDetected(
          company: tCompany,
          currentTab: 'financials',
        ),
      ),
      expect: () => [const AppRatingsState.idle()],
      verify: (_) {
        verify(() => mockUseCase(any())).called(1);
        verify(
          () => mockTracker.logInteraction(ticker: 'AAPL', count: 5),
        ).called(1);
        verifyNever(
          () => mockTracker.logPromptShown(context: any(named: 'context')),
        );
        verifyNever(() => mockTracker.updateStatus(AppRatingStatus.completed));
        verifyNever(() => mockReviewService.requestReview());
      },
    );

    blocTest<AppRatingsBloc, AppRatingsState>(
      'interactionDetected_whenMaxAttemptsReached_shouldUpdateStatusToMaxAttemptsAndDetach',
      build: () {
        when(() => mockUseCase(any())).thenAnswer(
          (_) async => const Right(RatingConditionsResult.maxAttemptsReached),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        AppRatingsEvent.interactionDetected(
          company: tCompany,
          currentTab: 'financials',
        ),
      ),
      expect: () => [const AppRatingsState.idle()],
      verify: (_) {
        verify(() => mockUseCase(any())).called(1);
        verify(
          () => mockTracker.updateStatus(AppRatingStatus.maxAttemptsReached),
        ).called(1);
        verifyNever(() => mockGetCurrentUser());
        verifyNever(
          () => mockTracker.logInteraction(
            ticker: any(named: 'ticker'),
            count: any(named: 'count'),
          ),
        );
      },
    );
    group('Interaction Detachment', () {
      blocTest<AppRatingsBloc, AppRatingsState>(
        'interactionDetected_afterMaxAttempts_skipsAllAnalyticsExceptStatusUpdate',
        build: () {
          when(() => mockUseCase(any())).thenAnswer(
            (_) async => const Right(RatingConditionsResult.maxAttemptsReached),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(
          AppRatingsEvent.interactionDetected(
            company: tCompany,
            currentTab: 'financials',
          ),
        ),
        expect: () => [const AppRatingsState.idle()],
        verify: (_) {
          verify(
            () => mockTracker.updateStatus(AppRatingStatus.maxAttemptsReached),
          ).called(1);
          verifyNever(() => mockGetCurrentUser());
          verifyNever(() => mockGetUserUseCase(any()));
          verifyNever(
            () => mockTracker.logInteraction(
              ticker: any(named: 'ticker'),
              count: any(named: 'count'),
            ),
          );
        },
      );
    });
  });
}
