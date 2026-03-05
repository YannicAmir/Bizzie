import 'package:flutter/material.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/models/feature_highlight_item.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/feature_highlights/expert_widgets.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/feature_highlights/experienced_widgets.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/feature_highlights/beginner_widgets.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/feature_highlights/shared_widgets.dart';

class FeatureHighlightFactory {
  static Widget buildIllustration(
    FeatureHighlightType type,
    OnboardingState state,
  ) {
    switch (type) {
      case FeatureHighlightType.historicalData:
        return const HistoricalDataCard();
      case FeatureHighlightType.financialReportAlerts:
        final companies = state.selectedBrands;
        return FinancialReportAlertsCard(
          primaryAlert: companies.isNotEmpty ? companies[0] : null,
          secondaryAlert: companies.length > 1 ? companies[1] : null,
        );
      case FeatureHighlightType.visualFinancials:
        return const VisualFinancialsCard();
      case FeatureHighlightType.brandSearch:
        final brands = state.selectedBrands;
        final displayBrand = brands.isNotEmpty
            ? brands.first
            : const Brand(
                name: 'Apple',
                company: 'Apple',
                ticker: 'AAPL',
                description: '',
                imageUrl: null,
              );
        return BrandSearchCard(displayBrand: displayBrand);
      case FeatureHighlightType.easyToUnderstand:
        return const EasyToUnderstandCard();
      case FeatureHighlightType.summaryIllustration:
        return SummaryIllustration(currentYear: DateTime.now().year.toString());
    }
  }
}
