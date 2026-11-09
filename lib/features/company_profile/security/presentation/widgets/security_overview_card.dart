import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:bizzie/features/company_profile/security/presentation/utils/security_price_summary_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/price_display.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/security_header.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class SecurityOverviewCard extends StatelessWidget {
  final SecurityDetails securityDetails;
  final List<HistoricalPriceEod> prices;
  final SecurityQuote? quote;

  const SecurityOverviewCard({
    super.key,
    required this.securityDetails,
    required this.prices,
    this.quote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final summary = quote?.toPriceSummary() ?? prices.toPriceSummary();

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
          SecurityHeader(securityDetails: securityDetails),
          AppConstants.secondarySectionSpacing,
          PriceDisplay(
            formattedPrice: summary.priceFormatted,
            price: summary.price,
            change: summary.changeFormatted,
            isPositive: summary.isPositiveChange,
            lastUpdated: summary.sessionDate,
          ),
        ],
      ),
    );
  }
}
