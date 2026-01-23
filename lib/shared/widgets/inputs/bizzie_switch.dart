import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class BizzieSwitch extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const BizzieSwitch({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
  }) : assert(options.length >= 2, 'BizzieSwitch supports at least 2 options');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: AppConstants.bizzieSwitchHeight,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(
              -1.0 + (2.0 * selectedIndex / (options.length - 1)),
              0.0,
            ),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: FractionallySizedBox(
              widthFactor: 1.0 / options.length,
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withValues(alpha: 0.1),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                    BoxShadow(
                      color: theme.shadowColor.withValues(alpha: 0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                      spreadRadius: -1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: List.generate(options.length, (index) {
              final isSelected = index == selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      style: isSelected
                          ? AppTextStyles.bodyLargeBold
                          : AppTextStyles.bodyLargeBoldSecondary,
                      child: Text(options[index], textAlign: TextAlign.center),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
