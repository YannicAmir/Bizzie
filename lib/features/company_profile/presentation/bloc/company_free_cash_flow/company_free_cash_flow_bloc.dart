import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:injectable/injectable.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_free_cash_flow_stats_usecase.dart';
import 'company_free_cash_flow_event.dart';
import 'company_free_cash_flow_state.dart';

@injectable
class CompanyFreeCashFlowBloc
    extends Bloc<CompanyFreeCashFlowEvent, CompanyFreeCashFlowState> {
  final GetFreeCashFlowStatsUseCase _getFreeCashFlowStats;
  CompanyFreeCashFlowBloc(this._getFreeCashFlowStats)
    : super(const CompanyFreeCashFlowState.initial()) {
    on<CompanyFreeCashFlowEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyFreeCashFlowEvent event,
    Emitter<CompanyFreeCashFlowState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyFreeCashFlowState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      return;
    }

    emit(const CompanyFreeCashFlowState.loading());

    final result = await _getFreeCashFlowStats(event.ticker);

    result.fold(
      (failure) => emit(CompanyFreeCashFlowState.failure(failure)),
      (data) => emit(
        CompanyFreeCashFlowState.loaded(
          fcfStats: data,
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
              CompanyFreeCashFlowEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          }
        }
      },
      failure: (_) => add(
        CompanyFreeCashFlowEvent.loadRequested(
          event.ticker,
          forceRefresh: true,
        ),
      ),
      initial: (_) => add(
        CompanyFreeCashFlowEvent.loadRequested(
          event.ticker,
          forceRefresh: true,
        ),
      ),
    );
  }
}
