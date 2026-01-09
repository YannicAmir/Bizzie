import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyProfilePage extends StatelessWidget {
  final String ticker;
  final Company? company;

  const CompanyProfilePage({super.key, required this.ticker, this.company});

  @override
  Widget build(BuildContext context) {
    // If we have the object passed via extra, use it. Otherwise, create a temporary one with just the ticker.
    // In a real app, we'd fetch details here if company is null.
    final displayCompany = company ?? Company(ticker: ticker, name: ticker);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(displayCompany.name)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayCompany.ticker,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              displayCompany.name,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                final isInWatchlist = state.maybeMap(
                  loaded: (state) => state.companies.any(
                    (c) => c.ticker == displayCompany.ticker,
                  ),
                  orElse: () => false,
                );

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isInWatchlist) {
                        context.read<WatchlistBloc>().add(
                          WatchlistEvent.removeRequested(displayCompany.ticker),
                        );
                      } else {
                        context.read<WatchlistBloc>().add(
                          WatchlistEvent.addRequested(displayCompany),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isInWatchlist
                          ? theme.colorScheme.errorContainer
                          : theme.colorScheme.primary,
                      foregroundColor: isInWatchlist
                          ? theme.colorScheme.onErrorContainer
                          : theme.colorScheme.onPrimary,
                    ),
                    child: Text(
                      isInWatchlist
                          ? 'Remove from Watchlist'
                          : 'Add to Watchlist',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
