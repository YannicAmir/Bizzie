import 'package:async/async.dart';
import 'package:bizzie/app/routes/app_router_redirect.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/utils/go_router_refresh_stream.dart';
import 'package:go_router/go_router.dart';

class AppRouterRefresh {
  final GoRouter _router;
  final AuthBloc _authBloc;
  final UserBloc _userBloc;
  late final GoRouterRefreshStream _refreshStream;

  AppRouterRefresh({
    required GoRouter router,
    required AuthBloc authBloc,
    required UserBloc userBloc,
  }) : _router = router,
       _authBloc = authBloc,
       _userBloc = userBloc {
    _refreshStream = GoRouterRefreshStream(
      StreamGroup.merge([authBloc.stream, userBloc.stream]),
    )..addListener(_redirectLiveStack);
  }

  void _redirectLiveStack() {
    if (_router.routerDelegate.currentConfiguration.isEmpty) return;
    final location = AppRouterRedirect(
      authState: _authBloc.state,
      userState: _userBloc.state,
      state: _router.state,
    ).computeRedirect();
    if (location != null) _router.go(location);
  }

  void dispose() => _refreshStream.dispose();
}
