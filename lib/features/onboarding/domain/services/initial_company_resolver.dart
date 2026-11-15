import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:bizzie/features/onboarding/domain/models/initial_company_selection.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_skip_defaults.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InitialCompanyResolver {
  InitialCompanySelection resolve({
    required List<Company> userSelectedCompanies,
    required OnboardingSkipDefaults defaults,
  }) {
    return fromUserSelection(userSelectedCompanies) ?? fromDefaults(defaults);
  }

  InitialCompanySelection? fromUserSelection(
    List<Company> userSelectedCompanies,
  ) {
    final userSelectedCompany = userSelectedCompanies.firstOrNull;
    if (userSelectedCompany == null) return null;
    return InitialCompanySelection(
      ticker: userSelectedCompany.ticker,
      source: OnboardingValueSource.userSelection,
    );
  }

  InitialCompanySelection fromDefaults(OnboardingSkipDefaults defaults) {
    return InitialCompanySelection(
      ticker: _defaultTicker(defaults),
      source: OnboardingValueSource.remoteDefault,
    );
  }

  String _defaultTicker(OnboardingSkipDefaults defaults) {
    final watchlist = defaults.defaultWatchlist;
    final isInDefaultWatchlist = watchlist.any(
      (company) => company.ticker == defaults.initialCompanyTicker,
    );
    if (isInDefaultWatchlist || watchlist.isEmpty) {
      return defaults.initialCompanyTicker;
    }
    return watchlist.first.ticker;
  }
}
