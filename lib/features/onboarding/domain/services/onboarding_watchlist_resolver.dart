import 'package:bizzie/core/domain/models/company.dart';
import 'package:injectable/injectable.dart';

const _minimumUserSelectedCompanies = 5;

@lazySingleton
class OnboardingWatchlistResolver {
  bool needsDefaults(List<Company> userSelectedCompanies) =>
      userSelectedCompanies.length < _minimumUserSelectedCompanies;

  List<Company> resolve({
    required List<Company> userSelectedCompanies,
    required List<Company> defaultWatchlist,
  }) {
    if (!needsDefaults(userSelectedCompanies)) return userSelectedCompanies;

    final selectedTickers = {
      for (final company in userSelectedCompanies) company.ticker,
    };
    return [
      ...userSelectedCompanies,
      ...defaultWatchlist.where(
        (company) => !selectedTickers.contains(company.ticker),
      ),
    ];
  }
}
