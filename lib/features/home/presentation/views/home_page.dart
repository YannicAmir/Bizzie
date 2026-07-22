import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/home/presentation/bloc/home_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_news/watchlist_news_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_event.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_state.dart';
import 'package:bizzie/features/home/presentation/utils/home_load_status.dart';
import 'package:bizzie/features/home/presentation/utils/watchlist_prices_state_extensions.dart';
import 'package:bizzie/features/home/presentation/widgets/home_empty_watchlist_view.dart';
import 'package:bizzie/features/home/presentation/widgets/home_news_carousel.dart';
import 'package:bizzie/features/home/presentation/widgets/home_watchlist_widget.dart';
import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_search_bar.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/shared/widgets/loading/mascot_refresh_indicator.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const _refreshSettleTimeout = Duration(seconds: 8);

class HomePage extends StatefulWidget {
  final String? pendingNewsId;

  const HomePage({super.key, this.pendingNewsId});

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_router == null) {
      final router = GoRouter.of(context);
      _router = router;
      _wasOnHomeTab = _isOnHomeTab;
      router.routerDelegate.addListener(_onRouteChanged);
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
      _dispatchPricesRefresh();
    }
    _wasOnHomeTab = isOnHomeTab;
  }

  void _dispatchPricesRefresh() {
    if (!mounted) return;
    context.read<WatchlistPricesBloc>().add(
      const WatchlistPricesEvent.refreshRequested(),
    );
  }

  Future<void> _onRefresh() {
    if (!mounted) return Future<void>.value();
    final pricesBloc = context.read<WatchlistPricesBloc>();
    pricesBloc.add(const WatchlistPricesEvent.refreshRequested());
    return pricesBloc.stream
        .firstWhere((state) => state.isSettled)
        .timeout(
          _refreshSettleTimeout,
          onTimeout: () => pricesBloc.state,
        );
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
              onRefresh: _onRefresh,
              pendingNewsId: widget.pendingNewsId,
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
    required this.onRefresh,
    this.pendingNewsId,
  });

  final Future<void> Function() onRefresh;
  final String? pendingNewsId;

  @override
  Widget build(BuildContext context) {
    return _WatchlistNewsLoader(
      child: _HomeBodyGate(
        onRefresh: onRefresh,
        pendingNewsId: pendingNewsId,
      ),
    );
  }
}

class _WatchlistNewsLoader extends StatefulWidget {
  const _WatchlistNewsLoader({required this.child});

  final Widget child;

  @override
  State<_WatchlistNewsLoader> createState() => _WatchlistNewsLoaderState();
}

class _WatchlistNewsLoaderState extends State<_WatchlistNewsLoader> {
  @override
  void initState() {
    super.initState();
    _dispatchNewsLoad(context.read<WatchlistBloc>().state);
  }

  void _dispatchNewsLoad(WatchlistState state) {
    state.mapOrNull(
      loaded: (loaded) {
        context.read<WatchlistNewsBloc>().add(
          WatchlistNewsEvent.loadRequested(
            loaded.companies.map((company) => company.ticker).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistBloc, WatchlistState>(
      listener: (context, state) => _dispatchNewsLoad(state),
      child: widget.child,
    );
  }
}

class _HomeBodyGate extends StatefulWidget {
  const _HomeBodyGate({
    required this.onRefresh,
    this.pendingNewsId,
  });

  final Future<void> Function() onRefresh;
  final String? pendingNewsId;

  @override
  State<_HomeBodyGate> createState() => _HomeBodyGateState();
}

class _HomeBodyGateState extends State<_HomeBodyGate> {
  bool _hasCompletedInitialLoad = false;

  @override
  void initState() {
    super.initState();
    _hasCompletedInitialLoad = _isInitialLoadComplete(_currentStatus());
  }

  HomeLoadStatus _currentStatus() => resolveHomeLoadStatus(
    context.read<WatchlistBloc>().state,
    context.read<WatchlistPricesBloc>().state,
    context.read<WatchlistNewsBloc>().state,
  );

  bool _isInitialLoadComplete(HomeLoadStatus status) =>
      status == HomeLoadStatus.ready || status == HomeLoadStatus.empty;

  void _latchWhenInitialLoadCompletes() {
    if (_hasCompletedInitialLoad) return;
    if (_isInitialLoadComplete(_currentStatus())) {
      setState(() => _hasCompletedInitialLoad = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final watchlistState = context.watch<WatchlistBloc>().state;

    return MultiBlocListener(
      listeners: [
        BlocListener<WatchlistBloc, WatchlistState>(
          listener: (_, _) => _latchWhenInitialLoadCompletes(),
        ),
        BlocListener<WatchlistPricesBloc, WatchlistPricesState>(
          listener: (_, _) => _latchWhenInitialLoadCompletes(),
        ),
        BlocListener<WatchlistNewsBloc, WatchlistNewsState>(
          listener: (_, _) => _latchWhenInitialLoadCompletes(),
        ),
      ],
      child: _buildChild(context, watchlistState),
    );
  }

  Widget _buildChild(BuildContext context, WatchlistState watchlistState) {
    if (_hasCompletedInitialLoad) {
      return _contentOrEmpty(watchlistState);
    }

    final status = resolveHomeLoadStatus(
      watchlistState,
      context.watch<WatchlistPricesBloc>().state,
      context.watch<WatchlistNewsBloc>().state,
    );
    switch (status) {
      case HomeLoadStatus.loading:
        return BizzieLoader(
          message: 'Loading home...',
          mascotAssetPath: context.read<UserBloc>().state.mascotAsset,
        );
      case HomeLoadStatus.failure:
        return BizzieError(
          message: 'Error loading home',
          mascotAssetPath: context.read<UserBloc>().state.mascotAsset,
        );
      case HomeLoadStatus.empty:
      case HomeLoadStatus.ready:
        return _contentOrEmpty(watchlistState);
    }
  }

  Widget _contentOrEmpty(WatchlistState watchlistState) {
    final hasEmptyWatchlist = watchlistState.maybeMap(
      loaded: (s) => s.companies.isEmpty,
      orElse: () => false,
    );
    return hasEmptyWatchlist
        ? const HomeEmptyWatchlistView()
        : _HomeContent(
            onRefresh: widget.onRefresh,
            pendingNewsId: widget.pendingNewsId,
          );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.onRefresh,
    this.pendingNewsId,
  });

  final Future<void> Function() onRefresh;
  final String? pendingNewsId;

  @override
  Widget build(BuildContext context) {
    return MascotRefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: AppConstants.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeNewsCarousel(pendingNewsId: pendingNewsId),
              const HomeWatchlistWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
