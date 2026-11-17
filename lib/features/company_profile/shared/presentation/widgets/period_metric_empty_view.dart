import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_empty_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_switch.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:material_ui/material_ui.dart';

class PeriodMetricEmptyView extends StatelessWidget {
  final FinancialPeriod period;
  final String message;
  final ValueChanged<FinancialPeriod> onPeriodChanged;

  const PeriodMetricEmptyView({
    super.key,
    required this.period,
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
          PeriodSwitch(period: period, onPeriodChanged: onPeriodChanged),
          AppConstants.emptyStateTopSpacing,
          CompanyProfileEmptyState(message: message),
        ],
      ),
    );
  }
}
