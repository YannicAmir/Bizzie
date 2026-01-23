import 'package:bloc/bloc.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
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

    emit(state.copyWith(fullHistory: event.history));
    _updateViewData(emit);
  }

  void _onTimeFrameChanged(
    TimeFrameChanged event,
    Emitter<PriceChartState> emit,
  ) {
    _logger.info('Handling TimeFrameChanged: ${event.timeFrame}');
    if (event.timeFrame == state.selectedTimeFrame) return;

    emit(state.copyWith(selectedTimeFrame: event.timeFrame));
    _updateViewData(emit);
  }

  void _updateViewData(Emitter<PriceChartState> emit) {
    _logger.info(
      'Updating view data for timeframe: ${state.selectedTimeFrame}',
    );
    final filtered = state.fullHistory
        .filterByTimeFrame(state.selectedTimeFrame)
        .downsample();

    _logger.info('View data updated: ${filtered.length} points');
    emit(state.copyWith(viewData: filtered));
  }
}
