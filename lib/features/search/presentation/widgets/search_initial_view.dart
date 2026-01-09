import 'package:flutter/material.dart';
import 'package:bizzie/core/utils/string_extensions.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/shared/widgets/company_list_tile.dart';

class SearchInitialView extends StatelessWidget {
  final String? favoriteSector;
  final List<Company> recommendedBrands;

  const SearchInitialView({
    super.key,
    this.favoriteSector,
    required this.recommendedBrands,
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (favoriteSector ?? '').toTitleCase(),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: recommendedBrands.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final brand = recommendedBrands[index];
                return CompanyListTile(
                  symbol: brand.ticker,
                  name: brand.name,
                  onTap: () {
                    // TODO: Navigate to details
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
