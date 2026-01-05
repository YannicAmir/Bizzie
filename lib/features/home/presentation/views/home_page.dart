import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/features/home/presentation/widgets/home_search_bar.dart';
import 'package:bizzie/features/search/presentation/delegates/stock_search_delegate.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HomeSearchBar(
          onTap: () {
            showSearch(
              context: context,
              delegate: StockSearchDelegate(getIt<SearchBloc>()),
            );
          },
        ),
      ),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state.maybeWhen(
              authenticated: (user) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${user.id}!'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthLogoutRequested());
                    },
                    child: const Text('Logout'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        const AuthDeleteAccountRequested(),
                      );
                    },
                    child: const Text('Delete Account'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () =>
                        context.push(AppRoutes.onboardingNotifications),
                    child: const Text('Notification Shortcut'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Local storage: ${getIt<IUserRepository>().getCachedFavoriteSector() ?? "None"}',
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      return userState.maybeWhen(
                        loaded: (user) => Text('DB: ${user.createdAt}'),
                        orElse: () => const Text('DB: Loading...'),
                      );
                    },
                  ),
                ],
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
