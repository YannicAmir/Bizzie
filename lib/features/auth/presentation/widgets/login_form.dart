import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/input_formatters.dart';
import 'package:bizzie/shared/utils/validators.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/inputs/auth_text_field.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../enums/auth_loading_method.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final AuthSource source;

  const LoginForm({super.key, this.formKey, required this.source});

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
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthEvent.emailSignInRequested(
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
        crossAxisAlignment: CrossAxisAlignment.end,
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
            maxLength: AppConstants.passwordFieldCharLimit,
            inputFormatters: [InputFormatters.denyWhitespace],
          ),
          AppConstants.secondarySectionSpacing,
          GestureDetector(
            onTap: () {
              context.push(AppRoutes.forgotPassword);
            },
            child: Text(
              'Forgot Password?',
              style: AppTextStyles.bodySmallBold.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          AppConstants.mainSectionSpacing,
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: (method) => method == AuthLoadingMethod.emailSignIn,
                orElse: () => false,
              );
              return BizziePrimaryButton(
                title: 'Log In',
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
