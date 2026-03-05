import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/shared/utils/paywall_helper.dart';

import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';

class BizzieDataTable extends StatelessWidget {
  final String title;
  final Widget header;
  final List<Widget> children;
  final Widget? footer;
  final VoidCallback? onViewMore;
  final VoidCallback? onAnalyticsTap;
  final String? viewMoreLabel;
  final PaywallSource source;

  const BizzieDataTable({
    super.key,
    required this.title,
    required this.header,
    required this.children,
    this.footer,
    this.onViewMore,
    this.onAnalyticsTap,
    this.viewMoreLabel,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(
          color: theme.dividerColor,
          width: AppConstants.defaultBorderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              AppConstants.mainSectionContainerPadding,
            ),
            child: Text(title, style: AppTextStyles.h3),
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppConstants.mainSectionContainerPadding,
            ),
            child: header,
          ),
          ...children.asMap().entries.map((entry) {
            final row = entry.value;

            return Container(
              padding: const EdgeInsets.all(
                AppConstants.mainSectionContainerPadding,
              ),
              child: row,
            );
          }),
          if (onViewMore != null) ...[
            AppConstants.subSectionSpacing,
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                final isSubscribed = state.maybeMap(
                  loaded: (s) => s.user.isSubscribed,
                  orElse: () => false,
                );

                return GestureDetector(
                  onTap: () {
                    onAnalyticsTap?.call();
                    if (isSubscribed) {
                      onViewMore?.call();
                    } else {
                      PaywallHelper.showPaywallSequence(
                        context,
                        source: source,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppConstants.mainSectionContainerPadding,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          viewMoreLabel ?? 'View All',
                          style: AppTextStyles.bodyMediumBold.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                        if (!isSubscribed) ...[
                          const SizedBox(width: 6),
                          SvgPicture.asset(
                            AppAssets.authLockIcon,
                            width: 15,
                            height: 15,
                            colorFilter: ColorFilter.mode(
                              theme.primaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ],

          if (footer != null) ...[
            Padding(
              padding: const EdgeInsets.all(
                AppConstants.mainSectionContainerPadding,
              ),
              child: footer!,
            ),
          ],
        ],
      ),
    );
  }
}
