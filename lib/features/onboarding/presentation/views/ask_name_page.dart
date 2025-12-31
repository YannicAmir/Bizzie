import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/themes/app_assets.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_text_styles.dart';
import '../bloc/onboarding_bloc.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_header.dart';

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

  void _submitName() {
    if (_isButtonEnabled) {
      final name = _nameController.text.trim();
      context.read<OnboardingBloc>().add(OnboardingEvent.nameSubmitted(name));
      // Navigate to Welcome Page
      context.push(AppRoutes.onboardingWelcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            OnboardingHeader(
              progressIndicator: LinearProgressIndicator(
                value: 0.15,
                backgroundColor: AppColors.background,
                color: AppColors.primary,
                minHeight: 4,
              ),
              title: "Hi, I'm Bizzie! What's your name?",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    // Input Field
                    TextField(
                      controller: _nameController,
                      style: AppTextStyles.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Enter your first name',
                        hintStyle: AppTextStyles.inputHint,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: AppColors.inputBorder,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                      ),
                      onSubmitted: (_) => _submitName(),
                    ),
                    const SizedBox(height: 24),
                    // Mascot centered
                    Center(
                      child: Image.asset(
                        AppAssets.onboardingBizzieMascotAskName,
                        height: 225, // Reduced by 10% (250 * 0.9)
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Footer
            OnboardingFooter(
              primaryButton: FilledButton(
                onPressed: _isButtonEnabled ? _submitName : null,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.primary.withValues(
                    alpha: 0.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: AppTextStyles.button.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
