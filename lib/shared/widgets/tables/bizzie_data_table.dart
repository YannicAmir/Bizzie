import 'package:flutter/material.dart';

import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';

class BizzieDataTable extends StatelessWidget {
  final String title;
  final Widget header;
  final List<Widget> children;
  final Widget? footer;
  final VoidCallback? onViewMore;
  final String? viewMoreLabel;

  const BizzieDataTable({
    super.key,
    required this.title,
    required this.header,
    required this.children,
    this.footer,
    this.onViewMore,
    this.viewMoreLabel,
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
            GestureDetector(
              onTap: onViewMore,
              child: Padding(
                padding: const EdgeInsets.all(
                  AppConstants.mainSectionContainerPadding,
                ),
                child: Text(
                  viewMoreLabel ?? 'View All',
                  style: AppTextStyles.bodyMediumBold.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
              ),
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
