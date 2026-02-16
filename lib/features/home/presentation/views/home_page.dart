import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/home/presentation/widgets/home_watchlist_widget.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_search_bar.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';

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
        title: BizzieSearchBar(
          readOnly: true,
          onTap: () {
            context.push(AppRoutes.search, extra: 'home');
          },
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (_) {},
            failure: (failure) => BizzieSnackBar.show(
              context,
              message: failure.message,
              type: BizzieSnackBarType.error,
            ),
            orElse: () => null,
          );
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state.maybeWhen(
              authenticated: (user) => SingleChildScrollView(
                child: Padding(
                  padding: AppConstants.pagePadding,
                  child: const HomeWatchlistWidget(),
                ),
              ),
              orElse: () =>
                  const BizzieLoader(message: 'Loading your profile...'),
            );
          },
        ),
      ),
    );
  }
}
