import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:flutter/material.dart';

class PeriodSwitch extends StatelessWidget {
  final FinancialPeriod period;
  final ValueChanged<FinancialPeriod> onPeriodChanged;

  const PeriodSwitch({
    super.key,
    required this.period,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BizzieSwitch(
      options: const ['Yearly', 'Quarterly'],
      selectedIndex: switch (period) {
        FinancialPeriod.annual => 0,
        FinancialPeriod.quarterly => 1,
      },
      onChanged: (index) => onPeriodChanged(
        index == 0 ? FinancialPeriod.annual : FinancialPeriod.quarterly,
      ),
    );
  }
}
