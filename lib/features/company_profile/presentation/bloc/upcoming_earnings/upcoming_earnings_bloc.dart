import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_upcoming_earnings_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/upcoming_earnings/upcoming_earnings_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/upcoming_earnings/upcoming_earnings_state.dart';

final _logger = BizzieLogger('UpcomingEarningsBloc');

@injectable
class UpcomingEarningsBloc
    extends Bloc<UpcomingEarningsEvent, UpcomingEarningsState> {
  final GetUpcomingEarningsUseCase _getUpcomingEarningsUseCase;

  UpcomingEarningsBloc(this._getUpcomingEarningsUseCase)
    : super(const UpcomingEarningsState.initial()) {
    on<UpcomingEarningsEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    UpcomingEarningsEvent event,
    Emitter<UpcomingEarningsState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<UpcomingEarningsState> emit,
  ) async {
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
      (date) {
        if (date == null) {
          _logger.info('No upcoming earnings found for ${event.ticker}');
          emit(const UpcomingEarningsState.empty());
        } else {
          _logger.info(
            'Successfully loaded Upcoming Earnings for ${event.ticker}: $date',
          );
          emit(UpcomingEarningsState.loaded(date, lastUpdated: DateTime.now()));
        }
      },
    );
  }

  Future<void> _onStalenessCheckRequested(StalenessCheckRequested event) async {
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
}
