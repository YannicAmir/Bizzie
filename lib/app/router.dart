import 'package:bizzie/features/auth/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder:
          (context, state) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Hello Bizzie!'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Go to Login'),
                  ),
                ],
              ),
            ),
          ),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    // Placeholders for now
    GoRoute(
      path: '/forgot-password',
      builder:
          (context, state) => const Scaffold(
            body: Center(child: Text('Forgot Password Screen')),
          ),
    ),
    GoRoute(
      path: '/terms',
      builder:
          (context, state) => const Scaffold(
            body: Center(child: Text('Terms of Service Screen')),
          ),
    ),
    GoRoute(
      path: '/privacy',
      builder:
          (context, state) => const Scaffold(
            body: Center(child: Text('Privacy Policy Screen')),
          ),
    ),
  ],
);
