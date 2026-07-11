import 'dart:async';

import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
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
    extends Bloc<UpcomingEarningsEvent, UpcomingEarningsState> {
  final GetUpcomingEarningsUseCase _getUpcomingEarningsUseCase;
  final WatchActiveTabUseCase _watchActiveTabUseCase;

  String? _ticker;
  StreamSubscription<TabActivation>? _tabSubscription;

  UpcomingEarningsBloc(
    this._getUpcomingEarningsUseCase,
    this._watchActiveTabUseCase,
  ) : super(const UpcomingEarningsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: droppable(),
    );
    on<Reset>(_onReset);
    _tabSubscription = _watchActiveTabUseCase(NoParams())
        .where((activation) => activation.tab == CompanyProfileTab.security)
        .listen((activation) {
          if (_ticker != null && _ticker == activation.ticker) {
            add(UpcomingEarningsEvent.stalenessCheckRequested(activation.ticker));
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
      (tuple) {
        final date = tuple.$1;
        final origin = tuple.$2;

        if (date == null) {
          _logger.info('No upcoming earnings found for ${event.ticker}');
          emit(const UpcomingEarningsState.empty());
        } else {
          _logger.info(
            'Successfully loaded Upcoming Earnings for ${event.ticker}: $date',
          );
          emit(
            UpcomingEarningsState.loaded(
              date,
              dataSource: origin,
              lastUpdated: DateTime.now(),
            ),
          );
        }
      },
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<UpcomingEarningsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            _logger.info(
              'Upcoming Earnings stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              UpcomingEarningsEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info(
              'Upcoming Earnings still fresh (Last updated: $lastUpdated)',
            );
          }
        } else {
          _logger.info(
            'Upcoming Earnings lastUpdated is null. Triggering load.',
          );
          add(
            UpcomingEarningsEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Upcoming Earnings in failure state. Triggering retry.');
        add(
          UpcomingEarningsEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Upcoming Earnings in initial state. Triggering load.');
        add(
          UpcomingEarningsEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      empty: (_) {
        _logger.info(
          'Upcoming Earnings in empty state. Triggering retry/load.',
        );
        add(
          UpcomingEarningsEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
    );
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
