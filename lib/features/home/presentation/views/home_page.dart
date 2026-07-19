import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/home/presentation/widgets/home_news_carousel.dart';
import 'package:bizzie/features/home/presentation/widgets/home_watchlist_widget.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/home/presentation/bloc/home_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_event.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_search_bar.dart';
import 'package:bizzie/shared/widgets/loading/mascot_refresh_indicator.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoRouter? _router;
  bool _wasOnHomeTab = true;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeEvent.started());
    _dispatchPricesLoad();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_router == null) {
      _router = GoRouter.of(context);
      _wasOnHomeTab = _isOnHomeTab;
      _router!.routerDelegate.addListener(_onRouteChanged);
    }
  }

  @override
  void dispose() {
    _router?.routerDelegate.removeListener(_onRouteChanged);
    super.dispose();
  }

  bool get _isOnHomeTab {
    final location =
        _router?.routerDelegate.currentConfiguration.uri.path ?? '';
    return location == AppRoutes.home;
  }

  void _onRouteChanged() {
    final isOnHomeTab = _isOnHomeTab;
    if (isOnHomeTab && !_wasOnHomeTab) {
      _dispatchPricesLoad();
    }
    _wasOnHomeTab = isOnHomeTab;
  }

  void _dispatchPricesLoad() {
    if (!mounted) return;
    context.read<WatchlistBloc>().state.mapOrNull(
      loaded: (s) {
        context.read<WatchlistPricesBloc>().add(
          WatchlistPricesEvent.loadRequested(
            s.companies.map((company) => company.ticker).toList(),
          ),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    _dispatchPricesLoad();
    return Future<void>.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BizzieSearchBar(
          readOnly: true,
          onTap: () {
            context.push(AppRoutes.search, extra: SearchSource.home);
          },
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            failure: (failure) => BizzieSnackBar.show(
              context,
              message: failure.errorMessage,
              type: BizzieSnackBarType.error,
            ),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            authenticated: (_) => _AuthenticatedHomeBody(
              onWatchlistChanged: _dispatchPricesLoad,
              onRefresh: _onRefresh,
            ),
            orElse: () =>
                const BizzieLoader(message: 'Loading your profile...'),
          );
        },
      ),
    );
  }
}

class _AuthenticatedHomeBody extends StatelessWidget {
  const _AuthenticatedHomeBody({
    required this.onWatchlistChanged,
    required this.onRefresh,
  });

  final VoidCallback onWatchlistChanged;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistBloc, WatchlistState>(
      listener: (context, state) => onWatchlistChanged(),
      child: MascotRefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: AppConstants.pagePadding,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [HomeNewsCarousel(), HomeWatchlistWidget()],
            ),
          ),
        ),
      ),
    );
  }
}
