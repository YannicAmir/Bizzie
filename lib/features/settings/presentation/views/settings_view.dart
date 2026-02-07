import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/settings_state.dart';
import 'package:bizzie/features/settings/presentation/widgets/settings_section.dart';
import 'package:bizzie/features/settings/presentation/widgets/settings_tile.dart';
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
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          state.mapOrNull(
            failure: (f) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(f.failure.message)));
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
                          // Navigate to Sector Selection
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
                        subtitle:
                            data.isAppNotificationsEnabled &&
                                !data.isSystemNotificationsEnabled
                            ? const _SystemNotificationWarningBanner()
                            : null,
                        trailing: Switch.adaptive(
                          value: data.isAppNotificationsEnabled,
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

class _SystemNotificationWarningBanner extends StatelessWidget {
  const _SystemNotificationWarningBanner();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 14, color: theme.colorScheme.error),
          const SizedBox(width: 4),
          Text(
            'Disabled in System Settings',
            style: AppTextStyles.caption.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
