import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/domain/models/sec_filing.dart';
import 'package:bizzie/features/company_profile/domain/models/business_profile.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/features/company_profile/presentation/utils/business_profile_extensions.dart';
import 'package:flutter/material.dart';

class SecFilingsCard extends StatefulWidget {
  final BusinessProfile profile;

  const SecFilingsCard({super.key, required this.profile});

  @override
  State<SecFilingsCard> createState() => _SecFilingsCardState();
}

class _SecFilingsCardState extends State<SecFilingsCard> {
  bool _isAnnual = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
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
          Text('SEC Filings', style: AppTextStyles.h3),
          const SizedBox(height: 16),
          _FilingTabs(
            isAnnual: _isAnnual,
            isForeign: widget.profile.isForeignCompany,
            onTabChanged: (isAnnual) => setState(() => _isAnnual = isAnnual),
          ),
          const SizedBox(height: 16),
          _FilingsList(
            filings: _isAnnual
                ? widget.profile.annualFilings
                : widget.profile.quarterlyFilings,
            isAnnual: _isAnnual,
            onShowAll: (filings) => _showAllFilings(context, filings),
          ),
        ],
      ),
    );
  }

  void _showAllFilings(BuildContext context, List<SecFiling> filings) {
    AppHistoryModalHelper.show<SecFiling>(
      context: context,
      title: widget.profile.getSecFilingsModalTitle(_isAnnual),
      header: const SizedBox.shrink(),
      data: filings,
      itemBuilder: (context, filing, index) =>
          _FilingItem(filing: filing, isAnnual: _isAnnual),
    );
  }
}

class _FilingTabs extends StatelessWidget {
  final bool isAnnual;
  final bool isForeign;
  final ValueChanged<bool> onTabChanged;

  const _FilingTabs({
    required this.isAnnual,
    required this.isForeign,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _FilingTabButton(
            title: isForeign ? 'Annual' : '10-K (Annual)',
            isActive: isAnnual,
            onTap: () => onTabChanged(true),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _FilingTabButton(
            title: isForeign ? 'Quarterly' : '10-Q (Quarterly)',
            isActive: !isAnnual,
            onTap: () => onTabChanged(false),
          ),
        ),
      ],
    );
  }
}

class _FilingTabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _FilingTabButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppConstants.tabHeight,
        decoration: BoxDecoration(
          color: isActive
              ? theme.colorScheme.primary
              : theme.colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(
            AppConstants.componyProfileButtonBorderRadius,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.bodyMediumBold.copyWith(
            color: isActive
                ? theme.colorScheme.onPrimary
                : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _FilingsList extends StatelessWidget {
  final List<SecFiling> filings;
  final bool isAnnual;
  final Function(List<SecFiling>) onShowAll;

  const _FilingsList({
    required this.filings,
    required this.isAnnual,
    required this.onShowAll,
  });

  @override
  Widget build(BuildContext context) {
    final displayFilings = filings.take(5).toList();
    final hasMore = filings.length > 5;

    if (displayFilings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            'No recent filings found',
            style: AppTextStyles.bodyMedium.copyWith(),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayFilings.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return _FilingItem(
              filing: displayFilings[index],
              isAnnual: isAnnual,
            );
          },
        ),
        if (hasMore) ...[
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => onShowAll(filings),
            child: Text(
              'View All',
              style: AppTextStyles.bodyMediumBold.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _FilingItem extends StatelessWidget {
  final SecFiling filing;
  final bool isAnnual;

  const _FilingItem({required this.filing, required this.isAnnual});

  @override
  Widget build(BuildContext context) {
    String title;
    final formattedDate = BizzieDateFormatter.formatMonthYearFull(filing.date);

    if (isAnnual) {
      title = 'FY | $formattedDate';
    } else {
      title =
          '${filing.period.isNotEmpty ? filing.period.toUpperCase() : ''} | $formattedDate';
    }

    return GestureDetector(
      onTap: () => UrlLauncherUtils.launch(filing.link),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.bodyMedium),
            Text(
              'View →',
              style: AppTextStyles.bodyMediumBold.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
