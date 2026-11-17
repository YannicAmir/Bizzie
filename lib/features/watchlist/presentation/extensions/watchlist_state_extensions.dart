import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:collection/collection.dart';

extension WatchlistStateX on WatchlistState {
  bool isInWatchlist(String ticker) {
    return maybeMap(
      loaded: (loaded) =>
          loaded.companies.any((company) => company.ticker == ticker),
      orElse: () => false,
    );
  }

  List<String> get tickerOrder {
    return maybeMap(
      loaded: (loaded) =>
          loaded.companies.map((company) => company.ticker).toList(),
      orElse: () => const <String>[],
    );
  }

  Map<String, String> get logoUrlsByTicker {
    return maybeMap(
      loaded: (loaded) => {
        for (final company in loaded.companies)
          if (company.logoUrl case final logoUrl? when logoUrl.isNotEmpty)
            company.ticker: logoUrl,
      },
      orElse: () => const <String, String>{},
    );
  }

  String? logoUrlFor(String? ticker) {
    return maybeMap(
      loaded: (loaded) => loaded.companies
          .lastWhereOrNull(
            (company) =>
                company.ticker == ticker &&
                (company.logoUrl?.isNotEmpty ?? false),
          )
          ?.logoUrl,
      orElse: () => null,
    );
  }
}
