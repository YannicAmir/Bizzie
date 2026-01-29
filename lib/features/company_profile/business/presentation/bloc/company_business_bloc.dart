import 'dart:async';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/business/domain/usecases/get_business_profile_usecase.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_event.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyBusinessBloc');

@injectable
class CompanyBusinessBloc
    extends Bloc<CompanyBusinessEvent, CompanyBusinessState> {
  final GetBusinessProfileUseCase _getBusinessProfileUseCase;

  CompanyBusinessBloc(this._getBusinessProfileUseCase)
    : super(const CompanyBusinessState.initial()) {
    on<CompanyBusinessEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyBusinessEvent event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      _logger.info(
        'Skip loading company business: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading company business profile for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanyBusinessState.loading());

    final result = await _getBusinessProfileUseCase(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load company business profile', failure);
        emit(CompanyBusinessState.failure(failure));
      },
      (profile) {
        _logger.info('Successfully loaded company business profile');
        emit(CompanyBusinessState.loaded(profile, lastUpdated: DateTime.now()));
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
              'Company business stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanyBusinessEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info(
              'Company business still fresh (Last updated: $lastUpdated)',
            );
          }
        } else {
          _logger.info(
            'Company business lastUpdated is null. Triggering load.',
          );
          add(
            CompanyBusinessEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Company business in failure state. Triggering retry.');
        add(
          CompanyBusinessEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Company business in initial state. Triggering load.');
        add(
          CompanyBusinessEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
    );
  }
}
