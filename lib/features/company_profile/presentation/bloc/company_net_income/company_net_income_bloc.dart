import 'package:bizzie/features/company_profile/domain/usecases/get_net_income_stats_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_net_income/company_net_income_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_net_income/company_net_income_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyNetIncomeBloc
    extends Bloc<CompanyNetIncomeEvent, CompanyNetIncomeState> {
  final GetNetIncomeStatsUseCase _getNetIncomeStatsUseCase;

  CompanyNetIncomeBloc(this._getNetIncomeStatsUseCase)
    : super(const CompanyNetIncomeState.initial()) {
    on<CompanyNetIncomeEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyNetIncomeEvent event,
    Emitter<CompanyNetIncomeState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyNetIncomeState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      return;
    }

    emit(const CompanyNetIncomeState.loading());

    final result = await _getNetIncomeStatsUseCase(event.ticker);

    result.fold(
      (failure) => emit(CompanyNetIncomeState.failure(failure)),
      (stats) => emit(
        CompanyNetIncomeState.loaded(
          netIncomeStats: stats,
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
              CompanyNetIncomeEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          }
        }
      },
      failure: (_) => add(
        CompanyNetIncomeEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
      initial: (_) => add(
        CompanyNetIncomeEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
    );
  }
}
