import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bizzie/features/company_profile/security/presentation/utils/upcoming_earnings_presentation_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_state.dart';

class UpcomingEarningsWidget extends StatelessWidget {
  const UpcomingEarningsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();

    return BlocBuilder<UpcomingEarningsBloc, UpcomingEarningsState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: -1.0,
                child: child,
              ),
            );
          },
          child: state.maybeMap(
            loaded: (state) {
              return Column(
                key: const ValueKey('earnings_loaded'),
                children: [
                  AppConstants.mainSectionSpacing,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      AppConstants.mainSectionContainerPadding,
                    ),
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
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upcoming Earnings',
                              style: AppTextStyles.bodyMediumBoldSecondary,
                            ),
                            AppConstants.subSectionSpacing,
                            Text(
                              state.earningsDate.daysAwayLabel,
                              style: AppTextStyles.bodyLargeBold,
                            ),
                            AppConstants.subSectionSpacing,
                            Text(
                              state.earningsDate.formattedEarningsDate,
                              style: AppTextStyles.bodySmallSecondary,
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: badgeTheme?.neutralBackground,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.companyProfileCalendarIcon,
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                theme.colorScheme.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            orElse: () =>
                const SizedBox.shrink(key: ValueKey('earnings_empty')),
          ),
        );
      },
    );
  }
}
