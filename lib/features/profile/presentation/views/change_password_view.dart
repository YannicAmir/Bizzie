import 'package:bizzie/features/profile/presentation/widgets/profile_field_with_header.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/features/profile/presentation/bloc/change_password_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/change_password_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/change_password_state.dart';
import 'package:bizzie/shared/utils/validators.dart';
import 'package:bizzie/shared/widgets/auth/password_requirement_row.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/inputs/auth_text_field.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.I<ChangePasswordBloc>()
            ..add(const ChangePasswordEvent.started()),
      child: const _ChangePasswordViewContent(),
    );
  }
}

class _ChangePasswordViewContent extends StatefulWidget {
  const _ChangePasswordViewContent();

  @override
  State<_ChangePasswordViewContent> createState() =>
      _ChangePasswordViewContentState();
}

class _ChangePasswordViewContentState
    extends State<_ChangePasswordViewContent> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSavePressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ChangePasswordBloc>().add(
        const ChangePasswordEvent.saveRequested(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        state.mapOrNull(
          success: (_) => context.pop(),
          form: (s) {
            if (s.failure != null) {
              BizzieSnackBar.show(
                context,
                message: s.failure!.message,
                type: BizzieSnackBarType.error,
              );
            }
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          leading: BackButton(color: Theme.of(context).colorScheme.onSurface),
        ),
        body: SafeArea(
          child: Padding(
            padding: AppConstants.pagePadding,
            child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
              builder: (context, state) {
                return state.map(
                  initial: (_) => const SizedBox.shrink(),
                  loading: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  success: (_) => const SizedBox.shrink(),
                  form: (s) {
                    final isEnabled =
                        s.oldPassword.isNotEmpty &&
                        s.newPassword.isNotEmpty &&
                        s.confirmPassword.isNotEmpty &&
                        !s.isSubmitting;

                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ProfileFieldWithHeader(
                            header: 'Current Password',
                            child: AuthTextField(
                              controller: _oldPasswordController,
                              hintText: '',
                              isPassword: true,
                              isPasswordVisible: _isOldPasswordVisible,
                              onVisibilityChanged: () => setState(
                                () => _isOldPasswordVisible =
                                    !_isOldPasswordVisible,
                              ),
                              onChanged: (val) =>
                                  context.read<ChangePasswordBloc>().add(
                                    ChangePasswordEvent.oldPasswordChanged(val),
                                  ),
                              validator: Validators.validatePassword,
                            ),
                          ),
                          ProfileFieldWithHeader(
                            header: 'New Password',
                            child: AuthTextField(
                              controller: _newPasswordController,
                              hintText: '',
                              isPassword: true,
                              isPasswordVisible: _isNewPasswordVisible,
                              onVisibilityChanged: () => setState(
                                () => _isNewPasswordVisible =
                                    !_isNewPasswordVisible,
                              ),
                              onChanged: (val) =>
                                  context.read<ChangePasswordBloc>().add(
                                    ChangePasswordEvent.newPasswordChanged(val),
                                  ),
                              validator: Validators.validatePassword,
                            ),
                          ),
                          const SizedBox(height: 8),
                          PasswordRequirementRow(
                            text: '8+ Characters',
                            isMet: s.newPassword.length >= 8,
                          ),
                          const SizedBox(height: 16),
                          ProfileFieldWithHeader(
                            header: 'Confirm New Password',
                            child: AuthTextField(
                              controller: _confirmPasswordController,
                              hintText: '',
                              isPassword: true,
                              isPasswordVisible: _isConfirmPasswordVisible,
                              onVisibilityChanged: () => setState(
                                () => _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible,
                              ),
                              onChanged: (val) =>
                                  context.read<ChangePasswordBloc>().add(
                                    ChangePasswordEvent.confirmPasswordChanged(
                                      val,
                                    ),
                                  ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return null;
                                }
                                if (val.length >=
                                    _newPasswordController.text.length) {
                                  if (val != _newPasswordController.text) {
                                    return 'Passwords do not match';
                                  }
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onSubmitted: isEnabled
                                  ? () => _onSavePressed(context)
                                  : null,
                            ),
                          ),
                          const Spacer(),
                          BizziePrimaryButton(
                            title: 'Save Password',
                            onPressed: isEnabled
                                ? () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      _onSavePressed(context);
                                    } else {
                                      if (s.oldPassword.isEmpty) {}
                                    }
                                  }
                                : null,
                            isLoading: s.isSubmitting,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
