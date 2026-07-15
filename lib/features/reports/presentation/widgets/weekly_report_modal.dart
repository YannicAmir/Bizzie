import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/reports/domain/models/weekly_report.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const double _kModalMaxSize = 0.875;

class WeeklyReportModal extends StatelessWidget {
  final WeeklyReport report;

  const WeeklyReportModal({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final createdAt = report.createdAt;
    final dateLabel = createdAt != null
        ? DateFormat('MMM d, yyyy').format(createdAt)
        : 'Date Unknown';
    final priceMovement = report.priceMovement;
    final weekEndDate = DateTime.tryParse(report.id ?? '');
    final weekStartDate = weekEndDate?.subtract(const Duration(days: 4));
    return AppBottomModal(
      title: 'End of the Week Summary',
      subtitle: Text(
        '${report.ticker} • $dateLabel • EOTW Summary',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      initialChildSize: _kModalMaxSize,
      minChildSize: _kModalMaxSize,
      maxChildSize: _kModalMaxSize,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          padding: AppConstants.reportModalPadding,
          children: [
            Text(report.messageTitle ?? '', style: theme.textTheme.labelLarge),
            const SizedBox(height: 16),
            Text(
              report.messageLongSummary ?? report.messageShortSummary ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            if (priceMovement != null) ...[
              const SizedBox(height: 24),
              _PriceSection(
                priceMovement: priceMovement,
                startDate: weekStartDate,
                endDate: weekEndDate,
              ),
            ],
            if ((report.newsLinks?.isNotEmpty ?? false) ||
                (report.eightKLinks?.isNotEmpty ?? false)) ...[
              const SizedBox(height: 24),
              _ExpandableLinkSection(
                title: 'Sources',
                newsLinks: report.newsLinks ?? [],
                eightKLinks: report.eightKLinks ?? [],
              ),
            ],
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

class _PriceSection extends StatelessWidget {
  final PriceMovement priceMovement;
  final DateTime? startDate;
  final DateTime? endDate;

  const _PriceSection({
    required this.priceMovement,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFmt = DateFormat('EEE., MMM d, yyyy');
    final start = priceMovement.startPrice;
    final end = priceMovement.endPrice;
    final change = priceMovement.priceChange;
    final changePct = priceMovement.priceChangePercent;
    final isPositive = (change ?? 0) >= 0;
    final badgeStyle = isPositive ? AppBadgeStyle.good : AppBadgeStyle.critical;
    final sign = isPositive ? '+' : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Price Movement', style: theme.textTheme.displaySmall),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _PriceTile(
                label: 'Start',
                subtitle: startDate != null ? dateFmt.format(startDate!) : null,
                child: Text(
                  start != null ? CurrencyFormatter.format(start, null) : '—',
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _PriceTile(
                label: 'End',
                subtitle: endDate != null ? dateFmt.format(endDate!) : null,
                child: Text(
                  end != null ? CurrencyFormatter.format(end, null) : '—',
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _PriceTile(
                label: 'Change',
                child: change != null
                    ? AppBadge(
                        text: '$sign${CurrencyFormatter.format(change, null)}',
                        style: badgeStyle,
                        isLarge: true,
                      )
                    : Text('—', style: theme.textTheme.headlineMedium),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _PriceTile(
                label: 'Change %',
                child: changePct != null
                    ? AppBadge(
                        text: '$sign${changePct.toStringAsFixed(2)}%',
                        style: badgeStyle,
                        isLarge: true,
                      )
                    : Text('—', style: theme.textTheme.headlineMedium),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceTile extends StatelessWidget {
  final String label;
  final Widget child;
  final String? subtitle;

  const _PriceTile({required this.label, required this.child, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
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
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppConstants.subSectionSpacing,
          child,
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ExpandableLinkSection extends StatefulWidget {
  final String title;
  final List<String> newsLinks;
  final List<String> eightKLinks;

  const _ExpandableLinkSection({
    required this.title,
    required this.newsLinks,
    required this.eightKLinks,
  });

  @override
  State<_ExpandableLinkSection> createState() => _ExpandableLinkSectionState();
}

class _ExpandableLinkSectionState extends State<_ExpandableLinkSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalCount = widget.newsLinks.length + widget.eightKLinks.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(widget.title, style: theme.textTheme.displaySmall),
                const SizedBox(width: 8),
                Text(
                  '($totalCount)',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        if (_expanded) ...[
          const SizedBox(height: 8),
          if (widget.eightKLinks.isNotEmpty) ...[
            if (widget.newsLinks.isNotEmpty) const SizedBox(height: 4),
            Text(
              '8-K Filings',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),
            ...widget.eightKLinks.map((link) => _LinkTile(link: link)),
          ],
          const SizedBox(height: 18),
          if (widget.newsLinks.isNotEmpty) ...[
            Text(
              'News',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),
            ...widget.newsLinks.map((link) => _LinkTile(link: link)),
          ],
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _LinkTile extends StatelessWidget {
  final String link;

  const _LinkTile({required this.link});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () =>
          launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          link,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: theme.colorScheme.primary,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
