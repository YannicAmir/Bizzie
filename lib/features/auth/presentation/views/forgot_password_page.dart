import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/auth/presentation/widgets/auth_button.dart';
import 'package:bizzie/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'package:bizzie/shared/utils/validators.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSendResetLinkPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthEvent.resetPasswordRequested(_emailController.text),
      );
      context.push(AppRoutes.emailSent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          failure: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.textPrimary,
                size: 20,
              ),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // Title
                  Text(
                    'Reset Password',
                    style: AppTextStyles.h1.copyWith(
                      color: const Color(0xFF0F172B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Subtitle
                  Text(
                    'We\'ll email you a link to reset your password',
                    style: AppTextStyles.subtitle.copyWith(
                      fontSize: 16,
                      color: const Color(0xFF45556C),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Email Field
                  AuthTextField(
                    controller: _emailController,
                    hintText: 'Email address',
                    iconPath: AppAssets.authEmailIcon,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onSubmitted: _onSendResetLinkPressed,
                    validator: Validators.validateEmail,
                    borderRadius: 8,
                    fillColor: const Color(0xFFF8F9FA),
                    borderColor: const Color(0xFFDEE2E6),
                  ),
                  const SizedBox(height: 24),

                  // Button
                  AuthButton(
                    text: 'Send Reset Link',
                    onPressed: _onSendResetLinkPressed,
                    height: 56,
                    borderRadius: 12,
                    backgroundColor: const Color(0xFF1A5CE5),
                    textStyle: AppTextStyles.button.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 78),

                  // Mascot
                  Center(
                    child: Image.asset(
                      AppAssets.authForgotPasswordMascot,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
