import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:bizzie/features/search/presentation/widgets/company_list_tile.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class SearchResultsView extends StatelessWidget {
  final List<StockSymbol> results;
  final String query;

  const SearchResultsView({
    super.key,
    required this.results,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            itemCount: results.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final stock = results[index];
              return CompanyListTile(
                symbol: stock.symbol,
                name: stock.name,
                showLeading: false,
                onTap: () {
                  // TODO: Handle selection
                },
              );
            },
          ),
        ),
        _ProductSearchFooter(query: query),
      ],
    );
  }
}

class _ProductSearchFooter extends StatelessWidget {
  final String query;

  const _ProductSearchFooter({required this.query});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'Not seeing what you\'re looking for?',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          BizziePrimaryButton(
            title: 'Search products for "$query"',
            onPressed: () {
              context.read<SearchBloc>().add(
                SearchEvent.aiSearchRequested(query),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
