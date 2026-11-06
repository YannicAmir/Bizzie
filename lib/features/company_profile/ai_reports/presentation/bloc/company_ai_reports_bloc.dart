import 'package:bizzie/core/domain/models/company_filings.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/ai_reports/domain/enums/ai_report_form.dart';
import 'package:bizzie/features/company_profile/ai_reports/domain/usecases/get_company_filings_usecase.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/analytics/ai_reports_tab_analytics.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/analytics/ai_reports_tab_view_state.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_event.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/analytics/base_analytics.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_analytics_mixin.dart';
import 'package:bizzie/features/company_profile/shared/presentation/bloc/company_profile_load_guard_mixin.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyAiReportsBloc');

@injectable
class CompanyAiReportsBloc
    extends Bloc<CompanyAiReportsEvent, CompanyAiReportsState>
    with
        CompanyProfileAnalyticsMixin<
          CompanyAiReportsEvent,
          CompanyAiReportsState,
          AiReportsTabViewState
        >,
        AuthSessionResetMixin<CompanyAiReportsEvent, CompanyAiReportsState>,
        CompanyProfileLoadGuardMixin {
  final GetCompanyFilingsUseCase _getCompanyFilingsUseCase;
  final IConfigService _configService;
  final AiReportsTabAnalytics _analytics;
  final ITimeProvider _timeProvider;

  CompanyAiReportsBloc(
    this._getCompanyFilingsUseCase,
    this._configService,
    this._analytics,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const CompanyAiReportsState.initial()) {
    on<Started>(_onStarted);
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<TabShown>(_onTabShown);
    on<TabHidden>((_, __) async => await onTabHidden());
    on<AppBackgrounded>((_, __) async => await onAppBackgrounded());
    on<AppForegrounded>((_, __) => onAppForegrounded());
    on<FormChanged>(_onFormChanged);
    on<ReportOpened>(_onReportOpened);
    on<FilingLinkOpened>(_onFilingLinkOpened);
    on<Reset>((_, emit) => emit(const CompanyAiReportsState.initial()));
    resetOnSessionEnd(getAuthStream, const CompanyAiReportsEvent.reset());
  }

  @override
  CompanyProfileTabTracker<AiReportsTabViewState> get analyticsTracker =>
      _analytics;

  @override
  String get featureName => 'Company AI Reports';

  @override
  String? get loadedTicker => state.mapOrNull(loaded: (s) => s.ticker);

  AiReportForm get _selectedForm =>
      state.mapOrNull(loaded: (s) => s.selectedForm) ?? AiReportForm.tenK;

  void _onStarted(Started event, Emitter<CompanyAiReportsState> emit) {
    if (shouldSkipLoad(event.ticker, forceRefresh: false)) return;
    add(CompanyAiReportsEvent.loadRequested(event.ticker));
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyAiReportsState> emit,
  ) async {
    _logger.info('Loading AI reports for ${event.ticker}');
    emit(const CompanyAiReportsState.loading());

    final stopwatch = Stopwatch()..start();
    await emit.forEach<Either<Failure, CompanyFilings>>(
      _getCompanyFilingsUseCase(event.ticker),
      onData: (result) {
        stopwatch.stop();
        return result.fold(
          (failure) => _failureState(
            failure,
            ticker: event.ticker,
            loadTimeMs: stopwatch.elapsedMilliseconds,
          ),
          (companyFilings) => _loadedState(
            companyFilings,
            ticker: event.ticker,
            loadTimeMs: stopwatch.elapsedMilliseconds,
          ),
        );
      },
    );
  }

  CompanyAiReportsState _failureState(
    Failure failure, {
    required String ticker,
    required int loadTimeMs,
  }) {
    _logger.severe('Failed to load AI reports for $ticker', failure);
    final currentState = state;
    if (currentState is CompanyAiReportsLoaded) return currentState;

    _recordLoadMetrics(
      ticker: ticker,
      isSuccess: false,
      loadTimeMs: loadTimeMs,
    );
    return CompanyAiReportsState.failure(failure);
  }

  CompanyAiReportsState _loadedState(
    CompanyFilings companyFilings, {
    required String ticker,
    required int loadTimeMs,
  }) {
    _logger.info('Loaded AI reports for $ticker');
    return CompanyAiReportsState.loaded(
      ticker: ticker,
      companyFilings: companyFilings,
      summaryButtonLabel: _configService.aiSummaryButtonLabel,
      selectedForm: _selectedForm,
      analyticsState: _recordLoadMetrics(
        ticker: ticker,
        isSuccess: true,
        dataSource: CompanyProfileDataOrigin.db,
        loadTimeMs: loadTimeMs,
      ),
    );
  }

  AiReportsTabViewState _recordLoadMetrics({
    required String ticker,
    required bool isSuccess,
    required int loadTimeMs,
    CompanyProfileDataOrigin? dataSource,
  }) {
    final session =
        analyticsSession ??
        AiReportsTabViewState(
          ticker: ticker,
          timestamp: _timeProvider.nowLocal.toIso8601String(),
        );
    final metrics = session.copyWith(
      isSuccess: isSuccess,
      dataSource: dataSource,
      loadTimeMs: loadTimeMs,
    );

    if (analyticsSession != null) {
      updateAnalyticsState((_) => metrics);
    }
    return metrics;
  }

  void _onTabShown(TabShown event, Emitter<CompanyAiReportsState> emit) {
    onTabShown(event.ticker, _buildTabShownViewState(event.ticker));
    _markFormViewed(_selectedForm);
  }

  AiReportsTabViewState _buildTabShownViewState(String ticker) {
    final existingState = state.mapOrNull(loaded: (s) => s.analyticsState);
    return AiReportsTabViewState(
      ticker: ticker,
      timestamp: _timeProvider.nowLocal.toIso8601String(),
      loadTimeMs: existingState?.loadTimeMs,
      isSuccess: existingState?.isSuccess ?? false,
      dataSource: existingState?.dataSource,
    );
  }

  void _onFormChanged(FormChanged event, Emitter<CompanyAiReportsState> emit) {
    state.mapOrNull(loaded: (s) => emit(s.copyWith(selectedForm: event.form)));
    _markFormViewed(event.form);
  }

  void _markFormViewed(AiReportForm form) {
    updateAnalyticsState(
      (s) => switch (form) {
        AiReportForm.tenK => s.copyWith(viewedTenKTab: true),
        AiReportForm.tenQ => s.copyWith(viewedTenQTab: true),
        AiReportForm.eightK => s.copyWith(viewedEightKTab: true),
      },
    );
  }

  void _onReportOpened(
    ReportOpened event,
    Emitter<CompanyAiReportsState> emit,
  ) {
    updateAnalyticsState((s) => s.copyWith(openedReport: true));
  }

  void _onFilingLinkOpened(
    FilingLinkOpened event,
    Emitter<CompanyAiReportsState> emit,
  ) {
    updateAnalyticsState((s) => s.copyWith(openedFilingLink: true));
  }
}
