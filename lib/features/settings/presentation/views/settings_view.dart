import 'dart:async';

import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/core/constants/paywall_query_params.dart';
import 'package:bizzie/core/enums/guest_gate_trigger.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/auth/presentation/utils/guest_gate_helper.dart';
import 'package:bizzie/features/feedback/presentation/widgets/feedback_modal.dart';
import 'package:bizzie/features/settings/domain/enums/guest_logout_choice.dart';
import 'package:bizzie/features/settings/domain/enums/settings_link_type.dart';
import 'package:bizzie/features/settings/domain/models/settings_display_data.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_state.dart';
import 'package:bizzie/features/settings/presentation/extensions/settings_display_data_extensions.dart';
import 'package:bizzie/features/settings/presentation/widgets/change_sector_modal.dart';
import 'package:bizzie/features/settings/presentation/widgets/guest_logout_confirmation_sheet.dart';
import 'package:bizzie/features/settings/presentation/widgets/settings_section.dart';
import 'package:bizzie/features/settings/presentation/widgets/settings_tile.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/extensions/subscription_state_extensions.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/app_bar/bizzie_app_bar.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_secondary_button.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SettingsBloc>()..add(const SettingsEvent.started()),
      child: const _SettingsViewContent(),
    );
  }
}

class _SettingsViewContent extends StatefulWidget {
  const _SettingsViewContent();

  @override
  State<_SettingsViewContent> createState() => _SettingsViewContentState();
}

class _SettingsViewContentState extends State<_SettingsViewContent>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<SettingsBloc>().add(const SettingsEvent.started());
    }
  }

  Future<void> _onCreateAccountTapped() async {
    final bloc = context.read<SettingsBloc>();
    await GuestGateHelper.linkAccount(
      context,
      trigger: GuestGateTrigger.settings,
    );
    if (!mounted) return;
    bloc.add(const SettingsEvent.started());
  }

  Future<void> _onLogInTapped() async {
    final isSignedIn = await context.push<bool>(AppRoutes.guestLogin) ?? false;
    if (!isSignedIn || !mounted) return;
    context.go(AppRoutes.home);
  }

  Future<void> _onFavoriteSectorTapped(SettingsDisplayData data) async {
    final currentSector = data.favoriteSectorOrNull;
    if (currentSector == null) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.scrim,
      builder: (_) => ChangeSectorModal(currentSector: currentSector),
    );
    if (!mounted) return;
    context.read<SettingsBloc>().add(const SettingsEvent.started());
  }

  void _onSignOutTapped() {
    context.read<SettingsBloc>().add(const SettingsEvent.signedOut());
  }

  Future<void> _onGuestLogOutTapped() async {
    final bloc = context.read<SettingsBloc>();
    final choice = await GuestLogoutConfirmationSheet.show(context);
    if (!mounted) return;
    bloc.add(SettingsEvent.guestLogoutPromptResolved(choice));
    switch (choice) {
      case GuestLogoutChoice.createAccount:
        await _onCreateAccountTapped();
      case GuestLogoutChoice.logOut:
        bloc.add(const SettingsEvent.signedOut());
      case GuestLogoutChoice.dismissed:
        return;
    }
  }

  void _onStateChanged(BuildContext context, SettingsState state) {
    state.mapOrNull(
      loaded: (loadedState) {
        if (!loadedState.shouldShowPermissionPrompt) return;
        final bloc = context.read<SettingsBloc>();
        bloc.add(const SettingsEvent.permissionPromptProcessed());
        unawaited(
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (_) => BlocProvider.value(
              value: bloc,
              child: const _NotificationPermissionSheet(),
            ),
          ),
        );
      },
      failure: (failureState) {
        BizzieSnackBar.show(
          context,
          message: failureState.failure.errorMessage,
          type: BizzieSnackBarType.error,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BizzieAppBar(title: 'Settings'),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: _onStateChanged,
        builder: (context, state) {
          return state.maybeMap(
            loading: (_) => const Center(child: CircularProgressIndicator()),
            loaded: (loadedState) {
              final data = loadedState.data;
              return ListView(
                padding: AppConstants.settingsListPadding,
                children: [
                  _AccountSection(
                    isGuest: data.isGuest,
                    onCreateAccountTapped: () =>
                        unawaited(_onCreateAccountTapped()),
                    onLogInTapped: () => unawaited(_onLogInTapped()),
                    onFavoriteSectorTapped: () =>
                        unawaited(_onFavoriteSectorTapped(data)),
                  ),
                  _PreferencesSection(data: data),
                  _SupportSection(data: data),
                  _SettingsFooter(
                    appVersion: data.appVersion,
                    onLogOutTapped: data.isGuest
                        ? () => unawaited(_onGuestLogOutTapped())
                        : _onSignOutTapped,
                  ),
                ],
              );
            },
            failure: (failureState) => BizzieError(
              message: failureState.failure.errorMessage,
              onRetry: () => context.read<SettingsBloc>().add(
                const SettingsEvent.started(),
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _NotificationPermissionSheet extends StatelessWidget {
  const _NotificationPermissionSheet();

  @override
  Widget build(BuildContext context) {
    return AppBottomModal(
      title: 'Enable Notifications',
      subtitle: const Text(
        'Please enable notifications in your system settings to receive important market alerts and filing updates.',
      ),
      useDraggable: false,
      contentPadding: AppConstants.settingsPermissionSheetPadding,
      builder: (modalContext, _) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppConstants.subSectionSpacing,
          BizziePrimaryButton(
            title: 'Open Settings',
            onPressed: () {
              modalContext.read<SettingsBloc>().add(
                const SettingsEvent.openedSettings(),
              );
              Navigator.pop(context);
            },
          ),
          AppConstants.secondarySectionSpacing,
          BizzieSecondaryButton(
            title: 'Cancel',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _AccountSection extends StatelessWidget {
  const _AccountSection({
    required this.isGuest,
    required this.onCreateAccountTapped,
    required this.onLogInTapped,
    required this.onFavoriteSectorTapped,
  });

  final bool isGuest;
  final VoidCallback onCreateAccountTapped;
  final VoidCallback onLogInTapped;
  final VoidCallback onFavoriteSectorTapped;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Account',
      children: [
        if (isGuest) ...[
          SettingsTile(title: 'Create Account', onTap: onCreateAccountTapped),
          const _TileDivider(),
          SettingsTile(title: 'Log In', onTap: onLogInTapped),
        ] else
          SettingsTile(
            title: 'Edit Profile',
            onTap: () {
              context.read<SettingsBloc>().add(
                const SettingsEvent.editProfileClicked(),
              );
              unawaited(context.pushNamed(AppRoutes.editProfile));
            },
          ),
        const _TileDivider(),
        SettingsTile(title: 'Favorite Sector', onTap: onFavoriteSectorTapped),
        const _TileDivider(),
        const _MembershipTile(),
      ],
    );
  }
}

class _MembershipTile extends StatelessWidget {
  const _MembershipTile();

  @override
  Widget build(BuildContext context) {
    final isSubscribed = context.select<UserBloc, bool?>(
      (bloc) =>
          bloc.state.mapOrNull(loaded: (loaded) => loaded.user.isSubscribed),
    );
    final discountPercentage = context.select<SubscriptionBloc, int?>(
      (bloc) => bloc.state.discountSavingsPercentageOrNull,
    );

    return SettingsTile(
      title: 'Membership',
      trailing: isSubscribed == false && discountPercentage != null
          ? _DiscountBadge(percentage: discountPercentage)
          : null,
      onTap: () {
        final hasSubscription = isSubscribed ?? false;
        context.read<SettingsBloc>().add(
          SettingsEvent.membershipClicked(isSubscribed: hasSubscription),
        );
        if (hasSubscription) {
          unawaited(context.pushNamed(AppRoutes.subscriptionDetails));
        } else {
          unawaited(
            context.pushNamed(
              AppRoutes.discountedPaywall,
              queryParameters: {
                PaywallQueryParams.source: PaywallSource.settings.name,
              },
            ),
          );
        }
      },
    );
  }
}

class _PreferencesSection extends StatelessWidget {
  const _PreferencesSection({required this.data});

  final SettingsDisplayData data;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Preferences',
      children: [
        SettingsTile(
          title: 'Notifications',
          trailing: Switch.adaptive(
            value: data.isNotificationsToggleOn,
            onChanged: (value) {
              context.read<SettingsBloc>().add(
                SettingsEvent.toggledNotifications(enable: value),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SupportSection extends StatelessWidget {
  const _SupportSection({required this.data});

  final SettingsDisplayData data;

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: 'Support',
      children: [
        SettingsTile(
          title: 'Send Feedback',
          onTap: () {
            context.read<SettingsBloc>().add(
              const SettingsEvent.feedbackClicked(),
            );
            FeedbackModal.show(context);
          },
        ),
        const _TileDivider(),
        SettingsTile(
          title: 'Privacy Policy',
          onTap: () {
            context.read<SettingsBloc>().add(
              SettingsEvent.openUrl(
                data.privacyPolicyUrl,
                SettingsLinkType.privacyPolicy,
              ),
            );
          },
        ),
        const _TileDivider(),
        SettingsTile(
          title: 'Terms of Service',
          onTap: () {
            context.read<SettingsBloc>().add(
              SettingsEvent.openUrl(
                data.termsOfServiceUrl,
                SettingsLinkType.termsOfService,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SettingsFooter extends StatelessWidget {
  const _SettingsFooter({
    required this.appVersion,
    required this.onLogOutTapped,
  });

  final String appVersion;
  final VoidCallback onLogOutTapped;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: AppConstants.settingsFooterPadding,
      child: Column(
        children: [
          Text(
            'Version $appVersion',
            style: AppTextStyles.caption.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AppConstants.secondarySectionSpacing,
          TextButton(
            onPressed: onLogOutTapped,
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.error,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}

class _TileDivider extends StatelessWidget {
  const _TileDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: AppConstants.settingsTileDividerHeight,
      indent: AppConstants.settingsTileDividerIndent,
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.percentage});

  final int percentage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(
          AppConstants.settingsDiscountBadgeBorderRadius,
        ),
      ),
      child: Padding(
        padding: AppConstants.settingsDiscountBadgePadding,
        child: Text(
          '$percentage% OFF',
          style: AppTextStyles.discountBadgeLabel.copyWith(
            color: theme.colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
