import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/business/domain/models/sec_filing.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/features/company_profile/business/presentation/utils/business_profile_extensions.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_bloc.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_event.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/core/enums/paywall_source.dart';

class SecFilingsCard extends StatefulWidget {
  final BusinessProfile profile;
  final int historyCount;

  const SecFilingsCard({
    super.key,
    required this.profile,
    required this.historyCount,
  });

  @override
  State<SecFilingsCard> createState() => _SecFilingsCardState();
}

class _SecFilingsCardState extends State<SecFilingsCard> {
  FinancialPeriod _period = FinancialPeriod.annual;

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
            period: _period,
            isForeign: widget.profile.isForeignCompany,
            onTabChanged: (period) => setState(() => _period = period),
          ),
          const SizedBox(height: 16),
          _FilingsList(
            filings: switch (_period) {
              FinancialPeriod.annual => widget.profile.annualFilings,
              FinancialPeriod.quarterly => widget.profile.quarterlyFilings,
            },
            period: _period,
            onShowAll: (filings) => _showAllFilings(context, filings),
            historyCount: widget.historyCount,
          ),
        ],
      ),
    );
  }

  void _showAllFilings(BuildContext context, List<SecFiling> filings) {
    AppHistoryModalHelper.show<SecFiling>(
      context: context,
      title: widget.profile.getSecFilingsModalTitle(_period),
      header: const SizedBox.shrink(),
      data: filings,
      itemBuilder: (context, filing, index) =>
          _FilingItem(filing: filing, period: _period),
    );
  }
}

class _FilingTabs extends StatelessWidget {
  final FinancialPeriod period;
  final bool isForeign;
  final ValueChanged<FinancialPeriod> onTabChanged;

  const _FilingTabs({
    required this.period,
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
            isActive: period == FinancialPeriod.annual,
            onTap: () => onTabChanged(FinancialPeriod.annual),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _FilingTabButton(
            title: isForeign ? 'Quarterly' : '10-Q (Quarterly)',
            isActive: period == FinancialPeriod.quarterly,
            onTap: () => onTabChanged(FinancialPeriod.quarterly),
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
            AppConstants.companyProfileButtonBorderRadius,
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
  final FinancialPeriod period;
  final Function(List<SecFiling>) onShowAll;
  final int historyCount;

  const _FilingsList({
    required this.filings,
    required this.period,
    required this.onShowAll,
    required this.historyCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayFilings = filings.take(historyCount).toList();
    final hasMore = filings.length > historyCount;

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
            return _FilingItem(filing: displayFilings[index], period: period);
          },
        ),
        if (hasMore) ...[
          const SizedBox(height: 16),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              final isSubscribed = state.maybeMap(
                loaded: (s) => s.user.isSubscribed,
                orElse: () => false,
              );

              return GestureDetector(
                onTap: () {
                  context.read<CompanyBusinessBloc>().add(
                    CompanyBusinessEvent.analyticsInteractionOccurred(
                      viewAll10KsTapped: period.isAnnual ? true : null,
                      viewAll10QsTapped: !period.isAnnual ? true : null,
                    ),
                  );

                  if (isSubscribed) {
                    onShowAll(filings);
                  } else {
                    PaywallHelper.showPaywallSequence(
                      context,
                      source: PaywallSource.company_profile,
                      tabName: 'business_tab',
                      featureName: switch (period) {
                        FinancialPeriod.annual => '10_k_filings',
                        FinancialPeriod.quarterly => '10_q_filings',
                      },
                    );
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: AppTextStyles.bodyMediumBold.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    if (!isSubscribed) ...[
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        AppAssets.authLockIcon,
                        width: 15,
                        height: 15,
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}

class _FilingItem extends StatelessWidget {
  final SecFiling filing;
  final FinancialPeriod period;

  const _FilingItem({required this.filing, required this.period});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final formattedDate = BizzieDateFormatter.formatMonthYearFull(filing.date);
    final title = switch (period) {
      FinancialPeriod.annual => 'FY | $formattedDate',
      FinancialPeriod.quarterly =>
        '${filing.period.isNotEmpty ? filing.period.toUpperCase() : ''} | $formattedDate',
    };

    return GestureDetector(
      onTap: () {
        context.read<CompanyBusinessBloc>().add(
          CompanyBusinessEvent.analyticsInteractionOccurred(
            viewed10Ks: period.isAnnual ? true : null,
            viewed10Qs: !period.isAnnual ? true : null,
          ),
        );
        UrlLauncherUtils.launch(filing.link);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.bodyMedium),
            Text(
              'View →',
              style: AppTextStyles.bodyMediumBold.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
