import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/utils/ytd_price_change_extensions.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/widgets/watchlist_ytd_card.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WatchlistYtdSection extends StatelessWidget {
  final List<YtdPriceChange> changes;

  const WatchlistYtdSection({super.key, required this.changes});

  static const int _columns = 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (changes.isEmpty) return const SizedBox.shrink();

    final rows = changes.chunkedIntoRows(_columns);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppConstants.watchlistYtdTitlePadding,
          child: Text('YTD', style: theme.textTheme.displaySmall),
        ),
        for (var r = 0; r < rows.length; r++) ...[
          if (r > 0)
            const SizedBox(height: AppConstants.watchlistYtdGridSpacing),
          _WatchlistYtdRow(
            row: rows[r],
            columns: _columns,
            onCardTapped: (change) => _onCardTapped(context, change),
          ),
        ],
      ],
    );
  }

  void _onCardTapped(BuildContext context, YtdPriceChange change) {
    context.read<ReportsBloc>().add(
      ReportsEvent.ytdCompanyClicked(ticker: change.ticker),
    );
    context.pushNamed(
      AppRoutes.companyProfileReports,
      pathParameters: {'ticker': change.ticker},
    );
  }
}

class _WatchlistYtdRow extends StatelessWidget {
  final List<YtdPriceChange> row;
  final int columns;
  final void Function(YtdPriceChange change) onCardTapped;

  const _WatchlistYtdRow({
    required this.row,
    required this.columns,
    required this.onCardTapped,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var c = 0; c < columns; c++) ...[
            if (c > 0)
              const SizedBox(width: AppConstants.watchlistYtdGridSpacing),
            Expanded(
              child: c < row.length
                  ? WatchlistYtdCard(
                      change: row[c],
                      onTap: () => onCardTapped(row[c]),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ],
      ),
    );
  }
}
