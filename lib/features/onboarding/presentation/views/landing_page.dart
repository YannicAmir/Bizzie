import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../app/themes/app_assets.dart';
import '../../../../app/themes/app_colors.dart';

import '../../data/datasources/dummy_price_data.dart';
import '../widgets/onboarding_footer.dart';

import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = dummyData.map((data) {
      return ChartData(
        DateTime.parse(data['date'] as String),
        (data['price'] as num).toDouble(),
      );
    }).toList();

    final List<ChartData> reversedData = chartData.reversed.toList();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            _BackgroundChart(data: reversedData),
            Column(
              children: [
                const SizedBox(height: 240),
                const _MascotImage(),
                const Spacer(flex: 1),
                OnboardingFooter(
                  title: 'Meet Bizzie!',
                  subtitle:
                      'Your friend to take with you on your Stock Market journey',
                  primaryButton: BizziePrimaryButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(
                        const OnboardingEvent.loadBrands(),
                      );
                      context.push(AppRoutes.onboardingName);
                    },
                    title: 'Get Started',
                  ),
                  secondaryButton: const _LoginRow(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundChart extends StatelessWidget {
  final List<ChartData> data;

  const _BackgroundChart({required this.data});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Positioned(
      top: 15,
      left: 0,
      right: 0,
      height: 200,
      child: IgnorePointer(
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
              stops: [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: SfCartesianChart(
            margin: EdgeInsets.zero,
            plotAreaBorderWidth: 0,
            primaryXAxis: DateTimeAxis(isVisible: false),
            primaryYAxis: NumericAxis(isVisible: false),
            series: <CartesianSeries>[
              SplineAreaSeries<ChartData, DateTime>(
                dataSource: data,
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
    );
  }
}

class _MascotImage extends StatelessWidget {
  const _MascotImage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Image.asset(
        AppAssets.onboardingBizzieMascot,
        height: 255,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _LoginRow extends StatelessWidget {
  const _LoginRow();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
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
            context.push(AppRoutes.login);
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
    );
  }
}

class ChartData {
  const ChartData(this.date, this.price);
  final DateTime date;
  final double price;
}
