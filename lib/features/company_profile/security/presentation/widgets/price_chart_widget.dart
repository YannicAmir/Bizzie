import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/chart_time_frame.dart';
import 'package:bizzie/features/company_profile/security/domain/extensions/historical_price_eod_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_state.dart';
import 'package:bizzie/features/company_profile/presentation/utils/chart_time_frame_extensions.dart';
import 'package:bizzie/features/company_profile/presentation/utils/historical_price_chart_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceChartWidget extends StatelessWidget {
  const PriceChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();
    final primaryColor = theme.primaryColor;

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
      child: BlocBuilder<PriceChartBloc, PriceChartState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price Chart', style: AppTextStyles.h3),
              AppConstants.secondarySectionSpacing,
              _TimeFrameSelector(
                selectedTimeFrame: state.selectedTimeFrame,
                primaryColor: primaryColor,
                onTimeFrameChanged: (frame) {
                  context.read<PriceChartBloc>().add(
                    PriceChartEvent.timeFrameChanged(frame),
                  );
                },
              ),
              AppConstants.secondarySectionSpacing,
              SizedBox(
                height: 250,
                child: state.fullHistory.isEmpty
                    ? const Center(child: Text('No price data available'))
                    : BizzieLineChart(
                        data: state.viewData.toChartDataPoints(),
                        badgeTheme: badgeTheme,
                        tooltipColor: theme.colorScheme.inverseSurface,
                        xLabelFormatter: (label) =>
                            state.selectedTimeFrame.formatDateForChart(label),
                        tooltipLabelFormatter: (label) =>
                            state.selectedTimeFrame.formatDateForTooltip(label),
                        minY: state.viewData.minPrice,
                        maxY: state.viewData.maxPrice,
                        showHorizontalGridLines: true,
                        showTrackballLines: true,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TimeFrameSelector extends StatelessWidget {
  final ChartTimeFrame selectedTimeFrame;
  final Color primaryColor;
  final ValueChanged<ChartTimeFrame> onTimeFrameChanged;

  const _TimeFrameSelector({
    required this.selectedTimeFrame,
    required this.primaryColor,
    required this.onTimeFrameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.buttonHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ChartTimeFrame.values.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final frame = ChartTimeFrame.values[index];
          final isSelected = selectedTimeFrame == frame;
          return GestureDetector(
            onTap: () => onTimeFrameChanged(frame),
            child: Container(
              width: 55,
              height: AppConstants.buttonHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : AppColors.slate100,
                borderRadius: BorderRadius.circular(
                  AppConstants.componyProfileButtonBorderRadius,
                ),
              ),
              child: Text(
                frame.label,
                style: AppTextStyles.bodyMediumBold.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
