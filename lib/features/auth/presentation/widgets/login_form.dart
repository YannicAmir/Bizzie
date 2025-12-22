import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthEvent.emailSignInRequested(
          _emailController.text,
          _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Styles from Figma
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), // Figma: 16px
      borderSide: const BorderSide(color: AppColors.inputBorder),
    );

    // Exact Hint Style (Matching 'Password' text node 35:16984: 17px, #44556C)
    // Exact Hint Style (Matching 'Password' text node 35:16984: 17px, #44556C)

    // Figma code snippet had "border-[#e2e8f0]" for the "or continue with" line, likely generic border color.
    // Screenshot shows inputs have a light background (maybe just white on white? No, they stand out).
    // Let's assume white field with a border, or light gray field. Common mobile pattern: Grey[100] filled.
    // "Email address" placeholder color: #94a3b8? (Slate-400).

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Email Field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: AppTextStyles.bodyLarge,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  AppAssets.authEmailIcon,
                  width: 24,
                  height: 24,
                ),
              ),
              hintText: 'Email address',
              hintStyle: AppTextStyles.inputHint,
              filled: true,
              fillColor: AppColors.inputBackground,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder.copyWith(
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Password Field
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _onLoginPressed(),
            style: AppTextStyles.bodyLarge,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  AppAssets.authLockIcon,
                  width: 24,
                  height: 24,
                ),
              ),
              suffixIcon: IconButton(
                icon: Image.asset(
                  !_isPasswordVisible
                      ? AppAssets.authHidePasswordIcon
                      : AppAssets.authShowPasswordIcon,
                  width: 24,
                  height: 24,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              hintText: 'Password',
              hintStyle: AppTextStyles.inputHint,
              filled: true,
              fillColor: AppColors.inputBackground,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder.copyWith(
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              errorMaxLines: 2,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                // Return null to avoid blocking login if logic permits, but standard is min length
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16), // Gap: 16px (Was 12)
          // Forgot Password
          GestureDetector(
            onTap: () {
              context.push('/forgot-password');
            },
            child: Text(
              'Forgot Password?',
              style: AppTextStyles.forgotPassword,
            ),
          ),
          const SizedBox(height: 24), // Gap: 24px (Calculated 20->24)
          // Login Button
          SizedBox(
            width: double.infinity,
            height:
                58, // Match Figma height guideline for touch targets (usually 48-56, Figma 57.5)
            child: ElevatedButton(
              onPressed: _onLoginPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Match input radius 16px
                ),
                elevation: 0,
              ),
              child: Text(
                'Log In',
                style: AppTextStyles.button.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
