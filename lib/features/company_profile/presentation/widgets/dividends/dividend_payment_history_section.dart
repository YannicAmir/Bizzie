import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/domain/extensions/dividend_event_list_extensions.dart';
import 'package:bizzie/features/company_profile/domain/models/dividend_event.dart';
import 'package:bizzie/features/company_profile/presentation/utils/dividend_payment_history_utils.dart';
import 'package:bizzie/features/company_profile/presentation/utils/dividend_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/shared/widgets/tables/bizzie_data_table.dart';
import 'package:flutter/material.dart';

class DividendPaymentHistorySection extends StatelessWidget {
  final List<DividendEvent> history;

  const DividendPaymentHistorySection({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final sortedHistory = history.sortedByDateDesc;
    final displayedEvents = sortedHistory
        .take(AppConstants.dividendTableRowCount)
        .toList();
    final hasMore = sortedHistory.length > AppConstants.dividendTableRowCount;

    return BizzieDataTable(
      title: 'Table',
      onViewMore: hasMore
          ? () => _showAllPaymentHistory(context, sortedHistory)
          : null,
      header: const _TableHeaderRow(),
      footer: _FooterRow(
        displayedEvents: displayedEvents,
        totalPaid: displayedEvents.totalDividends,
        avgPerQuarter: displayedEvents.averageDividend,
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

class _FooterRow extends StatelessWidget {
  final List<DividendEvent> displayedEvents;
  final double totalPaid;
  final double avgPerQuarter;

  const _FooterRow({
    required this.displayedEvents,
    required this.totalPaid,
    required this.avgPerQuarter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FooterColumn(label: displayedEvents.totalPaidLabel, value: totalPaid),
        const Spacer(),
        _FooterColumn(label: 'Average per Quarter', value: avgPerQuarter),
      ],
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String label;
  final double value;

  const _FooterColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyMediumBoldSecondary),
        AppConstants.subSectionSpacing,
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: AppTextStyles.bodyLargeBold,
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
