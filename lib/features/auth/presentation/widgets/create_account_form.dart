import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/input_formatters.dart';
import 'package:bizzie/shared/utils/validators.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/inputs/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../enums/auth_loading_method.dart';

class CreateAccountForm extends StatefulWidget {
  final AuthSource source;

  const CreateAccountForm({super.key, required this.source});

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
    final authBloc = context.read<AuthBloc>();
    if (authBloc.state is AuthLoading) return;
    if (_formKey.currentState?.validate() ?? false) {
      authBloc.add(
        AuthEvent.emailSignUpRequested(
          _emailController.text,
          _passwordController.text,
          source: widget.source,
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
            maxLength: AppConstants.textfieldCharLimit,
            inputFormatters: [InputFormatters.denyWhitespace],
          ),
          AppConstants.secondarySectionSpacing,
          AuthTextField(
            controller: _passwordController,
            hintText: 'Password (8+ characters)',
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
            validator: Validators.validatePassword,
            maxLength: AppConstants.passwordFieldCharLimit,
            inputFormatters: [InputFormatters.denyWhitespace],
          ),
          AppConstants.mainSectionSpacing,
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: (method) => method == AuthLoadingMethod.emailSignUp,
                orElse: () => false,
              );
              return BizziePrimaryButton(
                title: 'Create Account',
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
