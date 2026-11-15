import 'dart:async';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/extensions/onboarding_state_x.dart';
import 'package:bizzie/features/onboarding/presentation/models/profile_summary_item.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/onboarding_header.dart';

const _progressDuration = Duration(seconds: 2);
const _carouselInterval = Duration(milliseconds: 1600);
const _carouselTransitionDuration = Duration(milliseconds: 500);

enum _BuildingProfilePhase { progressing, finishing, saveFailed }

class BuildingProfilePage extends StatefulWidget {
  const BuildingProfilePage({super.key});

  @override
  State<BuildingProfilePage> createState() => _BuildingProfilePageState();
}

class _BuildingProfilePageState extends State<BuildingProfilePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;
  late final PageController _pageController;
  late final _CarouselAutoScroller _autoScroller;

  bool _isAnimationComplete = false;
  bool _isProfileSaved = false;

  @override
  void initState() {
    super.initState();
    final onboardingBloc = context.read<OnboardingBloc>();
    onboardingBloc.add(
      const OnboardingEvent.stepViewed(OnboardingStep.buildingProfile),
    );

    _progressController =
        AnimationController(vsync: this, duration: _progressDuration)
          ..addStatusListener(_onProgressStatusChanged)
          ..forward();

    _pageController = PageController();
    _autoScroller = _CarouselAutoScroller(
      _pageController,
      itemCount: onboardingBloc.state.profileSummaryItems.length,
    )..start();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onboardingBloc.add(const OnboardingEvent.buildingProfileStarted());
    });
  }

  void _onProgressStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _onAnimationComplete();
    }
  }

  void _requestCompletion() {
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.completionRequested(),
    );
  }

  void _onOnboardingStatusChanged(OnboardingStatus status) {
    switch (status) {
      case OnboardingStatus.success:
        _onProfileSaveSuccess();
      case OnboardingStatus.existingProfile:
        _onExistingProfileFound();
      case OnboardingStatus.initial ||
          OnboardingStatus.loading ||
          OnboardingStatus.failure:
        break;
    }
  }

  void _onAnimationComplete() {
    setState(() {
      _isAnimationComplete = true;
    });
    _tryNavigate();
  }

  void _onProfileSaveSuccess() {
    setState(() {
      _isProfileSaved = true;
    });
    _tryNavigate();
  }

  void _onExistingProfileFound() {
    _autoScroller.stop();
    context.go(AppRoutes.home);
  }

  void _tryNavigate() {
    if (_isAnimationComplete && _isProfileSaved) {
      _autoScroller.stop();
      context.go(AppRoutes.onboardingProfileReady);
    }
  }

  _BuildingProfilePhase _phaseFor(OnboardingState state) {
    if (!_isAnimationComplete || _isProfileSaved) {
      return _BuildingProfilePhase.progressing;
    }
    if (state.status == OnboardingStatus.failure && !state.isSubmitting) {
      return _BuildingProfilePhase.saveFailed;
    }
    return _BuildingProfilePhase.finishing;
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pageController.dispose();
    _autoScroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) => _onOnboardingStatusChanged(state.status),
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) => _BuildingProfileView(
          pageController: _pageController,
          progressAnimation: _progressController,
          summaryItems: state.profileSummaryItems,
          phase: _phaseFor(state),
          onRetry: _requestCompletion,
        ),
      ),
    );
  }
}

class _CarouselAutoScroller {
  final PageController pageController;
  final int itemCount;
  Timer? _timer;
  int _currentPage = 0;

  _CarouselAutoScroller(this.pageController, {required this.itemCount});

  void start() {
    _timer = Timer.periodic(_carouselInterval, (_) {
      _currentPage = (_currentPage + 1) % itemCount;

      if (pageController.hasClients) {
        pageController.animateToPage(
          _currentPage,
          duration: _carouselTransitionDuration,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void dispose() {
    stop();
  }
}

class _BuildingProfileView extends StatelessWidget {
  final PageController pageController;
  final Animation<double> progressAnimation;
  final List<ProfileSummaryItem> summaryItems;
  final _BuildingProfilePhase phase;
  final VoidCallback onRetry;

  const _BuildingProfileView({
    required this.pageController,
    required this.progressAnimation,
    required this.summaryItems,
    required this.phase,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingHeader(),
            Expanded(
              child: _CenteredScrollView(
                children: [
                  _ProfileCarousel(
                    pageController: pageController,
                    carouselItems: summaryItems,
                  ),
                  AppConstants.onboardBuildingProfileCarouselSpacing,
                  _ProfileCreationProgress(
                    progressAnimation: progressAnimation,
                  ),
                  AppConstants.onboardSectionSpacing,
                  _ProgressStatus(
                    phase: phase,
                    progressAnimation: progressAnimation,
                    onRetry: onRetry,
                  ),
                  AppConstants.onboardBuildingProfileBottomSpacing,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenteredScrollView extends StatelessWidget {
  final List<Widget> children;

  const _CenteredScrollView({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileCarousel extends StatelessWidget {
  final PageController pageController;
  final List<ProfileSummaryItem> carouselItems;

  const _ProfileCarousel({
    required this.pageController,
    required this.carouselItems,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.onboardBuildingProfileCarouselHeight,
      child: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: carouselItems.length,
        itemBuilder: (context, index) {
          final item = carouselItems[index];
          return Padding(
            padding: AppConstants.onboardHorizontalPadding,
            child: _ProfileCarouselItem(item: item),
          );
        },
      ),
    );
  }
}

class _ProfileCarouselItem extends StatelessWidget {
  final ProfileSummaryItem item;

  const _ProfileCarouselItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.onboardProfileSummaryCardPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(color: AppColors.inputBackground),
      ),
      child: Row(
        children: [
          _ProfileSummaryIcon(iconAsset: item.iconAsset),
          AppConstants.onboardProfileSummaryIconSpacing,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.subtitle,
                  style: AppTextStyles.onboardingSummaryLabel,
                ),
                Text(item.title, style: AppTextStyles.onboardingSummaryValue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileSummaryIcon extends StatelessWidget {
  static const _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.blueGradientStart, AppColors.primary],
  );

  final String iconAsset;

  const _ProfileSummaryIcon({required this.iconAsset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.onboardProfileSummaryIconContainerSize,
      height: AppConstants.onboardProfileSummaryIconContainerSize,
      decoration: BoxDecoration(
        gradient: _gradient,
        borderRadius: BorderRadius.circular(
          AppConstants.onboardProfileSummaryIconContainerRadius,
        ),
      ),
      child: Center(
        child: Image.asset(
          iconAsset,
          width: AppConstants.onboardProfileSummaryIconSize,
          height: AppConstants.onboardProfileSummaryIconSize,
          errorBuilder: (_, _, _) => const Icon(
            Icons.check_circle,
            size: AppConstants.onboardProfileSummaryIconSize,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class _ProfileCreationProgress extends StatelessWidget {
  final Animation<double> progressAnimation;

  const _ProfileCreationProgress({required this.progressAnimation});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox.square(
        dimension: AppConstants.onboardBuildingProfileProgressSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            RepaintBoundary(
              child: _ProgressRing(progressAnimation: progressAnimation),
            ),
            Padding(
              padding: AppConstants.onboardBuildingProfileProgressTextPadding,
              child: Text(
                'Building your profile',
                style: AppTextStyles.onboardingDisplay,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  final Animation<double> progressAnimation;

  const _ProgressRing({required this.progressAnimation});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppConstants.onboardBuildingProfileProgressSize,
      child: AnimatedBuilder(
        animation: progressAnimation,
        builder: (context, _) => CircularProgressIndicator(
          value: progressAnimation.value,
          strokeWidth: AppConstants.onboardBuildingProfileProgressStrokeWidth,
          backgroundColor: AppColors.slate100,
          color: AppColors.primary,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}

class _ProgressStatus extends StatelessWidget {
  final _BuildingProfilePhase phase;
  final Animation<double> progressAnimation;
  final VoidCallback onRetry;

  const _ProgressStatus({
    required this.phase,
    required this.progressAnimation,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return switch (phase) {
      _BuildingProfilePhase.progressing => _ProgressPercentText(
        progressAnimation: progressAnimation,
      ),
      _BuildingProfilePhase.finishing => Padding(
        padding: AppConstants.onboardBuildingProfileStatusTopPadding,
        child: Text('Finishing up...', style: AppTextStyles.onboardingDisplay),
      ),
      _BuildingProfilePhase.saveFailed => _SaveFailedMessage(onRetry: onRetry),
    };
  }
}

class _ProgressPercentText extends StatelessWidget {
  final Animation<double> progressAnimation;

  const _ProgressPercentText({required this.progressAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progressAnimation,
      builder: (context, _) => Text(
        '${(progressAnimation.value * 100).toInt()}%',
        style: AppTextStyles.onboardingProgressPercent,
      ),
    );
  }
}

class _SaveFailedMessage extends StatelessWidget {
  final VoidCallback onRetry;

  const _SaveFailedMessage({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.onboardBuildingProfileStatusTopPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "We couldn't save your profile.",
            style: AppTextStyles.bodyMediumSecondary,
            textAlign: TextAlign.center,
          ),
          TextButton(onPressed: onRetry, child: const Text('Try Again')),
        ],
      ),
    );
  }
}
