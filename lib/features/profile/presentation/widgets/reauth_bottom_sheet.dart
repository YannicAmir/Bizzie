import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/features/profile/domain/enums/reauth_action.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/buttons/social_login_button.dart';
import 'package:bizzie/shared/widgets/inputs/auth_text_field.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReAuthBottomSheet extends StatefulWidget {
  const ReAuthBottomSheet({super.key});

  @override
  State<ReAuthBottomSheet> createState() => _ReAuthBottomSheetState();
}

class _ReAuthBottomSheetState extends State<ReAuthBottomSheet> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) {
        final wasShowing = previous.maybeMap(
          form: (f) => f.isShowReauthModal,
          orElse: () => false,
        );
        final isShowing = current.maybeMap(
          form: (f) => f.isShowReauthModal,
          orElse: () => false,
        );
        return wasShowing && !isShowing;
      },
      listener: (context, state) {
        Navigator.pop(context);
      },
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          return state.maybeMap(
            form: (formState) {
              return AppBottomModal(
                useDraggable: false,
                title:
                    formState.pendingReauthAction == ReauthAction.deleteAccount
                    ? 'Confirm Account Deletion'
                    : 'Verify Identity',
                subtitle: const Text(
                  'For your security, please verify your identity to continue.',
                ),
                builder: (context, scrollController) {
                  return ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    padding: AppConstants.pagePadding,
                    children: [
                      if (formState.showPasswordAuth)
                        _PasswordAuthSection(
                          controller: _passwordController,
                          isPasswordVisible: formState.isReauthPasswordVisible,
                          isLoading: formState.isReauthSubmitting,
                          errorMessage: formState.reauthFailure?.message,
                        ),
                      if (formState.hasGoogle) ...[
                        _GoogleAuthButton(
                          isLoading: formState.isReauthSubmitting,
                        ),
                        if (formState.hasApple) const SizedBox(height: 16),
                      ],
                      if (formState.hasApple)
                        _AppleAuthButton(
                          isLoading: formState.isReauthSubmitting,
                        ),
                      if (formState.reauthFailure != null &&
                          !formState.showPasswordAuth)
                        _ReauthErrorMessage(
                          message: formState.reauthFailure!.message,
                        ),
                      const SizedBox(height: 48),
                    ],
                  );
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _PasswordAuthSection extends StatelessWidget {
  const _PasswordAuthSection({
    required this.controller,
    required this.isPasswordVisible,
    required this.isLoading,
    this.errorMessage,
  });

  final TextEditingController controller;
  final bool isPasswordVisible;
  final bool isLoading;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTextField(
          controller: controller,
          hintText: 'Password',
          isPassword: true,
          isPasswordVisible: isPasswordVisible,
          onVisibilityChanged: () {
            context.read<EditProfileBloc>().add(
              const EditProfileEvent.toggleReauthPasswordVisibility(),
            );
          },
          errorText: errorMessage,
          enabled: !isLoading,
        ),
        const SizedBox(height: 16),
        BizziePrimaryButton(
          title: 'Verify Password',
          isLoading: isLoading,
          onPressed: () {
            context.read<EditProfileBloc>().add(
              EditProfileEvent.reauthenticateWithPassword(controller.text),
            );
          },
        ),
      ],
    );
  }
}

class _GoogleAuthButton extends StatelessWidget {
  const _GoogleAuthButton({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final socialTheme = theme.extension<SocialLoginThemeExtension>()!;

    return SocialLoginButton(
      text: 'Verify with Google',
      iconAsset: AppAssets.authGoogleIcon,
      backgroundColor: socialTheme.googleBackgroundColor,
      foregroundColor: socialTheme.googleForegroundColor,
      textColor: socialTheme.googleTextColor,
      isLoading: isLoading,
      onPressed: () {
        context.read<EditProfileBloc>().add(
          const EditProfileEvent.reauthenticateWithGoogle(),
        );
      },
    );
  }
}

class _AppleAuthButton extends StatelessWidget {
  const _AppleAuthButton({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final socialTheme = theme.extension<SocialLoginThemeExtension>()!;

    return SocialLoginButton(
      text: 'Verify with Apple',
      iconAsset: AppAssets.authAppleIcon,
      backgroundColor: socialTheme.appleBackgroundColor,
      foregroundColor: socialTheme.appleForegroundColor,
      isLoading: isLoading,
      onPressed: () {
        context.read<EditProfileBloc>().add(
          const EditProfileEvent.reauthenticateWithApple(),
        );
      },
    );
  }
}

class _ReauthErrorMessage extends StatelessWidget {
  const _ReauthErrorMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        message,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.error,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
