import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
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

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState>? formKey;

  const LoginForm({super.key, this.formKey});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final GlobalKey<FormState> _formKey;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey ?? GlobalKey<FormState>();
  }

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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AuthTextField(
            controller: _emailController,
            hintText: 'Email address',
            iconPath: AppAssets.authEmailIcon,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 16),
          AuthTextField(
            controller: _passwordController,
            hintText: 'Password',
            iconPath: AppAssets.authLockIcon,
            isPassword: true,
            isPasswordVisible: _isPasswordVisible,
            onVisibilityChanged: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            onSubmitted: _onLoginPressed,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              context.push(AppRoutes.forgotPassword);
            },
            child: Text(
              'Forgot Password?',
              style: AppTextStyles.forgotPassword,
            ),
          ),
          const SizedBox(height: 24),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: (method) => method == 'email_signin',
                orElse: () => false,
              );
              return AuthButton(
                text: 'Log In',
                onPressed: _onLoginPressed,
                isLoading: isLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}
