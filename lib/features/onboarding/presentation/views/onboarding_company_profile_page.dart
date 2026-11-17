import 'dart:async';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/company_profile_tour_request.dart';
import 'package:bizzie/features/company_profile/cp/presentation/views/company_profile_page.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_tour_scope.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_skip_reason.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_navigation_orchestrator.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_notification_prompter.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingCompanyProfilePage extends StatefulWidget {
  final String ticker;

  const OnboardingCompanyProfilePage({super.key, required this.ticker});

  @override
  State<OnboardingCompanyProfilePage> createState() =>
      _OnboardingCompanyProfilePageState();
}

class _OnboardingCompanyProfilePageState
    extends State<OnboardingCompanyProfilePage> {
  late final CompanyProfileTourRequest _tourRequest;
  bool _isTourComplete = false;
  bool _hasSubscribed = false;
  bool _isOnboardingAborted = false;

  @override
  void initState() {
    super.initState();
    _tourRequest = CompanyProfileTourRequest(
      shouldPromptNotifications: true,
      onPromptNotifications: _onTourCompleted,
      onTourSkipped: _onTourSkipped,
    );
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.companyProfile),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _abortOnboardingIfSubscribed();
  }

  void _onTourCompleted() {
    unawaited(
      OnboardingNotificationPrompter.promptOnboardingNotifications(context),
    );
    if (mounted) setState(() => _isTourComplete = true);
  }

  void _onTourSkipped() {
    if (mounted) context.go(AppRoutes.onboardingNotifications);
  }

  void _onSubscribed(BuildContext _, SubscriptionState _) {
    _hasSubscribed = true;
    _abortOnboardingIfSubscribed();
  }

  void _abortOnboardingIfSubscribed() {
    final isRouteCurrent = ModalRoute.isCurrentOf(context) ?? false;
    if (!_hasSubscribed || _isOnboardingAborted || !isRouteCurrent) return;

    _isOnboardingAborted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        OnboardingNavigationOrchestrator.startSkipFlow(
          context,
          OnboardingStep.companyProfile,
          reason: OnboardingSkipReason.purchased,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listenWhen: (previous, current) =>
          !previous.status.isSubscribed && current.status.isSubscribed,
      listener: _onSubscribed,
      child: CompanyProfileTourScope(
        child: Scaffold(
          body: CompanyProfilePage(
            ticker: widget.ticker,
            tourRequest: _tourRequest,
            showBackButton: false,
          ),
          bottomNavigationBar: _isTourComplete
              ? const _TourCompleteFooter()
              : null,
        ),
      ),
    );
  }
}

class _TourCompleteFooter extends StatelessWidget {
  const _TourCompleteFooter();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [AppConstants.subSectionSpacing, const _ContinueFooter()],
        ),
      ),
    );
  }
}

class _ContinueFooter extends StatelessWidget {
  const _ContinueFooter();

  @override
  Widget build(BuildContext context) {
    return OnboardingFooter(
      primaryButton: BizziePrimaryButton(
        onPressed: () => context.go(AppRoutes.onboardingExperience),
        title: 'Continue',
      ),
    );
  }
}
