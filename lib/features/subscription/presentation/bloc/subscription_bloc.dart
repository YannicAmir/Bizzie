import 'dart:async';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/subscription/domain/usecases/watch_subscription_status_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/sync_identity_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/purchase_subscription_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/restore_purchases_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

import 'subscription_event.dart';
import 'subscription_state.dart';

final _logger = BizzieLogger('SubscriptionBloc');

@injectable
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final WatchSubscriptionStatusUseCase _watchSubscriptionStatus;
  final SyncIdentityUseCase _syncIdentity;
  final PurchaseSubscriptionUseCase _purchaseSubscription;
  final RestorePurchasesUseCase _restorePurchases;
  final AuthBloc _authBloc;

  StreamSubscription? _statusSubscription;
  StreamSubscription? _authSubscription;

  SubscriptionBloc(
    this._watchSubscriptionStatus,
    this._syncIdentity,
    this._purchaseSubscription,
    this._restorePurchases,
    this._authBloc,
  ) : super(SubscriptionState.initial()) {
    on<SubscriptionEventInitialized>(_onInitialized);
    on<SubscriptionStatusUpdated>(_onStatusUpdated);
    on<SubscriptionPurchaseRequested>(_onPurchaseRequested);
    on<SubscriptionRestoreRequested>(_onRestoreRequested);
    on<SubscriptionUserIdentityChanged>(_onUserIdentityChanged);

    _authSubscription = _authBloc.stream.listen((authState) {
      if (authState is AuthAuthenticated) {
        add(SubscriptionEvent.userIdentityChanged(authState.user.id));
      } else if (authState is AuthUnauthenticated) {
        add(const SubscriptionEvent.userIdentityChanged(null));
      }
    });

    final initialAuthState = _authBloc.state;
    if (initialAuthState is AuthAuthenticated) {
      add(SubscriptionEvent.userIdentityChanged(initialAuthState.user.id));
    }

    add(const SubscriptionEvent.initialized());
  }

  Future<void> _onInitialized(
    SubscriptionEventInitialized event,
    Emitter<SubscriptionState> emit,
  ) async {
    // Initial setup if needed
  }

  Future<void> _onUserIdentityChanged(
    SubscriptionUserIdentityChanged event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('User identity changed to: ${event.uid}');
    await _syncIdentity(event.uid);

    await _statusSubscription?.cancel();

    if (event.uid != null) {
      _logger.info('Watching subscription status for user: ${event.uid}');
      _statusSubscription = _watchSubscriptionStatus(event.uid!).listen((
        status,
      ) {
        add(SubscriptionEvent.statusUpdated(status));
      });
    } else {
      _logger.info('User logged out, resetting subscription state');
      emit(SubscriptionState.initial());
    }
  }

  void _onStatusUpdated(
    SubscriptionStatusUpdated event,
    Emitter<SubscriptionState> emit,
  ) {
    if (state.isLocalSuccessOverride && event.status.isSubscribed) {
      emit(state.copyWith(status: event.status, isLocalSuccessOverride: false));
    } else if (!state.isLocalSuccessOverride) {
      emit(state.copyWith(status: event.status));
    }
  }

  Future<void> _onPurchaseRequested(
    SubscriptionPurchaseRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('Purchase requested for package: ${event.package.identifier}');
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _purchaseSubscription(event.package);

    result.fold(
      (failure) {
        _logger.severe('Purchase failed', failure.message);
        emit(state.copyWith(isLoading: false, failure: failure));
      },
      (status) {
        _logger.info('Purchase successful for ${event.package.identifier}');
        emit(
          state.copyWith(
            isLoading: false,
            isLocalSuccessOverride: true,
            status: status,
          ),
        );
      },
    );
  }

  Future<void> _onRestoreRequested(
    SubscriptionRestoreRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('Restore purchases requested');
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _restorePurchases(NoParams());

    result.fold(
      (failure) {
        _logger.severe('Restore purchases failed', failure.message);
        emit(state.copyWith(isLoading: false, failure: failure));
      },
      (status) {
        _logger.info('Restore purchases successful');
        emit(state.copyWith(isLoading: false, status: status));
      },
    );
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
