import 'dart:async';

import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bloc/bloc.dart';

final _logger = BizzieLogger('AuthSessionResetMixin');

mixin AuthSessionResetMixin<Event, State> on Bloc<Event, State> {
  StreamSubscription<UserModel?>? _authSessionSubscription;

  void resetOnSessionEnd(GetAuthStream getAuthStream, Event resetEvent) {
    _authSessionSubscription = getAuthStream()
        .where((user) => user == null)
        .listen((_) {
          _logger.info('Auth session ended. Dispatching $runtimeType reset.');
          add(resetEvent);
        });
  }

  @override
  Future<void> close() async {
    await _authSessionSubscription?.cancel();
    return super.close();
  }
}
