import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SecurityHeader extends StatelessWidget {
  final SecurityDetails securityDetails;

  const SecurityHeader({super.key, required this.securityDetails});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CompanyLogo(imageUrl: securityDetails.image),
        const SizedBox(width: 16),
        Expanded(
          child: _SecurityTitle(
            name: securityDetails.name,
            ticker: securityDetails.ticker,
            exchange: securityDetails.exchangeShortName,
          ),
        ),
      ],
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  const _CompanyLogo({required this.imageUrl});

  final String? imageUrl;

  static const double _size = 64;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.slate100, AppColors.slate200],
        ),
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
      ),
      alignment: Alignment.center,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => const _PlaceholderLogo(),
              ),
            )
          : const _PlaceholderLogo(),
    );
  }
}

class _PlaceholderLogo extends StatelessWidget {
  const _PlaceholderLogo();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.mainSectionBorderRadius),
      child: Image.asset(AppAssets.appIcon, fit: BoxFit.cover),
    );
  }
}

class _SecurityTitle extends StatelessWidget {
  final String name;
  final String ticker;
  final String? exchange;

  const _SecurityTitle({
    required this.name,
    required this.ticker,
    this.exchange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppTextStyles.h3, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(ticker, style: AppTextStyles.bodyMedium),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text('•', style: AppTextStyles.bodyMedium),
            ),
            Text(exchange ?? '', style: AppTextStyles.bodyMedium),
          ],
        ),
      ],
    );
  }
}
