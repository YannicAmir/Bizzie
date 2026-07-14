import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const int _percentageFlex = 2;

class FinancialStatementsTable extends StatelessWidget {
  final String title;
  final List<FinancialStatementTableRow> rows;
  final VoidCallback? onViewAll;
  final bool showPercentage;
  final String metricHeader;
  final String amountHeader;
  final String percentageHeader;
  final String growthHeader;
  final AlignmentGeometry amountAlignment;
  final TextAlign amountTextAlign;

  const FinancialStatementsTable({
    super.key,
    this.title = 'Table',
    required this.rows,
    this.onViewAll,
    this.showPercentage = true,
    this.metricHeader = 'Metric',
    this.amountHeader = 'Amount',
    this.percentageHeader = '%',
    this.growthHeader = 'Growth',
    this.amountAlignment = Alignment.centerRight,
    this.amountTextAlign = TextAlign.right,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metricFlex = showPercentage ? 3 : 2;
    final amountFlex = showPercentage ? 2 : 3;
    final growthFlex = showPercentage ? 2 : 1;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(
          color: theme.dividerColor,
          width: AppConstants.defaultBorderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              AppConstants.mainSectionContainerPadding,
            ),
            child: Text(title, style: AppTextStyles.h3),
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppConstants.mainSectionContainerPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: metricFlex,
                  child: _HeaderCell(
                    text: metricHeader,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Expanded(
                  flex: amountFlex,
                  child: _HeaderCell(
                    text: amountHeader,
                    alignment: amountAlignment,
                  ),
                ),
                if (showPercentage)
                  Expanded(
                    flex: _percentageFlex,
                    child: _HeaderCell(
                      text: percentageHeader,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                Expanded(
                  flex: growthFlex,
                  child: _HeaderCell(
                    text: growthHeader,
                    alignment: Alignment.centerRight,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rows.length,
            itemBuilder: (context, index) {
              return _DataRow(
                row: rows[index],
                metricFlex: metricFlex,
                amountFlex: amountFlex,
                growthFlex: growthFlex,
                showPercentage: showPercentage,
                amountTextAlign: amountTextAlign,
              );
            },
          ),
          if (onViewAll != null) _ViewAllFooter(onViewAll: onViewAll),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final AlignmentGeometry alignment;

  const _HeaderCell({required this.text, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(text, style: AppTextStyles.bodyMediumBoldSecondary),
    );
  }
}

class _DataRow extends StatelessWidget {
  final FinancialStatementTableRow row;
  final int metricFlex;
  final int amountFlex;
  final int growthFlex;
  final bool showPercentage;
  final TextAlign amountTextAlign;

  const _DataRow({
    required this.row,
    required this.metricFlex,
    required this.amountFlex,
    required this.growthFlex,
    required this.showPercentage,
    required this.amountTextAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
      child: Row(
        children: [
          Expanded(
            flex: metricFlex,
            child: _MetricCell(
              metric: row.metric,
              indicatorColor: row.indicatorColor,
            ),
          ),
          Expanded(
            flex: amountFlex,
            child: Text(
              row.amount,
              textAlign: amountTextAlign,
              style: AppTextStyles.bodyMediumBold,
            ),
          ),
          if (showPercentage)
            Expanded(
              flex: _percentageFlex,
              child: Text(
                row.secondaryValue,
                textAlign: TextAlign.right,
                style: AppTextStyles.bodyMediumBold,
              ),
            ),
          Expanded(
            flex: growthFlex,
            child: Text(
              row.growth,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyMediumBold.copyWith(
                color: row.growthColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewAllFooter extends StatelessWidget {
  static const double _footerLeftPadding = 16.0;
  static const double _lockIconSpacing = 6.0;
  static const double _lockIconSize = 15.0;

  final VoidCallback? onViewAll;

  const _ViewAllFooter({required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final isSubscribed = state.maybeMap(
          loaded: (s) => s.user.isSubscribed,
          orElse: () => false,
        );

        return GestureDetector(
          onTap: () {
            onViewAll?.call();

            if (!isSubscribed) {
              PaywallHelper.showPaywallSequence(
                context,
                source: PaywallSource.company_profile,
              );
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.mainSectionContainerPadding,
            ),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: _footerLeftPadding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View All',
                    style: AppTextStyles.bodyMediumBold.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                  if (!isSubscribed) ...[
                    const SizedBox(width: _lockIconSpacing),
                    SvgPicture.asset(
                      AppAssets.authLockIcon,
                      width: _lockIconSize,
                      height: _lockIconSize,
                      colorFilter: ColorFilter.mode(
                        theme.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MetricCell extends StatelessWidget {
  static const double _indicatorSize = 8;
  static const double _indicatorSpacing = 6;

  final String metric;
  final Color? indicatorColor;

  const _MetricCell({required this.metric, required this.indicatorColor});

  @override
  Widget build(BuildContext context) {
    if (indicatorColor == null) {
      return Text(metric, style: AppTextStyles.bodyMedium);
    }

    return Row(
      children: [
        Container(
          width: _indicatorSize,
          height: _indicatorSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: indicatorColor,
          ),
        ),
        const SizedBox(width: _indicatorSpacing),
        Expanded(child: Text(metric, style: AppTextStyles.bodyMedium)),
      ],
    );
  }
}

class FinancialStatementTableRow {
  final String metric;
  final String amount;
  final String secondaryValue;
  final String growth;
  final Color growthColor;
  final Color? indicatorColor;
  final bool isBold;

  const FinancialStatementTableRow({
    required this.metric,
    required this.amount,
    required this.secondaryValue,
    required this.growth,
    required this.growthColor,
    this.indicatorColor,
    this.isBold = false,
  });
}
