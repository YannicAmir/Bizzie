import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:bizzie/core/utils/string_extensions.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/shared/widgets/company_list_tile.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';

class SearchInitialView extends StatelessWidget {
  final String? favoriteSector;
  final List<Company> recommendedBrands;
  final SearchSource? source;

  const SearchInitialView({
    super.key,
    this.favoriteSector,
    required this.recommendedBrands,
    this.source,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (favoriteSector == null || recommendedBrands.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'No recommended brands found.\nSector: ${favoriteSector ?? "Unknown"}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (favoriteSector ?? '').formatAsSector(),
            style: theme.textTheme.displaySmall,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: recommendedBrands.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final brand = recommendedBrands[index];
                return CompanyListTile(
                  symbol: brand.ticker,
                  name: brand.name,
                  onTap: () {
                    context.read<SearchBloc>().add(
                      SearchEvent.recommendedClicked(ticker: brand.ticker),
                    );
                    final String routeName = switch (source) {
                      SearchSource.reports => AppRoutes.companyProfileReports,
                      _ => AppRoutes.companyProfileHome,
                    };

                    context.goNamed(
                      routeName,
                      pathParameters: {'ticker': brand.ticker},
                      extra: brand,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
