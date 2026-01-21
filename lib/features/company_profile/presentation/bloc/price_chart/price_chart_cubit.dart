import 'package:bloc/bloc.dart';
import 'package:bizzie/features/company_profile/domain/enums/chart_time_frame.dart';
import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/price_chart/price_chart_state.dart';
import 'package:bizzie/features/company_profile/presentation/utils/historical_price_chart_extensions.dart';
import 'package:injectable/injectable.dart';

@injectable
class PriceChartCubit extends Cubit<PriceChartState> {
  PriceChartCubit() : super(PriceChartState.initial());

  void fullHistoryChanged(List<HistoricalPriceEod> history) {
    if (history == state.fullHistory) return;

    emit(state.copyWith(fullHistory: history));
    _updateViewData();
  }

  void timeFrameChanged(ChartTimeFrame timeFrame) {
    if (timeFrame == state.selectedTimeFrame) return;

    emit(state.copyWith(selectedTimeFrame: timeFrame));
    _updateViewData();
  }

  void _updateViewData() {
    final filtered = state.fullHistory
        .filterByTimeFrame(state.selectedTimeFrame)
        .downsample();

    emit(state.copyWith(viewData: filtered));
  }
}
