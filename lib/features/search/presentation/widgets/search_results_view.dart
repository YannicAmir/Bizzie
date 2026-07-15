import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:bizzie/shared/widgets/company_list_tile.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';

class SearchResultsView extends StatelessWidget {
  final List<StockSymbol> results;
  final String query;
  final SearchSource? source;

  const SearchResultsView({
    super.key,
    required this.results,
    required this.query,
    this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: results.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final stock = results[index];
              return CompanyListTile(
                symbol: stock.symbol,
                name: stock.name,
                showLeading: false,
                onTap: () {
                  context.read<SearchBloc>().add(
                    SearchEvent.resultClicked(
                      ticker: stock.symbol,
                      isAiResult: false,
                    ),
                  );
                  final String routeName = switch (source) {
                    SearchSource.reports => AppRoutes.companyProfileReports,
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

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final isSubscribed = state.maybeMap(
          loaded: (s) => s.user.isSubscribed,
          orElse: () => false,
        );

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
                prefixIcon: !isSubscribed
                    ? SvgPicture.asset(
                        AppAssets.authLockIcon,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.surface,
                          BlendMode.srcIn,
                        ),
                      )
                    : null,
                onPressed: () {
                  if (isSubscribed) {
                    context.read<SearchBloc>().add(
                      SearchEvent.aiSearchRequested(query),
                    );
                  } else {
                    PaywallHelper.showPaywallSequence(
                      context,
                      source: PaywallSource.search,
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
