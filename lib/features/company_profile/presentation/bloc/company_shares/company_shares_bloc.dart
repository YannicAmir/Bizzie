import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:injectable/injectable.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_share_stats_usecase.dart';
import 'company_shares_event.dart';
import 'company_shares_state.dart';

@injectable
class CompanySharesBloc extends Bloc<CompanySharesEvent, CompanySharesState> {
  final GetShareStatsUseCase _getShareStats;
  CompanySharesBloc(this._getShareStats)
    : super(const CompanySharesState.initial()) {
    on<CompanySharesEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanySharesEvent event,
    Emitter<CompanySharesState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanySharesState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      return;
    }

    emit(const CompanySharesState.loading());

    final result = await _getShareStats(event.ticker);

    result.fold(
      (failure) => emit(CompanySharesState.failure(failure)),
      (data) => emit(
        CompanySharesState.loaded(
          shareStats: data,
          lastUpdated: DateTime.now(),
        ),
      ),
    );
  }

  Future<void> _onStalenessCheckRequested(StalenessCheckRequested event) async {
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            add(
              CompanySharesEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          }
        }
      },
      failure: (_) => add(
        CompanySharesEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
      initial: (_) => add(
        CompanySharesEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
    );
  }
}
