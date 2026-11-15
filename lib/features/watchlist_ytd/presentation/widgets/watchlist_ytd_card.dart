import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/utils/ytd_price_change_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:bizzie/shared/widgets/company_logo_avatar.dart';
import 'package:flutter/material.dart';

const double _logoSize = 40;
const double _logoToTextSpacing = 12;
const String _semanticsSeparator = ', ';

class WatchlistYtdCard extends StatelessWidget {
  final YtdPriceChange change;
  final String? logoUrl;
  final VoidCallback onTap;

  const WatchlistYtdCard({
    super.key,
    required this.change,
    this.logoUrl,
    required this.onTap,
  });

  String get _semanticsLabel => [
    change.ticker,
    change.companyName,
    change.formattedYtdChangePercent,
  ].join(_semanticsSeparator);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: _semanticsLabel,
      onTap: onTap,
      child: ExcludeSemantics(
        child: GestureDetector(
          onTap: onTap,
          child: _WatchlistYtdCardContent(change: change, logoUrl: logoUrl),
        ),
      ),
    );
  }
}

class _WatchlistYtdCardContent extends StatelessWidget {
  final YtdPriceChange change;
  final String? logoUrl;

  const _WatchlistYtdCardContent({required this.change, this.logoUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(
          color: theme.dividerColor,
          width:
              theme.dividerTheme.thickness ?? AppConstants.defaultBorderWidth,
        ),
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WatchlistYtdCardLogo(ticker: change.ticker, logoUrl: logoUrl),
          const SizedBox(width: _logoToTextSpacing),
          Expanded(child: _WatchlistYtdCardDetails(change: change)),
        ],
      ),
    );
  }
}

class _WatchlistYtdCardLogo extends StatelessWidget {
  final String ticker;
  final String? logoUrl;

  const _WatchlistYtdCardLogo({required this.ticker, this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _logoSize,
      child: FittedBox(
        child: CompanyLogoAvatar(ticker: ticker, logoUrl: logoUrl),
      ),
    );
  }
}

class _WatchlistYtdCardDetails extends StatelessWidget {
  final YtdPriceChange change;

  const _WatchlistYtdCardDetails({required this.change});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          change.ticker,
          style: AppTextStyles.bodyLargeBold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        AppConstants.subSectionSpacing,
        Text(
          change.companyName,
          style: theme.textTheme.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        AppConstants.compactSectionSpacing,
        AppBadge(
          text: change.formattedYtdChangePercent,
          style: change.isPositive
              ? AppBadgeStyle.goodSolid
              : AppBadgeStyle.criticalSolid,
          isLarge: true,
        ),
      ],
    );
  }
}
