import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/domain/models/business_profile.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyInfoCard extends StatelessWidget {
  final BusinessProfile profile;

  const CompanyInfoCard({super.key, required this.profile});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {}
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(
          color: theme.dividerColor,
          width: AppConstants.defaultBorderWidth,
        ),
      ),
      child: Column(
        children: [
          _CompanyInfoHeader(profile: profile),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.slate200),
          const SizedBox(height: 16),
          _InfoRow(
            iconPath: AppAssets.companyProfileWebsiteIcon,
            text: profile.website.isNotEmpty ? profile.website : 'N/A',
            textColor: AppColors.primary,
            isBold: true,
            onTap: profile.website.isNotEmpty
                ? () => _launchUrl(profile.website)
                : null,
          ),
          const SizedBox(height: 16),
          _InfoRow(
            iconPath: AppAssets.companyProfileLocationIcon,
            text:
                '${profile.address}, ${profile.city}, ${profile.state} ${profile.zip}',
          ),
          const SizedBox(height: 16),
          _InfoRow(
            iconPath: AppAssets.companyProfileDocIcon,
            text: 'Latest Proxy Filing (DEF 14A)',
            textColor: AppColors.primary,
            isBold: true,
            onTap: profile.def14aUrl != null
                ? () => _launchUrl(profile.def14aUrl!)
                : null,
          ),
        ],
      ),
    );
  }
}

class _CompanyInfoHeader extends StatelessWidget {
  final BusinessProfile profile;

  const _CompanyInfoHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.brandChipSelectedBackground, // Matches 0xFFDBEAFE
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            AppAssets.businessIcon,
            width: 20,
            height: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.companyName,
                style: AppTextStyles.h3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${profile.sector} • ${profile.industry}',
                style: AppTextStyles.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String iconPath;
  final String text;
  final Color? textColor;
  final bool isBold;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.iconPath,
    required this.text,
    this.textColor,
    this.isBold = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(iconPath, width: 20, height: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: isBold
                  ? AppTextStyles.bodyMediumBold.copyWith(color: textColor)
                  : AppTextStyles.bodyMedium.copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
