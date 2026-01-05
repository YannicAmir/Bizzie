import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  final SearchBloc searchBloc;

  const SearchPage({super.key, required this.searchBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        return state.map(
          initial: (_) => _buildInitialView(context),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          empty: (_) => const Center(child: Text('No stocks found')),
          failure: (f) => Center(child: Text('Error: ${f.message}')),
          loaded: (data) => _buildResultsList(data.results),
        );
      },
    );
  }

  Widget _buildInitialView(BuildContext context) {
    // Figma Mock Data for "Information Technology"
    final recommendedStocks = [
      {'s': 'AAPL', 'n': 'Apple Inc.', 'icon': AppAssets.businessIcon},
      {'s': 'MSFT', 'n': 'Microsoft Corp.', 'icon': AppAssets.businessIcon},
      {'s': 'NVDA', 'n': 'NVIDIA Corp.', 'icon': AppAssets.businessIcon},
      {
        's': 'AMD',
        'n': 'Advanced Micro Devices',
        'icon': AppAssets.businessIcon,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Information Technology',
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.inputBorder, width: 0.67),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: recommendedStocks.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 0.67,
                  color: AppColors.inputBorder,
                ),
                itemBuilder: (context, index) {
                  final stock = recommendedStocks[index];
                  return ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.mascotBackground,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(stock['icon']!),
                    ),
                    title: Text(
                      stock['s']!,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      stock['n']!,
                      style: AppTextStyles.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right, // Or custom arrow
                      color: AppColors.textTertiary,
                    ),
                    onTap: () {
                      // TODO: Navigate to details
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(List<dynamic> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final stock = results[index];
        return ListTile(
          title: Text(stock.symbol),
          subtitle: Text(stock.name),
          onTap: () {
            // TODO: Handle selection
          },
        );
      },
    );
  }
}
