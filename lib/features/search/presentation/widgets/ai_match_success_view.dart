import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:bizzie/app/themes/app_theme.dart';

import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/shared/widgets/company_list_tile.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';

class AiMatchSuccessView extends StatelessWidget {
  final String productName;
  final StockSymbol stock;
  final SearchSource? source;

  const AiMatchSuccessView({
    super.key,
    required this.productName,
    required this.stock,
    this.source,
  });

  String get _headerText => stock.isPrivate
      ? "No stocks related to '$productName'"
      : "Stocks related to '$productName'";

  String get _symbolText => stock.isPrivate ? "PRIVATE" : stock.symbol;

  void _handleTap(BuildContext context) {
    if (stock.isPrivate) return;

    context.read<SearchBloc>().add(
      SearchEvent.resultClicked(ticker: stock.symbol, isAiResult: true),
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            _headerText,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: theme.extension<MascotThemeExtension>()?.cardShadow,
            ),
            child: CompanyListTile(
              symbol: _symbolText,
              name: stock.name,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onTap: () => _handleTap(context),
            ),
          ),
        ],
      ),
    );
  }
}
