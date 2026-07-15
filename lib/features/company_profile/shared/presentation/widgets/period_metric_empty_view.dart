import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_switch.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';

class PeriodMetricEmptyView extends StatelessWidget {
  final bool isAnnual;
  final String message;
  final ValueChanged<bool> onPeriodChanged;

  const PeriodMetricEmptyView({
    super.key,
    required this.isAnnual,
    required this.message,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PeriodSwitch(isAnnual: isAnnual, onPeriodChanged: onPeriodChanged),
          AppConstants.emptyStateTopSpacing,
          BizzieEmptyState(
            mascotAsset: AppAssets.defaultMascot,
            message: message,
          ),
        ],
      ),
    );
  }
}
