import 'package:bizzie/features/company_profile/domain/enums/chart_time_frame.dart';
import 'package:bizzie/features/company_profile/presentation/utils/chart_time_frame_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChartTimeFrameX', () {
    test('label_returnsCorrectStrings', () {
      expect(ChartTimeFrame.d5.label, '5D');
      expect(ChartTimeFrame.m1.label, '1M');
      expect(ChartTimeFrame.m6.label, '6M');
      expect(ChartTimeFrame.y1.label, '1Y');
      expect(ChartTimeFrame.y5.label, '5Y');
      expect(ChartTimeFrame.all.label, 'All');
    });

    test('formatDateForChart_returnsCorrectFormatsByTimeFrame', () {
      const date = '2023-01-15';

      expect(ChartTimeFrame.d5.formatDateForChart(date), 'Sun');
      expect(ChartTimeFrame.y1.formatDateForChart(date), "Jan '23");
      expect(ChartTimeFrame.y5.formatDateForChart(date), "Jan '23");
      expect(ChartTimeFrame.all.formatDateForChart(date), "Jan '23");
      expect(ChartTimeFrame.m1.formatDateForChart(date), '01/15');
      expect(ChartTimeFrame.m6.formatDateForChart(date), '01/15');
    });

    test('formatDateForTooltip_returnsStandardDetailedFormat', () {
      const date = '2023-01-15';
      expect(ChartTimeFrame.d5.formatDateForTooltip(date), 'Jan. 15, 2023');
    });
  });
}
