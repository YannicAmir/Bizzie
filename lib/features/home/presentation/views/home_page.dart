import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/home/presentation/widgets/home_watchlist_widget.dart';
import 'package:bizzie/shared/widgets/badges/bizzie_plus_badge.dart';

class HomePage extends StatefulWidget {
  final Object? extra;

  const HomePage({super.key, this.extra});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _pendingPaywall = false;

  @override
  void initState() {
    super.initState();
    if (widget.extra == 'open_paywall_onboarding') {
      _pendingPaywall = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.push('${AppRoutes.paywall}?animate=onboarding');

        if (mounted) {
          setState(() {
            _pendingPaywall = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_pendingPaywall) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: BizzieSearchBar(
                readOnly: true,
                onTap: () {
                  context.push(AppRoutes.search, extra: 'home');
                },
              ),
            ),
            const SizedBox(width: 8),
            const BizziePlusBadge(),
          ],
        ),
      ),
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              authenticated: (_) {},
              failure: (failure) => ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message))),
              orElse: () => null,
            );
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.maybeWhen(
                authenticated: (user) => SingleChildScrollView(
                  child: Padding(
                    padding: AppConstants.pagePadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Welcome, ${user.id}!'),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              const AuthLogoutRequested(),
                            );
                          },
                          child: const Text('Logout'),
                        ),
                        _DebugInfo(),
                        const SizedBox(height: 20),
                        const HomeWatchlistWidget(),
                      ],
                    ),
                  ),
                ),
                orElse: () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Hello Bizzie!'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.push(AppRoutes.login),
                      child: const Text('Go to Login'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => context.push(AppRoutes.createAccount),
                      child: const Text('Go to Create Account'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () =>
                          context.push(AppRoutes.onboardingNotifications),
                      child: const Text('Notification Shortcut'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => context.push(AppRoutes.paywall),
                      child: const Text('Paywall Shortcut'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          context.push(AppRoutes.discountedPaywall),
                      child: const Text('Discounted Paywall Shortcut'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DebugInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (user) => Column(
            children: [
              Text('Local storage: ${user.favoriteSector}'),
              const SizedBox(height: 10),
              Text('DB: ${user.createdAt}'),
            ],
          ),
          loading: (cachedSector) => Column(
            children: [
              Text('Local storage: ${cachedSector ?? "Loading..."}'),
              const SizedBox(height: 10),
              const Text('DB: Loading...'),
            ],
          ),
          failure: (failure, _, cachedSector) => Column(
            children: [
              Text('Local storage: ${cachedSector ?? "Error"}'),
              const SizedBox(height: 10),
              Text(
                'DB Error: ${failure.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          orElse: () => const Text('Loading debug data...'),
        );
      },
    );
  }
}
