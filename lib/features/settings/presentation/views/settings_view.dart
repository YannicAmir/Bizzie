import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_event.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_state.dart';
import 'package:bizzie/features/settings/presentation/widgets/change_sector_modal.dart';
import 'package:bizzie/features/settings/presentation/widgets/settings_section.dart';
import 'package:bizzie/features/settings/presentation/widgets/settings_tile.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_secondary_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text('Settings', style: theme.textTheme.displayMedium),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset(
                AppAssets.modalCloseIcon,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          state.mapOrNull(
            failure: (fState) {
              fState.failure.maybeWhen(
                permission: (_) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (sheetContext) => BlocProvider.value(
                      value: context.read<SettingsBloc>(),
                      child: AppBottomModal(
                        title: 'Enable Notifications',
                        useDraggable: false,
                        contentPadding: const EdgeInsets.all(24),
                        builder: (modalContext, _) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Please enable notifications in your system settings to receive important market alerts and filing updates.',
                              style: AppTextStyles.bodyMedium,
                            ),
                            const SizedBox(height: 24),
                            BizziePrimaryButton(
                              title: 'Open Settings',
                              onPressed: () {
                                modalContext.read<SettingsBloc>().add(
                                  const SettingsEvent.openedSettings(),
                                );
                                Navigator.pop(sheetContext);
                              },
                            ),
                            const SizedBox(height: 12),
                            BizzieSecondaryButton(
                              title: 'Cancel',
                              onPressed: () => Navigator.pop(sheetContext),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                orElse: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(fState.failure.message)),
                  );
                },
              );
            },
          );
        },
        builder: (context, state) {
          return state.maybeMap(
            loading: (_) => const Center(child: CircularProgressIndicator()),
            loaded: (state) {
              final data = state.data;
              return ListView(
                padding: const EdgeInsets.only(bottom: 32),
                children: [
                  SettingsSection(
                    title: 'Account',
                    children: [
                      SettingsTile(
                        title: 'Edit Profile',
                        onTap: () {
                          // Navigate to Edit Profile
                        },
                      ),
                      const Divider(height: 1, indent: 52),
                      SettingsTile(
                        title: 'Favorite Sector',
                        onTap: () {
                          final currentSector = Sector.fromString(
                            data.favoriteSector,
                          );
                          if (currentSector != null) {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => ChangeSectorModal(
                                currentSector: currentSector,
                              ),
                            );
                          }
                        },
                      ),
                      const Divider(height: 1, indent: 52),
                      SettingsTile(
                        title: 'Membership',
                        trailing: !data.subscriptionStatus.isSubscribed
                            ? Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 6.0,
                                  ),
                                  child: Text(
                                    '40% OFF',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.surface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                        onTap: () {
                          // Navigate to Manage Subscription
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'Preferences',
                    children: [
                      SettingsTile(
                        title: 'Notifications',
                        trailing: Switch.adaptive(
                          value:
                              data.isAppNotificationsEnabled &&
                              data.isSystemNotificationsEnabled,
                          onChanged: (value) {
                            context.read<SettingsBloc>().add(
                              SettingsEvent.toggledNotifications(value),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'Support',
                    children: [
                      SettingsTile(
                        title: 'Send Feedback',
                        onTap: () {
                          // Show Feedback Dialog
                          context.read<SettingsBloc>().add(
                            const SettingsEvent.submitFeedback('User Feedback'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Feedback Submitted!'),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, indent: 52),
                      SettingsTile(
                        title: 'Privacy Policy',
                        onTap: () {
                          context.read<SettingsBloc>().add(
                            const SettingsEvent.openUrl(
                              'https://bizzie.app/privacy',
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, indent: 52),
                      SettingsTile(
                        title: 'Terms of Service',
                        onTap: () {
                          context.read<SettingsBloc>().add(
                            const SettingsEvent.openUrl(
                              'https://bizzie.app/terms',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          'Version ${data.appVersion}',
                          style: AppTextStyles.caption.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            context.read<SettingsBloc>().add(
                              const SettingsEvent.signedOut(),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.error,
                          ),
                          child: const Text('Log Out'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
