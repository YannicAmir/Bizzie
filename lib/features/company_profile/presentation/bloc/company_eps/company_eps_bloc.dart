import 'package:bizzie/features/company_profile/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_eps_stats_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_eps/company_eps_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_eps/company_eps_state.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyEpsBloc extends Bloc<CompanyEpsEvent, CompanyEpsState> {
  final GetEpsStatsUseCase _getEpsStatsUseCase;

  CompanyEpsBloc(this._getEpsStatsUseCase)
    : super(const CompanyEpsState.initial()) {
    on<CompanyEpsEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyEpsEvent event,
    Emitter<CompanyEpsState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyEpsState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      return;
    }

    emit(const CompanyEpsState.loading());

    final result = await _getEpsStatsUseCase(event.ticker);

    result.fold(
      (failure) => emit(CompanyEpsState.failure(failure)),
      (stats) => emit(
        CompanyEpsState.loaded(
          epsStats: stats,
          annualChartData: _toChartData(stats.annualEps, isAnnual: true),
          quarterlyChartData: _toChartData(stats.quarterlyEps, isAnnual: false),
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
              CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          }
        }
      },
      failure: (_) =>
          add(CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true)),
      initial: (_) =>
          add(CompanyEpsEvent.loadRequested(event.ticker, forceRefresh: true)),
    );
  }

  List<ChartDataPoint> _toChartData(
    List<FinancialDataPoint> dataPoints, {
    required bool isAnnual,
  }) {
    return dataPoints.reversed.map((p) {
      final label = BizzieDateFormatter.formatChartLabel(
        p.date,
        isAnnual: isAnnual,
      );
      return ChartDataPoint(label: label, value: p.value);
    }).toList();
  }
}
