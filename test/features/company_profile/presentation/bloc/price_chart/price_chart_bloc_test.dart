import 'package:bizzie/features/company_profile/shared/domain/enums/chart_time_frame.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PriceChartBloc bloc;

  setUp(() {
    bloc = PriceChartBloc();
  });

  const tTicker = 'AAPL';
  final tHistory = List.generate(
    10,
    (i) => HistoricalPriceEod(
      symbol: tTicker,
      date: '2023-01-${i + 10}', // 10th to 19th
      price: 100.0 + i,
      volume: 1000.0,
    ),
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, PriceChartState.initial());
  });

  group('PriceChartBloc - HistoryUpdated', () {
    blocTest<PriceChartBloc, PriceChartState>(
      'historyUpdated_updatesViewDataWithDefaultTimeFrame',
      build: () => bloc,
      act: (bloc) => bloc.add(PriceChartEvent.historyUpdated(tHistory)),
      expect: () => [
        isA<PriceChartState>()
            .having((s) => s.fullHistory, 'fullHistory', tHistory)
            .having(
              (s) => s.viewData.length,
              'viewData length',
              5,
            ) // default 5D sublist
            .having(
              (s) => s.viewData.last.date,
              'last point date',
              '2023-01-19',
            ),
      ],
    );

    blocTest<PriceChartBloc, PriceChartState>(
      'historyUpdated_sameData_skipsEmission',
      build: () => bloc,
      seed: () =>
          PriceChartState(fullHistory: tHistory, viewData: tHistory.sublist(5)),
      act: (bloc) => bloc.add(PriceChartEvent.historyUpdated(tHistory)),
      expect: () => [],
    );
  });

  group('PriceChartBloc - TimeFrameChanged', () {
    blocTest<PriceChartBloc, PriceChartState>(
      'timeFrameChanged_reFiltersViewData',
      build: () => bloc,
      seed: () =>
          PriceChartState(fullHistory: tHistory, viewData: tHistory.sublist(5)),
      act: (bloc) =>
          bloc.add(const PriceChartEvent.timeFrameChanged(ChartTimeFrame.m1)),
      expect: () => [
        isA<PriceChartState>()
            .having(
              (s) => s.selectedTimeFrame,
              'selectedTimeFrame',
              ChartTimeFrame.m1,
            )
            .having(
              (s) => s.viewData.length,
              'viewData length',
              10,
            ), // All within 30 days
      ],
    );

    blocTest<PriceChartBloc, PriceChartState>(
      'timeFrameChanged_sameFrame_skipsEmission',
      build: () => bloc,
      seed: () => const PriceChartState(selectedTimeFrame: ChartTimeFrame.m1),
      act: (bloc) =>
          bloc.add(const PriceChartEvent.timeFrameChanged(ChartTimeFrame.m1)),
      expect: () => [],
    );
  });

  group('PriceChartBloc - Data Transitions', () {
    blocTest<PriceChartBloc, PriceChartState>(
      'handlesEmptyHistory_emitsEmptyViewData',
      build: () => bloc,
      seed: () => PriceChartState(fullHistory: tHistory, viewData: tHistory),
      act: (bloc) => bloc.add(const PriceChartEvent.historyUpdated([])),
      expect: () => [
        isA<PriceChartState>()
            .having((s) => s.fullHistory, 'fullHistory', [])
            .having((s) => s.viewData, 'viewData', []),
      ],
    );
  });
}
