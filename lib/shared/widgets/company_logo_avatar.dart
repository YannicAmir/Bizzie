import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const double _avatarSize = 48;
const double _avatarBorderRadius = 12;
const int _initialsLength = 2;

class CompanyLogoAvatar extends StatelessWidget {
  final String ticker;
  final String? logoUrl;

  const CompanyLogoAvatar({super.key, required this.ticker, this.logoUrl});

  @override
  Widget build(BuildContext context) {
    final logoUrl = this.logoUrl;
    if (logoUrl == null || logoUrl.isEmpty) {
      return _TickerInitialsTile(ticker: ticker);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(_avatarBorderRadius),
      child: CachedNetworkImage(
        imageUrl: logoUrl,
        width: _avatarSize,
        height: _avatarSize,
        fit: BoxFit.cover,
        placeholder: (context, url) => _TickerInitialsTile(ticker: ticker),
        errorWidget: (context, url, error) =>
            _TickerInitialsTile(ticker: ticker),
      ),
    );
  }
}

class _TickerInitialsTile extends StatelessWidget {
  final String ticker;

  const _TickerInitialsTile({required this.ticker});

  String get _initials => ticker.length >= _initialsLength
      ? ticker.substring(0, _initialsLength).toUpperCase()
      : ticker.toUpperCase();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: _avatarSize,
      height: _avatarSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(_avatarBorderRadius),
      ),
      child: Text(
        _initials,
        style: AppTextStyles.bodyLargeBold.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
