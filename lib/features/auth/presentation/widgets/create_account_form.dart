import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/auth/presentation/widgets/auth_button.dart';
import 'package:bizzie/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'package:bizzie/shared/utils/validators.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
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

  void _onCreateAccountPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthEvent.emailSignUpRequested(
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
            onSubmitted: _onCreateAccountPressed,
            textInputAction: TextInputAction.done,
            validator: (value) =>
                Validators.validatePassword(value, minLength: 8),
          ),
          const SizedBox(height: 24),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: (method) => method == 'email_signup',
                orElse: () => false,
              );
              return AuthButton(
                text: 'Create Account',
                onPressed: _onCreateAccountPressed,
                isLoading: isLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}
