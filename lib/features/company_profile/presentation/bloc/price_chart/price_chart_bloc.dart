import 'package:bloc/bloc.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/domain/enums/chart_time_frame.dart';
import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/price_chart/price_chart_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/price_chart/price_chart_state.dart';
import 'package:bizzie/features/company_profile/presentation/utils/historical_price_chart_extensions.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('PriceChartBloc');

@injectable
class PriceChartBloc extends Bloc<PriceChartEvent, PriceChartState> {
  PriceChartBloc() : super(PriceChartState.initial()) {
    on<HistoryUpdated>(_onHistoryUpdated);
    on<TimeFrameChanged>(_onTimeFrameChanged);
  }

  void _onHistoryUpdated(HistoryUpdated event, Emitter<PriceChartState> emit) {
    _logger.info('Handling HistoryUpdated: ${event.history.length} points');
    if (event.history == state.fullHistory) return;

    final filtered = _calculateViewData(event.history, state.selectedTimeFrame);

    emit(state.copyWith(fullHistory: event.history, viewData: filtered));
  }

  void _onTimeFrameChanged(
    TimeFrameChanged event,
    Emitter<PriceChartState> emit,
  ) {
    _logger.info('Handling TimeFrameChanged: ${event.timeFrame}');
    if (event.timeFrame == state.selectedTimeFrame) return;

    final filtered = _calculateViewData(state.fullHistory, event.timeFrame);

    emit(
      state.copyWith(selectedTimeFrame: event.timeFrame, viewData: filtered),
    );
  }

  List<HistoricalPriceEod> _calculateViewData(
    List<HistoricalPriceEod> history,
    ChartTimeFrame timeFrame,
  ) {
    _logger.info('Calculating view data for timeframe: $timeFrame');
    if (history.isEmpty) return [];

    return history.filterByTimeFrame(timeFrame).downsample();
  }
}
