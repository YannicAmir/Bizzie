import 'dart:async';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/utils/id_utils.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
import 'package:bizzie/core/interfaces/i_lifecycle_service.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_analytics.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_session_mapper.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'company_profile_event.dart';
part 'company_profile_bloc.freezed.dart';

final _logger = BizzieLogger('CompanyProfileBloc');

@injectable
class CompanyProfileBloc
    extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  final CompanyProfileAnalytics _analytics;
  final ILifecycleService _lifecycleService;
  StreamSubscription<BizzieLifecycleState>? _lifecycleSubscription;

  final _sessionStopwatch = Stopwatch();

  CompanyProfileBloc(this._analytics, this._lifecycleService)
    : super(const CompanyProfileState.initial()) {
    on<CompanyProfileEvent>(_onEvent, transformer: sequential());

    _lifecycleSubscription = _lifecycleService.onLifecycleChanged.listen((
      state,
    ) {
      if (!isClosed) {
        add(CompanyProfileEvent.lifecycleChanged(state: state));
      }
    });
  }

  void _onEvent(CompanyProfileEvent event, Emitter<CompanyProfileState> emit) {
    _logger.info('Handling event: $event');
    event.map(
      opened: (e) => _onOpened(e, emit),
      tabViewed: (e) => _onTabViewed(e, emit),
      moreTabIndexChanged: (e) => _onMoreTabIndexChanged(e, emit),
      watchlistStatusChanged: (e) => _onWatchlistStatusChanged(e, emit),
      lifecycleChanged: (e) => _onLifecycleChanged(e, emit),
      closed: (e) => _onClosed(e, emit),
    );
  }

  void _onOpened(_Opened event, Emitter<CompanyProfileState> emit) {
    final currentTicker = state.mapOrNull(active: (s) => s.ticker);
    if (currentTicker == event.ticker) {
      _logger.info(
        'Session already active for ${event.ticker}. Skipping _onOpened.',
      );
      return;
    }

    _sessionStopwatch.reset();
    _sessionStopwatch.start();

    emit(
      CompanyProfileState.active(
        sessionId: IdUtils.generateSessionId(),
        ticker: event.ticker,
        companyName: event.companyName,
        industry: event.industry,
        sector: event.sector,
        viewedTabs: {event.initialTabName},
        activeTabName: event.initialTabName,
        accumulatedSeconds: 0,
        lastActiveStartTime: DateTime.now(),
        initiallyWatchlisted: event.isWatchlisted,
        currentWatchlisted: event.isWatchlisted,
        isCompany: event.isCompany,
        isEtf: event.isEtf,
        isFund: event.isFund,
        lifecycleState: BizzieLifecycleState.foreground,
        moreTabIndex: 0,
      ),
    );
  }

  void _onTabViewed(_TabViewed event, Emitter<CompanyProfileState> emit) {
    state.mapOrNull(
      active: (s) {
        final newTabs = Set<String>.from(s.viewedTabs)..add(event.tabName);
        emit(s.copyWith(viewedTabs: newTabs, activeTabName: event.tabName));
      },
    );
  }

  void _onMoreTabIndexChanged(
    _MoreTabIndexChanged event,
    Emitter<CompanyProfileState> emit,
  ) {
    state.mapOrNull(active: (s) => emit(s.copyWith(moreTabIndex: event.index)));
  }

  void _onWatchlistStatusChanged(
    _WatchlistStatusChanged event,
    Emitter<CompanyProfileState> emit,
  ) {
    state.mapOrNull(
      active: (s) => emit(s.copyWith(currentWatchlisted: event.isWatchlisted)),
    );
  }

  void _onLifecycleChanged(
    _LifecycleChanged event,
    Emitter<CompanyProfileState> emit,
  ) {
    state.mapOrNull(
      active: (s) {
        if (s.lifecycleState == event.state) return;

        if (event.state == BizzieLifecycleState.background) {
          _sessionStopwatch.stop();

          final updatedState = s.copyWith(
            accumulatedSeconds: _sessionStopwatch.elapsed.inSeconds,
            lifecycleState: event.state,
          );

          _logSnapshot(updatedState, isFinal: false);
          emit(updatedState);
        } else if (event.state == BizzieLifecycleState.foreground) {
          _sessionStopwatch.start();
          emit(
            s.copyWith(
              lifecycleState: event.state,
              lastActiveStartTime: DateTime.now(),
            ),
          );
        }
      },
    );
  }

  void _onClosed(_Closed event, Emitter<CompanyProfileState> emit) {
    state.mapOrNull(
      active: (s) {
        _sessionStopwatch.stop();

        final finalSeconds = _sessionStopwatch.elapsed.inSeconds;
        _logSnapshot(
          s.copyWith(accumulatedSeconds: finalSeconds),
          isFinal: true,
        );

        _sessionStopwatch.reset();
        emit(const CompanyProfileState.initial());
      },
    );
  }

  void _logSnapshot(Active activeState, {required bool isFinal}) {
    final summary = activeState.toSummary(isFinal: isFinal);
    if (summary != null) {
      try {
        _analytics.logSessionSummary(summary);
      } catch (e, s) {
        _logger.severe('Failed to log session summary', e, s);
      }
    }
  }

  @override
  Future<void> close() {
    _lifecycleSubscription?.cancel();
    return super.close();
  }
}
