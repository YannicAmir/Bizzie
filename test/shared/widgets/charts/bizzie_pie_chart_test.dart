import 'package:bizzie/shared/widgets/charts/bizzie_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _Host extends StatefulWidget {
  const _Host();

  @override
  State<_Host> createState() => _HostState();
}

class _HostState extends State<_Host> {
  int rebuildCount = 0;

  void rebuild() => setState(() => rebuildCount++);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: BizziePieChart(
        title: 'Chart',
        currency: 'USD',
        data: [
          BizziePieChartData(
            label: 'Assets',
            value: 475000000000,
            color: Colors.green,
          ),
          BizziePieChartData(
            label: 'Liabilities',
            value: 125000000000,
            color: Colors.red,
          ),
          BizziePieChartData(
            label: 'Equity',
            value: 479000000000,
            color: Colors.blue,
          ),
        ],
        centerWidget:
            const ChartCenterMetric(label: 'Equity', value: r'$479B'),
      ),
    );
  }
}

void main() {
  testWidgets(
    'chart survives fontsChange after layout settles (regression: '
    'sizeAccessAllowed assert in DoughnutSeriesRenderer)',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: _Host())),
      );
      for (int i = 0; i < 40; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }

      // This is what google_fonts triggers when an async font load
      // completes; it previously crashed the builder-based labels.
      await tester.binding.handleSystemMessage(<String, dynamic>{
        'type': 'fontsChange',
      });
      await tester.pump();
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }

      // Rebuild with identical values, then again after a font change.
      tester.state<_HostState>(find.byType(_Host)).rebuild();
      await tester.pump();
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }

      expect(tester.takeException(), isNull);
      expect(find.byType(BizziePieChart), findsOneWidget);
    },
  );
}
