import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:bizzie/shared/widgets/company_list_tile.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:go_router/go_router.dart';

class SearchResultsView extends StatelessWidget {
  final List<StockSymbol> results;
  final String query;
  final String? sourceTab;

  const SearchResultsView({
    super.key,
    required this.results,
    required this.query,
    this.sourceTab,
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
                  final String routeName = switch (sourceTab) {
                    'reports' => AppRoutes.companyProfileReports,
                    'profile' => AppRoutes.companyProfileProfile,
                    _ => AppRoutes.companyProfileHome,
                  };

                  context.goNamed(
                    routeName,
                    pathParameters: {'ticker': stock.symbol},
                    extra: Company(ticker: stock.symbol, name: stock.name),
                  );
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
              color: theme.colorScheme.onSurfaceVariant,
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
