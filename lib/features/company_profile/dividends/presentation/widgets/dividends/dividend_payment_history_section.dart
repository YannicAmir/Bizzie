import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/company_profile/dividends/domain/extensions/dividend_event_list_extensions.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_event.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/utils/dividend_payment_history_utils.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_table_footer.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/shared/widgets/tables/bizzie_data_table.dart';
import 'package:flutter/material.dart';

class DividendPaymentHistorySection extends StatelessWidget {
  final List<DividendEvent> history;
  final int historyLimit;

  const DividendPaymentHistorySection({
    super.key,
    required this.history,
    required this.historyLimit,
  });

  @override
  Widget build(BuildContext context) {
    final sortedHistory = history.sortedByDateDesc;
    final displayedEvents = sortedHistory.take(historyLimit).toList();
    final hasMore = sortedHistory.length > historyLimit;

    final totalPaidLabel = displayedEvents.length < historyLimit
        ? 'Total'
        : 'Total (Last $historyLimit Quarters)';

    return BizzieDataTable(
      title: 'Table',
      source: PaywallSource.company_profile,
      onViewMore: hasMore
          ? () => _showAllPaymentHistory(context, sortedHistory)
          : null,
      header: const _TableHeaderRow(),
      footer: FinancialTableFooter(
        columns: [
          FinancialTableFooterColumnData(
            label: totalPaidLabel,
            value: '\$${displayedEvents.totalDividends.toStringAsFixed(2)}',
          ),
          FinancialTableFooterColumnData(
            label: 'Average per Quarter',
            value: '\$${displayedEvents.averageDividend.toStringAsFixed(2)}',
          ),
        ],
      ),
      children: [
        for (final (index, event) in displayedEvents.indexed)
          _DividendTableRow(
            event: event,
            previousEvent: index + 1 < sortedHistory.length
                ? sortedHistory[index + 1]
                : null,
          ),
      ],
    );
  }

  void _showAllPaymentHistory(
    BuildContext context,
    List<DividendEvent> history,
  ) {
    AppHistoryModalHelper.show<DividendEvent>(
      context: context,
      title: 'All Dividend Payments',
      header: const _TableHeaderRow(),
      data: history,
      itemBuilder: (context, event, index) {
        final previousEvent = index + 1 < history.length
            ? history[index + 1]
            : null;
        return _DividendTableRow(event: event, previousEvent: previousEvent);
      },
    );
  }
}

class _TableHeaderRow extends StatelessWidget {
  const _TableHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text('Date', style: AppTextStyles.bodyMediumBoldSecondary),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Amount per Share',
            style: AppTextStyles.bodyMediumBoldSecondary,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Change',
            style: AppTextStyles.bodyMediumBoldSecondary,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class _DividendTableRow extends StatelessWidget {
  final DividendEvent event;
  final DividendEvent? previousEvent;

  const _DividendTableRow({required this.event, this.previousEvent});

  @override
  Widget build(BuildContext context) {
    final (changeStr, changeColor) =
        DividendPaymentHistoryUtils.calculateChange(event, previousEvent);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            DividendPaymentHistoryUtils.formatDate(event.paymentDate ?? ''),
            style: AppTextStyles.bodyMedium,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '\$${event.dividend.toStringAsFixed(2)}',
            style: AppTextStyles.bodyMediumBold,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            changeStr,
            style: AppTextStyles.bodyMediumBold.copyWith(color: changeColor),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
