import 'dart:async';

import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_upcoming_earnings_usecase.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('UpcomingEarningsBloc');

@injectable
class UpcomingEarningsBloc
    extends Bloc<UpcomingEarningsEvent, UpcomingEarningsState>
    with AuthSessionResetMixin<UpcomingEarningsEvent, UpcomingEarningsState> {
  final GetUpcomingEarningsUseCase _getUpcomingEarningsUseCase;
  final WatchActiveTabUseCase _watchActiveTabUseCase;
  final ITimeProvider _timeProvider;

  String? _ticker;
  StreamSubscription<TabActivation>? _tabSubscription;

  UpcomingEarningsBloc(
    this._getUpcomingEarningsUseCase,
    this._watchActiveTabUseCase,
    this._timeProvider,
    GetAuthStream getAuthStream,
  ) : super(const UpcomingEarningsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: droppable(),
    );
    on<Reset>(_onReset);
    resetOnSessionEnd(getAuthStream, const UpcomingEarningsEvent.reset());
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.security)
        .listen((activation) {
          if (_ticker != null && _ticker == activation.ticker) {
            add(
              UpcomingEarningsEvent.stalenessCheckRequested(activation.ticker),
            );
          }
        });
  }

  @override
  Future<void> close() async {
    await _tabSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<UpcomingEarningsState> emit,
  ) async {
    _ticker = event.ticker;
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      _logger.info(
        'Skip loading Upcoming Earnings: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading Upcoming Earnings for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const UpcomingEarningsState.loading());

    final result = await _getUpcomingEarningsUseCase(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load Upcoming Earnings', failure);
        emit(UpcomingEarningsState.failure(failure));
      },
      (tuple) => _emitLoadedOrEmpty(event.ticker, tuple, emit),
    );
  }

  void _emitLoadedOrEmpty(
    String ticker,
    (DateTime?, CompanyProfileDataOrigin) tuple,
    Emitter<UpcomingEarningsState> emit,
  ) {
    final date = tuple.$1;
    final origin = tuple.$2;

    if (date == null) {
      _logger.info('No upcoming earnings found for $ticker');
      emit(const UpcomingEarningsState.empty());
    } else {
      _logger.info('Successfully loaded Upcoming Earnings for $ticker: $date');
      emit(
        UpcomingEarningsState.loaded(
          date,
          dataSource: origin,
          lastUpdated: _timeProvider.nowLocal,
        ),
      );
    }
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<UpcomingEarningsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) =>
          _evaluateLoadedStaleness(event.ticker, loadedState.lastUpdated),
      failure: (_) => _triggerForceRefresh(
        event.ticker,
        'Upcoming Earnings in failure state. Triggering retry.',
      ),
      initial: (_) => _triggerForceRefresh(
        event.ticker,
        'Upcoming Earnings in initial state. Triggering load.',
      ),
      empty: (_) => _triggerForceRefresh(
        event.ticker,
        'Upcoming Earnings in empty state. Triggering retry/load.',
      ),
    );
  }

  void _evaluateLoadedStaleness(String ticker, DateTime? lastUpdated) {
    if (lastUpdated == null) {
      _triggerForceRefresh(
        ticker,
        'Upcoming Earnings lastUpdated is null. Triggering load.',
      );
      return;
    }

    final difference = _timeProvider.nowLocal.difference(lastUpdated);
    if (difference.inHours >= 24) {
      _triggerForceRefresh(
        ticker,
        'Upcoming Earnings stale (TTL expired: ${difference.inHours}h). '
        'Triggering load.',
      );
    } else {
      _logger.info(
        'Upcoming Earnings still fresh (Last updated: $lastUpdated)',
      );
    }
  }

  void _triggerForceRefresh(String ticker, String logMessage) {
    _logger.info(logMessage);
    add(UpcomingEarningsEvent.loadRequested(ticker, forceRefresh: true));
  }

  Future<void> _onReset(
    Reset event,
    Emitter<UpcomingEarningsState> emit,
  ) async {
    _logger.info('Resetting Upcoming Earnings state');
    _ticker = null;
    emit(const UpcomingEarningsState.initial());
  }
}
