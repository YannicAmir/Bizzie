import 'dart:async';

import 'package:bizzie/core/domain/models/company_filings.dart';
import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/company_profile/ai_reports/domain/enums/ai_report_form.dart';
import 'package:bizzie/features/company_profile/ai_reports/domain/usecases/get_company_filings_usecase.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/analytics/ai_reports_tab_analytics.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/analytics/ai_reports_tab_view_state.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_bloc.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_event.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCompanyFilingsUseCase extends Mock
    implements GetCompanyFilingsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockAiReportsTabAnalytics extends Mock implements AiReportsTabAnalytics {}

class MockGetAuthStream extends Mock implements GetAuthStream {}

class MockTimeProvider extends Mock implements ITimeProvider {}

const tTicker = 'AAPL';
const tFailure = Failure.server('Test Error');
const tFiling = SecFiling(
  id: 'f',
  symbol: tTicker,
  companyName: 'Apple Inc.',
  filingDate: null,
  formType: '10-K',
  link: '',
  summary: 'Summary',
  createdAt: null,
  analyzedAt: null,
);
const tCompanyFilings = CompanyFilings();
const tLabel = 'Summarize';
final tNow = DateTime(2026, 1, 1);

void main() {
  late MockGetCompanyFilingsUseCase mockUseCase;
  late MockConfigService mockConfigService;
  late MockAiReportsTabAnalytics mockAnalytics;
  late MockGetAuthStream mockGetAuthStream;
  late MockTimeProvider mockTimeProvider;
  late CompanyAiReportsBloc sut;

  setUpAll(() {
    registerFallbackValue(
      const AiReportsTabViewState(ticker: '', timestamp: ''),
    );
  });

  setUp(() {
    mockUseCase = MockGetCompanyFilingsUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.aiSummaryButtonLabel).thenReturn(tLabel);
    mockAnalytics = MockAiReportsTabAnalytics();
    mockGetAuthStream = MockGetAuthStream();
    mockTimeProvider = MockTimeProvider();
    when(() => mockGetAuthStream()).thenAnswer((_) => const Stream.empty());
    when(() => mockTimeProvider.nowLocal).thenReturn(tNow);
    when(
      () => mockAnalytics.logViewSummary(any(), isFinal: any(named: 'isFinal')),
    ).thenAnswer((_) async {});
    sut = CompanyAiReportsBloc(
      mockUseCase,
      mockConfigService,
      mockAnalytics,
      mockTimeProvider,
      mockGetAuthStream,
    );
  });

  tearDown(() => sut.close());

  void stubReports(Either<Failure, CompanyFilings> result) {
    when(() => mockUseCase(any())).thenAnswer((_) => Stream.value(result));
  }

  CompanyAiReportsLoaded loadedOf(CompanyAiReportsState state) =>
      state as CompanyAiReportsLoaded;

  group('CompanyAiReportsBloc', () {
    group('load', () {
      blocTest<CompanyAiReportsBloc, CompanyAiReportsState>(
        'started_notLoaded_emitsLoadingThenLoaded',
        build: () {
          stubReports(const Right(tCompanyFilings));
          return sut;
        },
        act: (bloc) => bloc.add(const CompanyAiReportsEvent.started(tTicker)),
        verify: (_) => verify(() => mockUseCase(tTicker)).called(1),
        expect: () => [
          const CompanyAiReportsState.loading(),
          isA<CompanyAiReportsLoaded>()
              .having((s) => s.ticker, 'ticker', tTicker)
              .having(
                (s) => s.companyFilings,
                'companyFilings',
                tCompanyFilings,
              )
              .having((s) => s.summaryButtonLabel, 'label', tLabel)
              .having((s) => s.selectedForm, 'form', AiReportForm.tenK)
              .having(
                (s) => s.analyticsState?.dataSource,
                'dataSource',
                CompanyProfileDataOrigin.db,
              ),
        ],
      );

      blocTest<CompanyAiReportsBloc, CompanyAiReportsState>(
        'started_useCaseFails_emitsLoadingThenFailure',
        build: () {
          stubReports(const Left(tFailure));
          return sut;
        },
        act: (bloc) => bloc.add(const CompanyAiReportsEvent.started(tTicker)),
        expect: () => const [
          CompanyAiReportsState.loading(),
          CompanyAiReportsState.failure(tFailure),
        ],
      );

      blocTest<CompanyAiReportsBloc, CompanyAiReportsState>(
        'started_alreadyLoadedForTicker_doesNotRestartStream',
        build: () => sut,
        seed: () => const CompanyAiReportsState.loaded(
          ticker: tTicker,
          companyFilings: tCompanyFilings,
          summaryButtonLabel: tLabel,
        ),
        act: (bloc) => bloc.add(const CompanyAiReportsEvent.started(tTicker)),
        expect: () => const <CompanyAiReportsState>[],
        verify: (_) => verifyNever(() => mockUseCase(any())),
      );

      blocTest<CompanyAiReportsBloc, CompanyAiReportsState>(
        'loadRequested_afterFailure_retriesAndEmitsLoaded',
        build: () {
          stubReports(const Right(tCompanyFilings));
          return sut;
        },
        seed: () => const CompanyAiReportsState.failure(tFailure),
        act: (bloc) =>
            bloc.add(const CompanyAiReportsEvent.loadRequested(tTicker)),
        expect: () => [
          const CompanyAiReportsState.loading(),
          isA<CompanyAiReportsLoaded>(),
        ],
      );

      test('loadRequested_streamEmitsAgain_keepsSelectedForm', () async {
        // arrange
        final controller = StreamController<Either<Failure, CompanyFilings>>();
        addTearDown(controller.close);
        when(() => mockUseCase(any())).thenAnswer((_) => controller.stream);
        sut.add(const CompanyAiReportsEvent.loadRequested(tTicker));
        controller.add(const Right(tCompanyFilings));
        await sut.stream.firstWhere((s) => s is CompanyAiReportsLoaded);
        sut.add(const CompanyAiReportsEvent.formChanged(AiReportForm.eightK));
        await sut.stream.first;

        // act
        controller.add(const Right(CompanyFilings(filings: [])));
        await pumpEventQueue();

        // assert
        expect(loadedOf(sut.state).selectedForm, AiReportForm.eightK);
      });
    });

    group('live updates', () {
      late StreamController<Either<Failure, CompanyFilings>> controller;

      setUp(() {
        controller = StreamController<Either<Failure, CompanyFilings>>();
        addTearDown(controller.close);
        when(() => mockUseCase(any())).thenAnswer((_) => controller.stream);
      });

      test('loadRequested_newFilingArrives_updatesLoadedState', () async {
        // arrange
        const tUpdated = CompanyFilings(filings: [tFiling]);
        sut.add(const CompanyAiReportsEvent.loadRequested(tTicker));
        controller.add(const Right(tCompanyFilings));
        await sut.stream.firstWhere((s) => s is CompanyAiReportsLoaded);

        // act
        controller.add(const Right(tUpdated));
        await pumpEventQueue();

        // assert
        expect(loadedOf(sut.state).companyFilings, tUpdated);
      });

      test('loadRequested_failureAfterLoaded_keepsLoadedState', () async {
        // arrange
        sut.add(const CompanyAiReportsEvent.loadRequested(tTicker));
        controller.add(const Right(tCompanyFilings));
        await sut.stream.firstWhere((s) => s is CompanyAiReportsLoaded);

        // act
        controller.add(const Left(tFailure));
        await pumpEventQueue();

        // assert
        expect(sut.state, isA<CompanyAiReportsLoaded>());
      });
    });

    group('formChanged', () {
      blocTest<CompanyAiReportsBloc, CompanyAiReportsState>(
        'formChanged_loaded_updatesSelectedForm',
        build: () => sut,
        seed: () => const CompanyAiReportsState.loaded(
          ticker: tTicker,
          companyFilings: tCompanyFilings,
          summaryButtonLabel: tLabel,
        ),
        act: (bloc) => bloc.add(
          const CompanyAiReportsEvent.formChanged(AiReportForm.tenQ),
        ),
        expect: () => const [
          CompanyAiReportsState.loaded(
            ticker: tTicker,
            companyFilings: tCompanyFilings,
            summaryButtonLabel: tLabel,
            selectedForm: AiReportForm.tenQ,
          ),
        ],
      );

      blocTest<CompanyAiReportsBloc, CompanyAiReportsState>(
        'formChanged_notLoaded_emitsNothing',
        build: () => sut,
        act: (bloc) => bloc.add(
          const CompanyAiReportsEvent.formChanged(AiReportForm.tenQ),
        ),
        expect: () => const <CompanyAiReportsState>[],
      );
    });

    group('analytics', () {
      blocTest<CompanyAiReportsBloc, CompanyAiReportsState>(
        'tabHidden_afterInteractions_logsViewedFormsAndOpenedContent',
        build: () => sut,
        seed: () => const CompanyAiReportsState.loaded(
          ticker: tTicker,
          companyFilings: tCompanyFilings,
          summaryButtonLabel: tLabel,
        ),
        act: (bloc) async {
          bloc
            ..add(const CompanyAiReportsEvent.tabShown(tTicker))
            ..add(const CompanyAiReportsEvent.formChanged(AiReportForm.eightK))
            ..add(const CompanyAiReportsEvent.reportOpened())
            ..add(const CompanyAiReportsEvent.filingLinkOpened());
          await pumpEventQueue();
          bloc.add(const CompanyAiReportsEvent.tabHidden());
        },
        verify: (_) {
          final logged =
              verify(
                    () => mockAnalytics.logViewSummary(
                      captureAny(),
                      isFinal: true,
                    ),
                  ).captured.single
                  as AiReportsTabViewState;
          expect(logged.viewedTenKTab, isTrue);
          expect(logged.viewedTenQTab, isFalse);
          expect(logged.viewedEightKTab, isTrue);
          expect(logged.openedReport, isTrue);
          expect(logged.openedFilingLink, isTrue);
        },
      );
    });

    group('reset', () {
      blocTest<CompanyAiReportsBloc, CompanyAiReportsState>(
        'reset_loaded_emitsInitial',
        build: () => sut,
        seed: () => const CompanyAiReportsState.loaded(
          ticker: tTicker,
          companyFilings: tCompanyFilings,
          summaryButtonLabel: tLabel,
        ),
        act: (bloc) => bloc.add(const CompanyAiReportsEvent.reset()),
        expect: () => const [CompanyAiReportsState.initial()],
      );
    });
  });
}
