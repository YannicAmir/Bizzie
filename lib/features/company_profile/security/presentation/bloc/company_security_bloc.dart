import 'dart:async';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_security_details_usecase.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

final _logger = BizzieLogger('CompanySecurityBloc');

@injectable
class CompanySecurityBloc
    extends Bloc<CompanySecurityEvent, CompanySecurityState> {
  final GetSecurityDetailsUseCase _getSecurityDetailsUseCase;

  CompanySecurityBloc(this._getSecurityDetailsUseCase)
    : super(const CompanySecurityState.initial()) {
    on<CompanySecurityEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanySecurityEvent event,
    Emitter<CompanySecurityState> emit,
  ) async {
    _logger.info('Handling event: $event');
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanySecurityState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      _logger.info(
        'Skip loading Security: already loaded and no force refresh',
      );
      return;
    }

    _logger.info(
      'Loading Security details for ${event.ticker} (force=${event.forceRefresh})',
    );
    emit(const CompanySecurityState.loading());

    final result = await _getSecurityDetailsUseCase(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load Security details', failure);
        emit(CompanySecurityState.failure(failure));
      },
      (details) {
        _logger.info(
          'Successfully loaded Security details for ${event.ticker}',
        );
        if (details.isEtf || details.isFund) {
          _logger.info(
            'Security is unsupported (ETF or Fund). Emitting unsupported state.',
          );
          emit(CompanySecurityState.unsupported(details));
        } else {
          emit(
            CompanySecurityState.loaded(details, lastUpdated: DateTime.now()),
          );
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
              'Security stale (TTL expired: ${difference.inHours}h). Triggering load.',
            );
            add(
              CompanySecurityEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          } else {
            _logger.info('Security still fresh (Last updated: $lastUpdated)');
          }
        } else {
          _logger.info('Security lastUpdated is null. Triggering load.');
          add(
            CompanySecurityEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      failure: (_) {
        _logger.info('Security in failure state. Triggering retry.');
        add(
          CompanySecurityEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
      initial: (_) {
        _logger.info('Security in initial state. Triggering load.');
        add(
          CompanySecurityEvent.loadRequested(event.ticker, forceRefresh: true),
        );
      },
    );
  }
}
