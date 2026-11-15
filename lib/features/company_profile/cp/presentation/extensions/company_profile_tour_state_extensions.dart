import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/growth_band.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_highlights_resolver.dart';

extension CompanyProfileTourStateX on CompanyProfileTourState {
  bool get isTourActive => maybeMap(active: (_) => true, orElse: () => false);

  bool get isAwaitingRevenue =>
      mapOrNull(active: (active) => active.isAwaitingRevenueData) ?? false;

  CompanyProfileTourStep? get visibleStep => mapOrNull(
    active: (active) => active.isAwaitingRevenueData ? null : active.step,
  );

  String? descriptionFor(CompanyProfileTourStep step) =>
      mapOrNull(active: (active) => active.describe(step));

  bool canGoBackFrom(CompanyProfileTourStep step) =>
      mapOrNull(
        active: (active) => active.step == step && active.previousStep != null,
      ) ??
      false;
}

extension CompanyProfileTourActiveX on CompanyProfileTourActive {
  CompanyProfileTourStep? get previousStep {
    final previous = step.previous;
    return previous != null && completedSteps.contains(previous)
        ? previous
        : null;
  }

  String? describe(CompanyProfileTourStep targetStep) => switch (targetStep) {
    CompanyProfileTourStep.companyOverview =>
      'You are currently in the Company Profile of $companyName ($ticker). '
          "Company Profiles are where you'll get the most value in Bizzie.",
    CompanyProfileTourStep.tabs =>
      'Use the tabs to get an in-depth look at the business, get company '
          'news, and information about the stock.',
    CompanyProfileTourStep.revenueTab =>
      "Let's check out $companyName's revenue!\n"
          'Tap "Revenue" to continue.',
    CompanyProfileTourStep.revenueGrowth => _revenueGrowthDescription(),
    CompanyProfileTourStep.stayUpdated =>
      'Add companies to your watchlist and turn on your notifications to '
          "stay updated on news and AI Reports as soon as they're released. "
          'Happy investing!',
  };

  String? _revenueGrowthDescription() {
    final growth = revenueGrowth;
    if (growth == null) return null;

    final period = _periodOf(growth);
    return switch (growth.band) {
      GrowthBand.negative || GrowthBand.turnedNegative =>
        "It looks like $companyName's revenue has declined $period. This is "
            "something you'll want to investigate in $companyName's reports "
            'and news.',
      GrowthBand.low =>
        "It looks like $companyName's revenue growth has been slow and steady "
            '$period.',
      GrowthBand.moderate =>
        "It looks like $companyName's revenue growth has been moderate, not "
            'flashy $period.',
      GrowthBand.high =>
        "It looks like $companyName's revenue growth has been impressive "
            '$period!',
      GrowthBand.turnedPositive =>
        "It looks like $companyName's revenue has turned positive $period!",
    };
  }

  String _periodOf(GrowthHighlight growth) => growth.years > 1
      ? 'over the past ${growth.years} years'
      : 'over the past year';
}
