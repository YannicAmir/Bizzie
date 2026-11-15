import 'dart:async';

import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_skip_overlay.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/validators.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/app_routes.dart';
import '../bloc/onboarding_bloc.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';

const _keyboardDismissDelay = Duration(milliseconds: 300);
const _mascotScreenHeightFactor = 0.15;

class AskNamePage extends StatefulWidget {
  const AskNamePage({super.key});

  @override
  State<AskNamePage> createState() => _AskNamePageState();
}

class _AskNamePageState extends State<AskNamePage> {
  final TextEditingController _nameController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onNameChanged);
    final bloc = context.read<OnboardingBloc>();
    bloc.add(const OnboardingEvent.stepViewed(OnboardingStep.askName));
  }

  void _onNameChanged() {
    setState(() {
      _isButtonEnabled = Validators.validateName(_nameController.text) == null;
    });
  }

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submitName() async {
    if (_isButtonEnabled) {
      final name = _nameController.text.trim();

      FocusManager.instance.primaryFocus?.unfocus();

      await Future.delayed(_keyboardDismissDelay);

      if (!mounted) return;

      context.read<OnboardingBloc>().add(OnboardingEvent.nameSubmitted(name));
      unawaited(context.push(AppRoutes.onboardingFeatureHighlights));
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingSkipOverlay(
      step: OnboardingStep.askName,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const OnboardingHeader(title: "What's your name?"),
          Expanded(
            child: _AskNameContent(
              controller: _nameController,
              onSubmitted: _submitName,
            ),
          ),
          _AskNameFooter(
            onContinuePressed: _isButtonEnabled ? _submitName : null,
          ),
        ],
      ),
    );
  }
}

class _AskNameContent extends StatelessWidget {
  final TextEditingController controller;
  final Future<void> Function() onSubmitted;

  const _AskNameContent({required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: AppConstants.onboardHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppConstants.mainSectionSpacing,
          _NameInputField(controller: controller, onSubmitted: onSubmitted),
          AppConstants.mainSectionSpacing,
          const RepaintBoundary(child: _AskNameMascot()),
          AppConstants.onboardFooterClearanceSpacing,
        ],
      ),
    );
  }
}

class _AskNameFooter extends StatelessWidget {
  final Future<void> Function()? onContinuePressed;

  const _AskNameFooter({required this.onContinuePressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onPressed = onContinuePressed;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: theme.colorScheme.scrim)),
      ),
      child: SafeArea(
        top: false,
        child: OnboardingFooter(
          primaryButton: BizziePrimaryButton(
            onPressed: onPressed == null ? null : () => unawaited(onPressed()),
            title: 'Continue',
          ),
        ),
      ),
    );
  }
}

class _NameInputField extends StatelessWidget {
  final TextEditingController controller;
  final Future<void> Function() onSubmitted;

  const _NameInputField({required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      autofocus: false,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      style: theme.textTheme.bodyLarge,
      decoration: const InputDecoration(hintText: 'Enter your first name'),
      onSubmitted: (_) => unawaited(onSubmitted()),
    );
  }
}

class _AskNameMascot extends StatelessWidget {
  const _AskNameMascot();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final responsiveHeight = screenHeight * _mascotScreenHeightFactor;
    final mascotAsset = context.select<OnboardingBloc, String>(
      (bloc) => bloc.state.mascotAsset,
    );

    return Center(
      child: Image.asset(
        mascotAsset,
        width: double.infinity,
        height: responsiveHeight,
        fit: BoxFit.contain,
      ),
    );
  }
}
