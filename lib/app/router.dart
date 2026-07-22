import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/routes/app_router_redirect.dart';
import 'package:bizzie/core/constants/paywall_query_params.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';
import 'package:bizzie/features/reports/presentation/views/reports_page.dart';
import 'package:bizzie/features/search/presentation/views/search_page.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';
import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:bizzie/features/auth/presentation/views/create_account_page.dart';
import 'package:bizzie/features/onboarding/presentation/widgets/onboarding_shell.dart';
import 'package:bizzie/features/auth/presentation/views/email_sent_page.dart';
import 'package:bizzie/features/auth/presentation/views/forgot_password_page.dart';
import 'package:bizzie/features/auth/presentation/views/login_page.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import 'package:bizzie/features/home/presentation/views/home_page.dart';
import 'package:bizzie/features/home/presentation/bloc/home_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_news/watchlist_news_bloc.dart';
import 'package:bizzie/features/notifications/presentation/views/notification_request_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/ask_name_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/landing_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/feature_highlights_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/meet_your_bizzie_page.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/views/select_your_favorite_brands_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/analyzing_brands_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/bizzie_found_companies_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/building_profile_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/profile_ready_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/adding_to_watchlist_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/investing_experience_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/sector_selection_page.dart';
import 'package:bizzie/features/onboarding/presentation/views/welcome_name_page.dart';
import 'package:bizzie/features/company_profile/cp/presentation/views/company_profile_page.dart';
import 'package:bizzie/features/profile/presentation/views/profile_page.dart';
import 'package:bizzie/features/profile/presentation/views/change_password_view.dart';
import 'package:bizzie/features/profile/presentation/views/edit_profile_view.dart';
import 'package:bizzie/app/navigation/bizzie_bottom_nav_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:bizzie/shared/utils/go_router_refresh_stream.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/di/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:async/async.dart';

import 'package:bizzie/features/subscription/presentation/views/discounted_subscription_page.dart';
import 'package:bizzie/features/subscription/presentation/views/subscription_page.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/settings/presentation/views/settings_view.dart';
import 'package:bizzie/features/security/presentation/views/security_lockout_screen.dart';

import 'package:bizzie/features/subscription/presentation/views/subscription_details_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(
  AuthBloc authBloc,
  UserBloc userBloc, {
  String? initialLocation,
}) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation ?? AppRoutes.splash,
    observers: [getIt<FirebaseAnalyticsObserver>()],
    refreshListenable: GoRouterRefreshStream(
      StreamGroup.merge([authBloc.stream, userBloc.stream]),
    ),
    redirect: (context, state) {
      final authState = authBloc.state;
      final userState = userBloc.state;

      return AppRouterRedirect(
        authState: authState,
        userState: userState,
        state: state,
      ).computeRedirect();
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox.shrink(),
        ),
      ),
      _buildNoTransitionRoute(
        AppRoutes.login,
        const LoginPage(source: AuthSource.landing),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BizzieBottomNavWrapper(navigationShell: navigationShell);
        },
        branches: [
          // BRANCH 1: HOME
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: AppRoutes.homeName,
                builder: (context, state) => MultiBlocProvider(
                  providers: [
                    BlocProvider<HomeBloc>(create: (_) => getIt<HomeBloc>()),
                    BlocProvider<WatchlistNewsBloc>(
                      create: (_) => getIt<WatchlistNewsBloc>(),
                    ),
                  ],
                  child: const HomePage(),
                ),
                routes: [
                  _buildCompanyRoute(AppRoutes.companyProfileHome),
                  _buildPaywallRoute(
                    path: AppRoutes.subscribePath,
                    name: AppRoutes.homeSubscribe,
                    parentNavigatorKey: rootNavigatorKey,
                    child: const SubscriptionPage(),
                  ),
                ],
              ),
            ],
          ),

          // BRANCH 2: REPORTS
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.reports,
                builder: (context, state) {
                  final entrySourceStr =
                      state.uri.queryParameters['entrySource'];
                  final notificationTypeStr =
                      state.uri.queryParameters['notificationType'];

                  final entrySource = ReportsEntrySource.values.firstWhere(
                    (e) => e.name == entrySourceStr,
                    orElse: () => ReportsEntrySource.nav,
                  );

                  final notificationType = ReportsNotificationType.values
                      .firstWhereOrNull((e) => e.name == notificationTypeStr);

                  return ReportsPage(
                    entrySource: entrySource,
                    notificationType: notificationType,
                  );
                },
                routes: [_buildCompanyRoute(AppRoutes.companyProfileReports)],
              ),
            ],
          ),

          // BRANCH 3: PROFILE
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfilePage(),
                routes: [_buildCompanyRoute(AppRoutes.companyProfileProfile)],
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.search,
        pageBuilder: (context, state) {
          final source = state.extra is SearchSource
              ? state.extra as SearchSource
              : SearchSource.home;
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider<SearchBloc>(
              create: (_) =>
                  getIt<SearchBloc>()..add(SearchEvent.started(source: source)),
              child: SearchPage(source: source),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return child;
                },
            transitionDuration: Duration.zero,
          );
        },
      ),

      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) =>
            const ForgotPasswordPage(source: AuthSource.landing),
      ),
      GoRoute(
        path: AppRoutes.emailSent,
        builder: (context, state) => const EmailSentPage(),
      ),
      GoRoute(
        path: AppRoutes.terms,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Terms of Service Screen')),
        ),
      ),
      GoRoute(
        path: AppRoutes.privacy,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Privacy Policy Screen'))),
      ),
      GoRoute(
        path: AppRoutes.companyProfile,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final ticker = state.pathParameters['ticker']!;
          return CompanyProfilePage(
            key: ValueKey('company_$ticker'),
            ticker: ticker,
          );
        },
      ),

      ShellRoute(
        builder: (context, state, child) {
          final bloc = getIt<OnboardingBloc>();
          return BlocProvider<OnboardingBloc>.value(value: bloc, child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.landing,
            builder: (context, state) => const LandingPage(),
          ),
          ShellRoute(
            builder: (context, state, child) {
              return OnboardingShell(child: child);
            },
            routes: [
              _buildNoTransitionRoute(
                AppRoutes.onboardingName,
                const AskNamePage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingWelcome,
                const WelcomeNamePage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingExperience,
                const InvestingExperiencePage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingFeatureHighlights,
                const FeatureHighlightsPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingSectors,
                const SectorSelectionPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingMeetBizzie,
                const MeetYourBizziePage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingBrands,
                const SelectYourFavoriteBrandsPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingAnalyzing,
                const AnalyzingBrandsPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingFoundCompanies,
                const BizzieFoundCompaniesPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingAddingWatchlist,
                const AddingToWatchlistPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingBuildingProfile,
                const BuildingProfilePage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingProfileReady,
                const ProfileReadyPage(),
              ),
              _buildNoTransitionRoute(
                AppRoutes.createAccount,
                const CreateAccountPage(source: AuthSource.onboarding),
              ),
              _buildNoTransitionRoute(
                AppRoutes.onboardingNotifications,
                const NotificationRequestPage(),
              ),
            ],
          ),
        ],
      ),
      _buildPaywallRoute(
        path: AppRoutes.paywall,
        name: AppRoutes.paywall,
        parentNavigatorKey: rootNavigatorKey,
        child: const SubscriptionPage(),
      ),
      _buildPaywallRoute(
        path: AppRoutes.discountedPaywall,
        name: AppRoutes.discountedPaywall,
        parentNavigatorKey: rootNavigatorKey,
        child: const DiscountedSubscriptionPage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          fullscreenDialog: true,
          child: const SettingsView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
        routes: [
          GoRoute(
            path: AppRoutes.editProfilePath,
            name: AppRoutes.editProfile,
            builder: (context, state) => const EditProfileView(),
            routes: [
              GoRoute(
                path: AppRoutes.changePasswordPath,
                name: AppRoutes.changePassword,
                builder: (context, state) => const ChangePasswordView(),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.subscriptionDetailsPath,
            name: AppRoutes.subscriptionDetails,
            builder: (context, state) {
              return const SubscriptionDetailsPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.securityLockout,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SecurityLockoutScreen()),
      ),
    ],
  );
}

GoRoute _buildPaywallRoute({
  required String path,
  required Widget child,
  String? name,
  GlobalKey<NavigatorState>? parentNavigatorKey,
}) {
  return GoRoute(
    path: path,
    name: name,
    parentNavigatorKey: parentNavigatorKey,
    pageBuilder: (context, state) {
      final queryParams = state.uri.queryParameters;
      final animateParam = queryParams['animate'];
      final animate = animateParam != 'false';
      final sourceStr = queryParams[PaywallQueryParams.source];
      final source = PaywallSource.values.firstWhere(
        (e) => e.name == sourceStr,
        orElse: () => PaywallSource.unknown,
      );
      final tabName = queryParams[PaywallQueryParams.tabName];
      final featureName = queryParams[PaywallQueryParams.featureName];
      final onEnter = state.extra is VoidCallback
          ? state.extra as VoidCallback
          : null;

      final pageChild = child is SubscriptionPage
          ? SubscriptionPage(
              source: source,
              tabName: tabName,
              featureName: featureName,
              onEnter: onEnter,
            )
          : child is DiscountedSubscriptionPage
          ? DiscountedSubscriptionPage(
              source: source,
              tabName: tabName,
              featureName: featureName,
              onEnter: onEnter,
            )
          : child;

      if (!animate) {
        return NoTransitionPage(
          key: state.pageKey,
          name: state.name,
          child: pageChild,
        );
      }

      return CustomTransitionPage(
        key: state.pageKey,
        fullscreenDialog: true,
        child: pageChild,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    },
  );
}

GoRoute _buildNoTransitionRoute(String path, Widget child) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      transitionDuration: Duration.zero,
    ),
  );
}

GoRoute _buildCompanyRoute(String routeName) {
  return GoRoute(
    path: AppRoutes.companyProfilePath,
    name: routeName,
    builder: (context, state) {
      final ticker = state.pathParameters['ticker']!;

      return CompanyProfilePage(
        key: ValueKey('${routeName}_$ticker'),
        ticker: ticker,
      );
    },
  );
}
