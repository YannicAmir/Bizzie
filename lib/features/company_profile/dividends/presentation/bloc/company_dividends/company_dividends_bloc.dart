import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/dividends/domain/usecases/get_dividend_info_usecase.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_event.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyDividendsBloc');

@injectable
class CompanyDividendsBloc
    extends Bloc<CompanyDividendsEvent, CompanyDividendsState> {
  final GetDividendInfoUseCase _getDividendInfo;

  CompanyDividendsBloc(this._getDividendInfo)
    : super(const CompanyDividendsState.initial()) {
    on<CompanyDividendsEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyDividendsEvent event,
    Emitter<CompanyDividendsState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyDividendsState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      _logger.info(
        'Skip loading dividends: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading dividends for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanyDividendsState.loading());

    final result = await _getDividendInfo(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load dividends', failure);
        emit(CompanyDividendsState.error(failure));
      },
      (info) {
        _logger.info('Successfully loaded dividends');
        emit(CompanyDividendsState.loaded(info, lastUpdated: DateTime.now()));
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
              'Dividends stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyDividendsEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('Dividends still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('Dividends lastUpdated is null. Triggering load.');
          add(
            CompanyDividendsEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      error: (_) {
        _logger.info('Dividends in error state. Triggering retry.');
        add(
          CompanyDividendsEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Dividends in initial state. Triggering load.');
        add(
          CompanyDividendsEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
    );
  }
}
