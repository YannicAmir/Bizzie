import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/data/datasources/dummy_price_data.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/models/price_chart_point.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.landing),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            const _BackgroundChart(),
            Column(
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height *
                      AppConstants.onboardLandingMascotTopFactor,
                ),
                const _MascotImage(),
                const Spacer(flex: 1),
                OnboardingFooter(
                  title: 'Meet Bizzie!',
                  subtitle:
                      'Your friend to take with you on your Stock Market journey',
                  primaryButton: BizziePrimaryButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(
                        const OnboardingEvent.guestSessionRequested(),
                      );
                      context.push(AppRoutes.onboardingSectors);
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
  const _BackgroundChart();

  static final List<PriceChartPoint> _points = dummyData
      .map(
        (data) => PriceChartPoint(
          date: DateTime.parse(data['date'] as String),
          price: (data['price'] as num).toDouble(),
        ),
      )
      .toList()
      .reversed
      .toList();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppConstants.onboardLandingChartTopOffset,
      left: 0,
      right: 0,
      height: AppConstants.onboardLandingChartHeight,
      child: IgnorePointer(
        child: _BottomFadeMask(child: _PriceAreaChart(points: _points)),
      ),
    );
  }
}

class _BottomFadeMask extends StatelessWidget {
  final Widget child;

  const _BottomFadeMask({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.scaffoldBackgroundColor,
            theme.scaffoldBackgroundColor,
            theme.colorScheme.scrim,
          ],
          stops: AppConstants.onboardLandingChartFadeStops,
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}

class _PriceAreaChart extends StatelessWidget {
  final List<PriceChartPoint> points;

  const _PriceAreaChart({required this.points});

  static final LinearGradient _areaGradient = LinearGradient(
    colors: [
      AppColors.emerald500.withValues(
        alpha: AppConstants.onboardLandingChartGradientStartAlpha,
      ),
      AppColors.emerald500.withValues(
        alpha: AppConstants.onboardLandingChartGradientEndAlpha,
      ),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      margin: EdgeInsets.zero,
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <CartesianSeries<PriceChartPoint, DateTime>>[
        SplineAreaSeries<PriceChartPoint, DateTime>(
          dataSource: points,
          xValueMapper: (PriceChartPoint point, _) => point.date,
          yValueMapper: (PriceChartPoint point, _) => point.price,
          color: AppColors.emerald500.withValues(
            alpha: AppConstants.onboardLandingChartFillAlpha,
          ),
          borderColor: AppColors.emerald500,
          borderWidth: AppConstants.chartLineWidth,
          gradient: _areaGradient,
        ),
      ],
    );
  }
}

class _MascotImage extends StatelessWidget {
  const _MascotImage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.onboardLandingMascotPadding,
      child: Image.asset(
        AppAssets.onboardingBizzieMascot,
        height: AppConstants.onboardLandingMascotHeight,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _LoginRow extends StatelessWidget {
  const _LoginRow();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: AppTextStyles.bodyMediumSecondary,
        ),
        TextButton(
          onPressed: () {
            context.read<OnboardingBloc>().add(
              const OnboardingEvent.loginRequested(),
            );
            context.push(AppRoutes.login);
          },
          child: Text(
            'Login',
            style: AppTextStyles.bodyMediumBold.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
