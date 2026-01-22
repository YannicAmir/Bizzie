import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/historical_price_eod/historical_price_eod_state.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/historical_price_eod/historical_price_eod_state_extensions.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/security/price_display.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/security/security_header.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class SecurityOverviewCard extends StatelessWidget {
  final SecurityDetails securityDetails;
  final List<HistoricalPriceEod> prices;

  const SecurityOverviewCard({
    super.key,
    required this.securityDetails,
    required this.prices,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priceState = HistoricalPriceEodState.loaded(prices);

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
            price: priceState.currentPriceFormatted,
            change: priceState.changeFormatted,
            isPositive: priceState.isPositiveChange,
            lastUpdated: priceState.lastUpdatedDate,
          ),
        ],
      ),
    );
  }
}
