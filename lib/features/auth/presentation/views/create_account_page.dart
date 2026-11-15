import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import 'package:bizzie/features/auth/presentation/widgets/auth_divider.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/user_model.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../utils/auth_failure_snackbar.dart';
import '../widgets/auth_close_button.dart';
import '../widgets/auth_footer.dart';
import '../widgets/auth_sign_in_prompt.dart';
import '../widgets/create_account_form.dart';
import '../widgets/mascot_info_card.dart';
import '../widgets/social_login_buttons.dart';

class CreateAccountPage extends StatefulWidget {
  final AuthSource source;

  const CreateAccountPage({super.key, this.source = AuthSource.onboarding});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  late final String? _guestUid;

  bool get _isGuestGate => widget.source == AuthSource.guestGate;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    _guestUid = authState.isGuest ? authState.userId : null;
    if (_isGuestGate) return;
    context.read<OnboardingBloc>().add(
      const OnboardingEvent.stepViewed(OnboardingStep.createAccount),
    );
  }

  void _onAuthenticated(UserModel user) {
    if (user.isAnonymous) return;
    FocusScope.of(context).unfocus();
    if (_isGuestGate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.pop(true);
      });
      return;
    }
    final guestUid = _guestUid;
    if (guestUid != null && guestUid != user.id) {
      context.go(AppRoutes.home);
      return;
    }
    context.go(AppRoutes.onboardingBuildingProfile);
  }

  bool _isRouteCurrent() {
    var route = ModalRoute.of(context);
    while (route != null) {
      if (!route.isCurrent) return false;
      final navigatorContext = route.navigator?.context;
      route = navigatorContext == null ? null : ModalRoute.of(navigatorContext);
    }
    return true;
  }

  Future<void> _onSignInPressed() async {
    if (!_isGuestGate && _guestUid == null) {
      await context.push<void>(AppRoutes.login);
      return;
    }
    final isSignedIn = await context.push<bool>(AppRoutes.guestLogin) ?? false;
    if (!isSignedIn || !mounted) return;
    if (_isGuestGate) {
      context.pop(true);
      return;
    }
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (_, _) => _isRouteCurrent(),
      listener: (context, state) {
        state.maybeWhen(
          authenticated: _onAuthenticated,
          failure: (failure) => AuthFailureSnackBar.show(context, failure),
          orElse: () {},
        );
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: _CreateAccountBody(
                source: widget.source,
                onSignInPressed: _onSignInPressed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateAccountBody extends StatelessWidget {
  final AuthSource source;
  final VoidCallback onSignInPressed;

  const _CreateAccountBody({
    required this.source,
    required this.onSignInPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OnboardingHeader(),
        if (source == AuthSource.onboarding)
          AppConstants.onboardHeaderSpacing
        else ...[
          const AuthCloseButton(),
          AppConstants.subSectionSpacing,
        ],
        Padding(
          padding: AppConstants.onboardHorizontalPadding,
          child: source == AuthSource.guestGate
              ? const _GuestMascotInfoCard()
              : const _OnboardingMascotInfoCard(),
        ),
        AppConstants.onboardSectionSpacing,
        Padding(
          padding: AppConstants.onboardHorizontalPadding,
          child: _CreateAccountFormSection(
            source: source,
            onSignInPressed: onSignInPressed,
          ),
        ),
      ],
    );
  }
}

class _CreateAccountFormSection extends StatelessWidget {
  final AuthSource source;
  final VoidCallback onSignInPressed;

  const _CreateAccountFormSection({
    required this.source,
    required this.onSignInPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CreateAccountHeader(),
        AppConstants.onboardSectionSpacing,
        CreateAccountForm(source: source),
        AppConstants.mainSectionSpacing,
        const AuthDivider(),
        AppConstants.mainSectionSpacing,
        SocialLoginButtons(source: source),
        AppConstants.onboardSectionSpacing,
        const AuthFooter(),
        AppConstants.secondarySectionSpacing,
        AuthSignInPrompt(onSignInPressed: onSignInPressed),
        AppConstants.mainSectionSpacing,
      ],
    );
  }
}

class _CreateAccountHeader extends StatelessWidget {
  const _CreateAccountHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Create your account', style: AppTextStyles.h1),
        AppConstants.subSectionSpacing,
        Text('Save your progress', style: AppTextStyles.subtitleSmall),
      ],
    );
  }
}

class _OnboardingMascotInfoCard extends StatelessWidget {
  const _OnboardingMascotInfoCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, onboardingState) {
        return MascotInfoCard(
          name: onboardingState.greetingName,
          sectorName: onboardingState.displaySectorName,
          mascotAsset: onboardingState.mascotAsset,
        );
      },
    );
  }
}

class _GuestMascotInfoCard extends StatelessWidget {
  const _GuestMascotInfoCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return MascotInfoCard(
          name: userState.displayName,
          sectorName: userState.favoriteSectorDisplayName,
          mascotAsset: userState.mascotAsset,
        );
      },
    );
  }
}
