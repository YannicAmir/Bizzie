import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyWatchlistButton extends StatelessWidget {
  final String ticker;
  final String? companyName;

  const CompanyWatchlistButton({
    super.key,
    required this.ticker,
    this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        final isInWatchlist = state.maybeMap(
          loaded: (s) => s.companies.any((c) => c.ticker == ticker),
          orElse: () => false,
        );

        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: SizedBox(
              height: 36,
              child: ElevatedButton(
                onPressed: () {
                  final bloc = context.read<WatchlistBloc>();
                  if (isInWatchlist) {
                    bloc.add(WatchlistEvent.removeRequested(ticker));
                  } else {
                    final company = Company(
                      ticker: ticker,
                      name: companyName ?? ticker,
                    );
                    bloc.add(WatchlistEvent.addRequested(company));
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isInWatchlist) ...[
                      const Icon(Icons.check, size: 16),
                      const SizedBox(width: 4),
                      const Text('In Watchlist'),
                    ] else ...[
                      const Icon(Icons.add, size: 16),
                      const SizedBox(width: 4),
                      const Text('Watch'),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
