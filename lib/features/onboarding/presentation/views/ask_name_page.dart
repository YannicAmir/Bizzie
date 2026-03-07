import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/themes/app_assets.dart';

import '../bloc/onboarding_bloc.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

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
      _isButtonEnabled = _nameController.text.trim().isNotEmpty;
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

      await Future.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      context.read<OnboardingBloc>().add(OnboardingEvent.nameSubmitted(name));
      context.push(AppRoutes.onboardingWelcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            OnboardingHeader(title: "Hi, I'm Bizzie! What's your name?"),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _NameInputField(
                      controller: _nameController,
                      onSubmitted: _submitName,
                    ),
                    const SizedBox(height: 24),
                    const RepaintBoundary(child: _AskNameMascot()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: theme.colorScheme.scrim)),
        ),
        child: SafeArea(
          child: OnboardingFooter(
            primaryButton: BizziePrimaryButton(
              onPressed: _isButtonEnabled ? _submitName : null,
              title: 'Continue',
            ),
          ),
        ),
      ),
    );
  }
}

class _NameInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmitted;

  const _NameInputField({required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextField(
      controller: controller,
      autofocus: false,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      style: theme.textTheme.bodyLarge,
      decoration: const InputDecoration(
        hintText: 'Enter your first name',
        contentPadding: EdgeInsets.all(16),
      ),
      onSubmitted: (_) => onSubmitted(),
    );
  }
}

class _AskNameMascot extends StatelessWidget {
  const _AskNameMascot();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final responsiveHeight = screenHeight * 0.15;

    return Center(
      child: Image.asset(
        AppAssets.onboardingBizzieMascotAskName,
        height: responsiveHeight,
        fit: BoxFit.contain,
      ),
    );
  }
}
