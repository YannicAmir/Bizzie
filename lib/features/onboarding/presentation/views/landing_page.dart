import 'package:flutter/material.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../app/themes/app_assets.dart';
import '../../../../app/themes/app_colors.dart';

import '../../data/datasources/dummy_price_data.dart';
import '../widgets/onboarding_footer.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Parse dummy data for the chart
    final List<ChartData> chartData = dummyData.map((data) {
      return ChartData(
        DateTime.parse(data['date'] as String),
        (data['price'] as num).toDouble(),
      );
    }).toList();

    // Reverse needed if dummy data is newest first, visuals usually go oldest -> newest (left -> right)
    // Checking dummy data from previous turn: "2025-12-29"... "2025-12-26". Yes, it's descending.
    // So we need to reverse it for the chart to look correct (time moving forward).
    final List<ChartData> reversedData = chartData.reversed.toList();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. Live S&P 500 Chart (Background/Top)
            // Figma standardizes this in a container top left.
            // We want it to look like a subtle background element or specific visualization.
            Positioned(
              top: 15, // Brought down by 15px
              left: 0,
              right: 0,
              height: 200, // Fixed height from Figma
              child: IgnorePointer(
                // Chart is visual only
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.scaffoldBackgroundColor,
                        theme.scaffoldBackgroundColor,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.5, 1.0], // Fade out at bottom
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: SfCartesianChart(
                    margin: EdgeInsets.zero, // FULL WIDTH
                    plotAreaBorderWidth: 0,
                    primaryXAxis: DateTimeAxis(isVisible: false),
                    primaryYAxis: NumericAxis(isVisible: false),
                    series: <CartesianSeries>[
                      SplineAreaSeries<ChartData, DateTime>(
                        dataSource: reversedData,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) => data.price,
                        color: const Color(0xFF10B981).withValues(alpha: 0.1),
                        borderColor: const Color(0xFF10B981),
                        borderWidth: 2,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF10B981).withValues(alpha: 0.2),
                            const Color(0xFF10B981).withValues(alpha: 0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. Mascot & Content
            Column(
              children: [
                const SizedBox(
                  height: 240,
                ), // Ensure mascot starts below chart (~280px from top)
                // Mascot
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Image.asset(
                    AppAssets
                        .onboardingBizzieMascot, // "onboardingBizzieMascot" is correct for waving hello
                    height: 255,
                    fit: BoxFit.contain,
                  ),
                ),

                const Spacer(flex: 1),

                // Footer
                OnboardingFooter(
                  title: 'Meet Bizzie!',
                  subtitle:
                      'Your friend to take with you on your Stock Market journey',
                  primaryButton: FilledButton(
                    onPressed: () {
                      context.push(AppRoutes.onboardingName);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  secondaryButton: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(AppRoutes.login);
                        },
                        child: Text(
                          'Login',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  const ChartData(this.date, this.price);
  final DateTime date;
  final double price;
}
