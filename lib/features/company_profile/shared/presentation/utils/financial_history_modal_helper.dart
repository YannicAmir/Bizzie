import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/shared/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_period_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_data_table.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:material_ui/material_ui.dart';

abstract class FinancialHistoryModalHelper {
  static void show(
    BuildContext context, {
    required String title,
    required List<FinancialDataPoint> data,
    required String metricLabel,
    required String currency,
    required FinancialPeriod period,
    bool isInverseGrowth = false,
  }) {
    final sortedData = data.sortedByDateDescending();
    final dateFormat = period.tableDateFormat;

    AppHistoryModalHelper.show<FinancialDataPoint>(
      context: context,
      title: title,
      header: FinancialTableHeader(
        metricLabel: metricLabel,
        dateFormat: dateFormat,
        periodHeaderLabel: period.tableHeaderLabel,
      ),
      data: sortedData,
      itemBuilder: (context, item, index) => FinancialTableRow(
        item: item,
        index: index,
        allData: sortedData,
        currency: currency,
        isInverseGrowth: isInverseGrowth,
        dateFormat: dateFormat,
      ),
    );
  }
}
