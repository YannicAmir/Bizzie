import 'package:bizzie/features/auth/domain/usecases/get_auth_stream_usecase.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_analytics.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/growth_band.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_highlights_resolver.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCompanyProfileAnalytics extends Mock
    implements CompanyProfileAnalytics {}

class MockGetAuthStreamUseCase extends Mock implements GetAuthStreamUseCase {}

const tTicker = 'AAPL';
const tCompanyName = 'Apple';
const tGrowth = (band: GrowthBand.high, years: 5);

CompanyProfileTourState tActive(
  CompanyProfileTourStep step, {
  bool shouldPromptNotifications = true,
  bool isAwaitingRevenueData = false,
  Set<CompanyProfileTourStep> completedSteps = const {},
  GrowthHighlight? revenueGrowth,
}) => CompanyProfileTourState.active(
  ticker: tTicker,
  companyName: tCompanyName,
  shouldPromptNotifications: shouldPromptNotifications,
  step: step,
  isAwaitingRevenueData: isAwaitingRevenueData,
  completedSteps: completedSteps,
  revenueGrowth: revenueGrowth,
);

const tStepsBeforeRevenueGrowth = {
  CompanyProfileTourStep.companyOverview,
  CompanyProfileTourStep.tabs,
  CompanyProfileTourStep.revenueTab,
};

const tStepsBeforeStayUpdated = {
  ...tStepsBeforeRevenueGrowth,
  CompanyProfileTourStep.revenueGrowth,
};

void main() {
  late MockCompanyProfileAnalytics mockAnalytics;
  late MockGetAuthStreamUseCase mockGetAuthStream;
  late CompanyProfileTourBloc sut;

  setUpAll(() {
    registerFallbackValue(CompanyProfileTourStep.companyOverview);
    registerFallbackValue(GrowthBand.high);
  });

  setUp(() {
    mockAnalytics = MockCompanyProfileAnalytics();
    mockGetAuthStream = MockGetAuthStreamUseCase();
    when(() => mockGetAuthStream()).thenAnswer((_) => const Stream.empty());
    when(
      () => mockAnalytics.logTourStarted(ticker: any(named: 'ticker')),
    ).thenAnswer((_) async {});
    when(
      () => mockAnalytics.logTourStepViewed(step: any(named: 'step')),
    ).thenAnswer((_) async {});
    when(
      () => mockAnalytics.logTourCompleted(ticker: any(named: 'ticker')),
    ).thenAnswer((_) async {});
    when(
      () => mockAnalytics.logTourSkipped(step: any(named: 'step')),
    ).thenAnswer((_) async {});
    when(
      () => mockAnalytics.logTourRevenueGrowthBandShown(
        band: any(named: 'band'),
        years: any(named: 'years'),
      ),
    ).thenAnswer((_) async {});
    sut = CompanyProfileTourBloc(mockAnalytics, mockGetAuthStream);
  });

  tearDown(() => sut.close());

  group('CompanyProfileTourBloc', () {
    group('started', () {
      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'started_initial_showsCompanyOverviewAndLogsStart',
        build: () => sut,
        act: (bloc) => bloc.add(
          const CompanyProfileTourEvent.started(
            ticker: tTicker,
            companyName: tCompanyName,
            shouldPromptNotifications: true,
          ),
        ),
        expect: () => [tActive(CompanyProfileTourStep.companyOverview)],
        verify: (_) {
          verify(() => mockAnalytics.logTourStarted(ticker: tTicker)).called(1);
          verify(
            () => mockAnalytics.logTourStepViewed(
              step: CompanyProfileTourStep.companyOverview,
            ),
          ).called(1);
        },
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'started_alreadyFinished_isIgnored',
        build: () => sut,
        seed: () => const CompanyProfileTourState.finished(
          shouldPromptNotifications: false,
        ),
        act: (bloc) => bloc.add(
          const CompanyProfileTourEvent.started(
            ticker: tTicker,
            companyName: tCompanyName,
            shouldPromptNotifications: true,
          ),
        ),
        expect: () => <CompanyProfileTourState>[],
        verify: (_) => verifyNever(
          () => mockAnalytics.logTourStarted(ticker: any(named: 'ticker')),
        ),
      );
    });

    group('stepCompleted', () {
      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'stepCompleted_fromCompanyOverview_advancesToTabsThenRevenueTab',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.companyOverview),
        act: (bloc) => bloc
          ..add(const CompanyProfileTourEvent.stepCompleted())
          ..add(const CompanyProfileTourEvent.stepCompleted()),
        expect: () => [
          tActive(
            CompanyProfileTourStep.tabs,
            completedSteps: {CompanyProfileTourStep.companyOverview},
          ),
          tActive(
            CompanyProfileTourStep.revenueTab,
            completedSteps: {
              CompanyProfileTourStep.companyOverview,
              CompanyProfileTourStep.tabs,
            },
          ),
        ],
        verify: (_) {
          verify(
            () => mockAnalytics.logTourStepViewed(
              step: CompanyProfileTourStep.tabs,
            ),
          ).called(1);
          verify(
            () => mockAnalytics.logTourStepViewed(
              step: CompanyProfileTourStep.revenueTab,
            ),
          ).called(1);
        },
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'stepCompleted_onRevenueTab_waitsForRevenueTap',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.revenueTab),
        act: (bloc) => bloc.add(const CompanyProfileTourEvent.stepCompleted()),
        expect: () => <CompanyProfileTourState>[],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'stepCompleted_onRevenueGrowth_advancesToStayUpdated',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.revenueGrowth),
        act: (bloc) => bloc.add(const CompanyProfileTourEvent.stepCompleted()),
        expect: () => [
          tActive(
            CompanyProfileTourStep.stayUpdated,
            completedSteps: {CompanyProfileTourStep.revenueGrowth},
          ),
        ],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'stepCompleted_onStayUpdatedWithPrompt_finishesWithPrompt',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.stayUpdated),
        act: (bloc) => bloc.add(const CompanyProfileTourEvent.stepCompleted()),
        expect: () => [
          const CompanyProfileTourState.finished(
            shouldPromptNotifications: true,
          ),
        ],
        verify: (_) => verify(
          () => mockAnalytics.logTourCompleted(ticker: tTicker),
        ).called(1),
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'stepCompleted_onStayUpdatedWithoutPrompt_finishesWithoutPrompt',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.stayUpdated,
          shouldPromptNotifications: false,
        ),
        act: (bloc) => bloc.add(const CompanyProfileTourEvent.stepCompleted()),
        expect: () => [
          const CompanyProfileTourState.finished(
            shouldPromptNotifications: false,
          ),
        ],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'stepCompleted_initial_isIgnored',
        build: () => sut,
        act: (bloc) => bloc.add(const CompanyProfileTourEvent.stepCompleted()),
        expect: () => <CompanyProfileTourState>[],
      );
    });

    group('previousRequested', () {
      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'previousRequested_onCompanyOverview_isIgnored',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.companyOverview),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.previousRequested()),
        expect: () => <CompanyProfileTourState>[],
        verify: (_) => verifyNever(
          () => mockAnalytics.logTourStepViewed(step: any(named: 'step')),
        ),
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'previousRequested_onTabs_returnsToCompanyOverviewAndLogsView',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.tabs,
          completedSteps: {CompanyProfileTourStep.companyOverview},
        ),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.previousRequested()),
        expect: () => [
          tActive(
            CompanyProfileTourStep.companyOverview,
            completedSteps: {CompanyProfileTourStep.companyOverview},
          ),
        ],
        verify: (_) => verify(
          () => mockAnalytics.logTourStepViewed(
            step: CompanyProfileTourStep.companyOverview,
          ),
        ).called(1),
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'previousRequested_onTabsAfterSkippedOverview_isIgnored',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.tabs),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.previousRequested()),
        expect: () => <CompanyProfileTourState>[],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'previousRequested_onRevenueTab_returnsToTabs',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.revenueTab,
          completedSteps: {
            CompanyProfileTourStep.companyOverview,
            CompanyProfileTourStep.tabs,
          },
        ),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.previousRequested()),
        expect: () => [
          tActive(
            CompanyProfileTourStep.tabs,
            completedSteps: {
              CompanyProfileTourStep.companyOverview,
              CompanyProfileTourStep.tabs,
            },
          ),
        ],
        verify: (_) => verify(
          () => mockAnalytics.logTourStepViewed(
            step: CompanyProfileTourStep.tabs,
          ),
        ).called(1),
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'previousRequested_onRevenueGrowth_isIgnored',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.revenueGrowth,
          completedSteps: tStepsBeforeRevenueGrowth,
          revenueGrowth: tGrowth,
        ),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.previousRequested()),
        expect: () => <CompanyProfileTourState>[],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'previousRequested_whileAwaitingRevenueData_isIgnored',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.revenueGrowth,
          isAwaitingRevenueData: true,
          completedSteps: tStepsBeforeRevenueGrowth,
        ),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.previousRequested()),
        expect: () => <CompanyProfileTourState>[],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'previousRequested_onStayUpdatedAfterRevenueGrowth_returnsToRevenueGrowth',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.stayUpdated,
          completedSteps: tStepsBeforeStayUpdated,
          revenueGrowth: tGrowth,
        ),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.previousRequested()),
        expect: () => [
          tActive(
            CompanyProfileTourStep.revenueGrowth,
            completedSteps: tStepsBeforeStayUpdated,
            revenueGrowth: tGrowth,
          ),
        ],
        verify: (_) => verify(
          () => mockAnalytics.logTourStepViewed(
            step: CompanyProfileTourStep.revenueGrowth,
          ),
        ).called(1),
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'previousRequested_onStayUpdatedAfterSkippedRevenueGrowth_isIgnored',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.stayUpdated,
          completedSteps: tStepsBeforeRevenueGrowth,
        ),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.previousRequested()),
        expect: () => <CompanyProfileTourState>[],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'previousRequested_revisitedRevenueGrowthThenNext_returnsToStayUpdated',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.revenueGrowth,
          completedSteps: tStepsBeforeRevenueGrowth,
          revenueGrowth: tGrowth,
        ),
        act: (bloc) => bloc
          ..add(const CompanyProfileTourEvent.stepCompleted())
          ..add(const CompanyProfileTourEvent.previousRequested())
          ..add(const CompanyProfileTourEvent.previousRequested())
          ..add(const CompanyProfileTourEvent.stepCompleted()),
        expect: () => [
          tActive(
            CompanyProfileTourStep.stayUpdated,
            completedSteps: tStepsBeforeStayUpdated,
            revenueGrowth: tGrowth,
          ),
          tActive(
            CompanyProfileTourStep.revenueGrowth,
            completedSteps: tStepsBeforeStayUpdated,
            revenueGrowth: tGrowth,
          ),
          tActive(
            CompanyProfileTourStep.stayUpdated,
            completedSteps: tStepsBeforeStayUpdated,
            revenueGrowth: tGrowth,
          ),
        ],
        verify: (_) {
          verify(
            () => mockAnalytics.logTourStepViewed(
              step: CompanyProfileTourStep.stayUpdated,
            ),
          ).called(2);
          verify(
            () => mockAnalytics.logTourStepViewed(
              step: CompanyProfileTourStep.revenueGrowth,
            ),
          ).called(1);
        },
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'previousRequested_initial_isIgnored',
        build: () => sut,
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.previousRequested()),
        expect: () => <CompanyProfileTourState>[],
      );
    });

    group('revenueTabSelected', () {
      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'revenueTabSelected_onRevenueTab_awaitsRevenueData',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.revenueTab),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.revenueTabSelected()),
        expect: () => [
          tActive(
            CompanyProfileTourStep.revenueGrowth,
            isAwaitingRevenueData: true,
            completedSteps: {CompanyProfileTourStep.revenueTab},
          ),
        ],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'revenueTabSelected_beforeRevenueStep_isIgnored',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.tabs),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.revenueTabSelected()),
        expect: () => <CompanyProfileTourState>[],
      );

      test(
        'revenueTabSelected_dataNeverLoads_skipsToStayUpdatedAfterTimeout',
        () {
          fakeAsync((async) {
            // arrange
            final sut = CompanyProfileTourBloc(
              mockAnalytics,
              mockGetAuthStream,
            );
            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
            sut.emit(tActive(CompanyProfileTourStep.revenueTab));

            // act
            sut.add(const CompanyProfileTourEvent.revenueTabSelected());
            async.flushMicrotasks();
            final awaitingState = sut.state;
            async.elapse(CompanyProfileTourBloc.revenueDataTimeout);

            // assert
            expect(
              awaitingState,
              tActive(
                CompanyProfileTourStep.revenueGrowth,
                isAwaitingRevenueData: true,
                completedSteps: {CompanyProfileTourStep.revenueTab},
              ),
            );
            expect(
              sut.state,
              tActive(
                CompanyProfileTourStep.stayUpdated,
                completedSteps: {CompanyProfileTourStep.revenueTab},
              ),
            );
            verifyNever(
              () => mockAnalytics.logTourRevenueGrowthBandShown(
                band: any(named: 'band'),
                years: any(named: 'years'),
              ),
            );
            sut.close();
            async.flushMicrotasks();
          });
        },
      );

      test('revenueTabSelected_closedBeforeTimeout_logsNoFurtherStepViewed', () {
        fakeAsync((async) {
          // arrange
          final sut = CompanyProfileTourBloc(mockAnalytics, mockGetAuthStream);
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          sut.emit(tActive(CompanyProfileTourStep.revenueTab));
          sut.add(const CompanyProfileTourEvent.revenueTabSelected());
          async.flushMicrotasks();

          // act
          sut.close();
          async
            ..flushMicrotasks()
            ..elapse(CompanyProfileTourBloc.revenueDataTimeout);

          // assert
          verifyNever(
            () => mockAnalytics.logTourStepViewed(
              step: CompanyProfileTourStep.stayUpdated,
            ),
          );
          verifyNever(
            () => mockAnalytics.logTourCompleted(ticker: any(named: 'ticker')),
          );
        });
      });
    });

    group('revenueGrowthResolved', () {
      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'revenueGrowthResolved_growth_showsRevenueGrowthAndLogsBand',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.revenueGrowth,
          isAwaitingRevenueData: true,
        ),
        act: (bloc) => bloc.add(
          const CompanyProfileTourEvent.revenueGrowthResolved(tGrowth),
        ),
        expect: () => [
          const CompanyProfileTourState.active(
            ticker: tTicker,
            companyName: tCompanyName,
            shouldPromptNotifications: true,
            step: CompanyProfileTourStep.revenueGrowth,
            revenueGrowth: tGrowth,
          ),
        ],
        verify: (_) {
          verify(
            () => mockAnalytics.logTourRevenueGrowthBandShown(
              band: GrowthBand.high,
              years: 5,
            ),
          ).called(1);
          verify(
            () => mockAnalytics.logTourStepViewed(
              step: CompanyProfileTourStep.revenueGrowth,
            ),
          ).called(1);
        },
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'revenueGrowthResolved_noGrowth_skipsToStayUpdated',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.revenueGrowth,
          isAwaitingRevenueData: true,
        ),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.revenueGrowthResolved(null)),
        expect: () => [tActive(CompanyProfileTourStep.stayUpdated)],
        verify: (_) => verifyNever(
          () => mockAnalytics.logTourRevenueGrowthBandShown(
            band: any(named: 'band'),
            years: any(named: 'years'),
          ),
        ),
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'revenueGrowthResolved_notAwaiting_isIgnored',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.revenueTab),
        act: (bloc) => bloc.add(
          const CompanyProfileTourEvent.revenueGrowthResolved(tGrowth),
        ),
        expect: () => <CompanyProfileTourState>[],
      );
    });

    group('targetUnavailableReported', () {
      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'targetUnavailableReported_onRevenueTab_skipsRevenueSteps',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.revenueTab),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.targetUnavailableReported()),
        expect: () => [tActive(CompanyProfileTourStep.stayUpdated)],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'targetUnavailableReported_onStayUpdated_finishesTour',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.stayUpdated),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.targetUnavailableReported()),
        expect: () => [
          const CompanyProfileTourState.finished(
            shouldPromptNotifications: true,
          ),
        ],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'targetUnavailableReported_whileAwaitingRevenueData_isIgnored',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.revenueGrowth,
          isAwaitingRevenueData: true,
        ),
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.targetUnavailableReported()),
        expect: () => <CompanyProfileTourState>[],
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'targetUnavailableReported_initial_isIgnored',
        build: () => sut,
        act: (bloc) =>
            bloc.add(const CompanyProfileTourEvent.targetUnavailableReported()),
        expect: () => <CompanyProfileTourState>[],
      );
    });

    group('skipRequested', () {
      for (final step in CompanyProfileTourStep.values) {
        blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
          'skipRequested_${step.name}_finishesAsSkippedWithPromptAndLogsStep',
          build: () => sut,
          seed: () => tActive(step),
          act: (bloc) =>
              bloc.add(const CompanyProfileTourEvent.skipRequested()),
          expect: () => [
            const CompanyProfileTourState.finished(
              shouldPromptNotifications: true,
              wasSkipped: true,
            ),
          ],
          verify: (_) {
            verify(() => mockAnalytics.logTourSkipped(step: step)).called(1);
            verifyNever(
              () =>
                  mockAnalytics.logTourCompleted(ticker: any(named: 'ticker')),
            );
          },
        );
      }

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'skipRequested_whileAwaitingRevenueData_finishesAsSkippedAndLogsRevenueGrowthStep',
        build: () => sut,
        seed: () => tActive(
          CompanyProfileTourStep.revenueGrowth,
          shouldPromptNotifications: false,
          isAwaitingRevenueData: true,
        ),
        act: (bloc) => bloc.add(const CompanyProfileTourEvent.skipRequested()),
        expect: () => [
          const CompanyProfileTourState.finished(
            shouldPromptNotifications: false,
            wasSkipped: true,
          ),
        ],
        verify: (_) => verify(
          () => mockAnalytics.logTourSkipped(
            step: CompanyProfileTourStep.revenueGrowth,
          ),
        ).called(1),
      );

      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'skipRequested_finished_isIgnored',
        build: () => sut,
        seed: () => const CompanyProfileTourState.finished(
          shouldPromptNotifications: true,
        ),
        act: (bloc) => bloc.add(const CompanyProfileTourEvent.skipRequested()),
        expect: () => <CompanyProfileTourState>[],
      );
    });

    group('reset', () {
      blocTest<CompanyProfileTourBloc, CompanyProfileTourState>(
        'reset_active_emitsInitial',
        build: () => sut,
        seed: () => tActive(CompanyProfileTourStep.tabs),
        act: (bloc) => bloc.add(const CompanyProfileTourEvent.reset()),
        expect: () => [const CompanyProfileTourState.initial()],
      );
    });
  });
}
