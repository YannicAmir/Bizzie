import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:intl/intl.dart';

class BizzieExpandableChart extends StatefulWidget {
  final String title;
  final List<BizzieChartData> data;
  final int visibleCount;
  final int thresholdCount;
  final NumberFormat? numberFormat;
  final Color positiveColor;
  final Color negativeColor;
  final PaywallSource source;

  const BizzieExpandableChart({
    super.key,
    this.title = 'Chart',
    required this.data,
    required this.visibleCount,
    required this.thresholdCount,
    this.numberFormat,
    this.positiveColor = AppColors.primary,
    this.negativeColor = AppColors.error,
    required this.source,
    this.onViewAllTapped,
    this.onAnalyticsTap,
  });

  final VoidCallback? onViewAllTapped;
  final VoidCallback? onAnalyticsTap;

  @override
  State<BizzieExpandableChart> createState() => _BizzieExpandableChartState();
}

class _BizzieExpandableChartState extends State<BizzieExpandableChart> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveThreshold = widget.thresholdCount;
    final showToggle = widget.data.length > effectiveThreshold;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final isSubscribed = state.maybeMap(
          loaded: (s) => s.user.isSubscribed,
          orElse: () => false,
        );

        final currentVisibleCount = showToggle
            ? (_isExpanded ? null : widget.visibleCount)
            : null;

        return Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: AppTextStyles.h3),
              AppConstants.secondarySectionSpacing,
              BizzieBarChart(
                key: ValueKey(_isExpanded),
                data: widget.data,
                visibleCount: currentVisibleCount,
                numberFormat: widget.numberFormat,
                positiveColor: widget.positiveColor,
                negativeColor: widget.negativeColor,
              ),
              if (showToggle) ...[
                AppConstants.secondarySectionSpacing,
                GestureDetector(
                  onTap: () {
                    if (!_isExpanded) {
                      widget.onAnalyticsTap?.call();
                    }
                    if (isSubscribed) {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                      if (_isExpanded && widget.onViewAllTapped != null) {
                        widget.onViewAllTapped!();
                      }
                    } else {
                      PaywallHelper.showPaywallSequence(
                        context,
                        source: widget.source,
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isExpanded ? 'View Less' : 'View All',
                        style: AppTextStyles.bodyMediumBold.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      if (!isSubscribed) ...[
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          AppAssets.authLockIcon,
                          width: 15,
                          height: 15,
                          colorFilter: ColorFilter.mode(
                            theme.colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
