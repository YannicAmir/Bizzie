import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:injectable/injectable.dart';
import 'package:bizzie/features/company_profile/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_fcps_stats_usecase.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'company_fcps_event.dart';
import 'company_fcps_state.dart';

@injectable
class CompanyFcpsBloc extends Bloc<CompanyFcpsEvent, CompanyFcpsState> {
  final GetFcpsStatsUseCase _getFcpsStats;
  CompanyFcpsBloc(this._getFcpsStats)
    : super(const CompanyFcpsState.initial()) {
    on<CompanyFcpsEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyFcpsEvent event,
    Emitter<CompanyFcpsState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyFcpsState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      return;
    }

    emit(const CompanyFcpsState.loading());

    final result = await _getFcpsStats(event.ticker);

    result.fold(
      (failure) => emit(CompanyFcpsState.failure(failure)),
      (data) => emit(
        CompanyFcpsState.loaded(
          fcpsStats: data,
          annualChartData: _toChartData(data.annualFcps, isAnnual: true),
          quarterlyChartData: _toChartData(data.quarterlyFcps, isAnnual: false),
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
              CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          }
        }
      },
      failure: (_) =>
          add(CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true)),
      initial: (_) =>
          add(CompanyFcpsEvent.loadRequested(event.ticker, forceRefresh: true)),
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
