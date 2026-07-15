import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:flutter/material.dart';

class PeriodSwitch extends StatelessWidget {
  final bool isAnnual;
  final ValueChanged<bool> onPeriodChanged;

  const PeriodSwitch({
    super.key,
    required this.isAnnual,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BizzieSwitch(
      options: const ['Yearly', 'Quarterly'],
      selectedIndex: isAnnual ? 0 : 1,
      onChanged: (index) => onPeriodChanged(index == 0),
    );
  }
}
