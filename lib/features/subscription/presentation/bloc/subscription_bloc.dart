import 'dart:async';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/subscription/domain/usecases/watch_subscription_status_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/sync_identity_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/purchase_subscription_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/restore_purchases_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/get_offerings_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

import 'package:bizzie/features/subscription/domain/extensions/subscription_offering_extensions.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

final _logger = BizzieLogger('SubscriptionBloc');

@lazySingleton
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final WatchSubscriptionStatusUseCase _watchSubscriptionStatus;
  final SyncIdentityUseCase _syncIdentity;
  final PurchaseSubscriptionUseCase _purchaseSubscription;
  final RestorePurchasesUseCase _restorePurchases;
  final GetOfferingsUseCase _getOfferings;
  final AuthBloc _authBloc;

  StreamSubscription? _statusSubscription;
  StreamSubscription? _authSubscription;

  SubscriptionBloc(
    this._watchSubscriptionStatus,
    this._syncIdentity,
    this._purchaseSubscription,
    this._restorePurchases,
    this._getOfferings,
    this._authBloc,
  ) : super(SubscriptionState.initialState()) {
    on<SubscriptionEventInitialized>(_onInitialized);
    on<SubscriptionStatusUpdated>(_onStatusUpdated);
    on<SubscriptionPurchaseRequested>(_onPurchaseRequested);
    on<SubscriptionRestoreRequested>(_onRestoreRequested);
    on<SubscriptionUserIdentityChanged>(_onUserIdentityChanged);
    on<SubscriptionOfferingsRequested>(_onOfferingsRequested);
    on<SubscriptionPlanToggled>(_onPlanToggled);
    on<SubscriptionPurchaseUICompleted>(_onPurchaseUICompleted);
    on<SubscriptionAppResumed>(_onAppResumed);
    on<SubscriptionExpirationReached>(_onExpirationReached);
    on<SubscriptionResetPurchaseState>(_onResetPurchaseState);

    _authSubscription = _authBloc.stream.listen((authState) {
      if (authState is AuthAuthenticated) {
        add(SubscriptionEvent.userIdentityChanged(authState.user.id));
      } else if (authState is AuthUnauthenticated) {
        add(const SubscriptionEvent.userIdentityChanged(null));
      }
    });
  }

  Future<void> _onResetPurchaseState(
    SubscriptionResetPurchaseState event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('Resetting purchase state (Safety Fallback)');
    state.mapOrNull(
      loaded: (s) =>
          emit(s.copyWith(isPurchasing: false, isLocalSuccessOverride: false)),
    );
  }

  Future<void> _onPurchaseUICompleted(
    SubscriptionPurchaseUICompleted event,
    Emitter<SubscriptionState> emit,
  ) async {
    state.mapOrNull(
      loaded: (s) {
        emit(s.copyWith(isPurchasing: false, isLocalSuccessOverride: false));
        // Now that UI is ready, refresh offerings to reflect new eligibility
        add(const SubscriptionEvent.offeringsRequested());
      },
    );
  }

  Future<void> _onAppResumed(
    SubscriptionAppResumed event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('App resumed, refreshing subscription status');
    // Force a status refresh
    _watchSubscriptionStatus.refresh();
    add(const SubscriptionEvent.offeringsRequested());
  }

  Future<void> _onInitialized(
    SubscriptionEventInitialized event,
    Emitter<SubscriptionState> emit,
  ) async {
    final authState = _authBloc.state;
    if (authState is AuthAuthenticated) {
      add(SubscriptionEvent.userIdentityChanged(authState.user.id));
    } else {
      add(const SubscriptionEvent.offeringsRequested());
    }
  }

  Future<void> _onUserIdentityChanged(
    SubscriptionUserIdentityChanged event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('User identity changed to: ${event.uid}');

    await _statusSubscription?.cancel();
    _statusSubscription = null;

    await _syncIdentity(event.uid);

    if (event.uid != null) {
      _logger.info('Watching subscription status for user: ${event.uid}');
      _statusSubscription = _watchSubscriptionStatus(event.uid!).listen(
        (status) {
          add(SubscriptionStatusUpdated(status));
        },
        onError: (error, stack) {
          _logger.severe('Subscription status stream error', error, stack);
        },
      );
      add(const SubscriptionEvent.offeringsRequested());
    } else {
      _logger.info('User logged out, resetting subscription state');
      emit(SubscriptionState.initialState());
    }
  }

  void _onStatusUpdated(
    SubscriptionStatusUpdated event,
    Emitter<SubscriptionState> emit,
  ) {
    final oldStatus = state.status;
    final newStatus = event.status;

    // If entitlement status changed (e.g. Expired -> Active or Active -> Expired),
    // we MUST re-fetch offerings to update the "Intro Eligibility" (Trial Available) flag.
    if (oldStatus.isSubscribed != newStatus.isSubscribed) {
      _logger.info(
        'Entitlement status changed (${oldStatus.isSubscribed} -> ${newStatus.isSubscribed}). Refreshing offerings.',
      );
      add(const SubscriptionEvent.offeringsRequested());
    }

    _scheduleExpirationTimer(newStatus);

    state.map(
      initial: (s) => emit(s.copyWith(status: event.status)),
      loading: (s) => emit(s.copyWith(status: event.status)),
      loaded: (s) {
        // Do NOT clear isLocalSuccessOverride here.
        // We rely on purchaseUICompleted event to clear it to avoid race conditions.
        emit(s.copyWith(status: event.status));
      },
      failure: (s) => emit(s.copyWith(status: event.status)),
    );
  }

  Timer? _expirationTimer;

  void _scheduleExpirationTimer(SubscriptionStatus status) {
    _expirationTimer?.cancel();
    _expirationTimer = null;

    if (status.isSubscribed && status.expirationDate != null) {
      final now = DateTime.now();
      if (status.expirationDate!.isAfter(now)) {
        final duration = status.expirationDate!.difference(now);
        // Add a small buffer (2 seconds) to ensure server side processing is complete/SDK cache is likely invalidated
        final timerDuration = duration + const Duration(seconds: 2);

        _logger.info(
          'Scheduling proactive expiration refresh in ${timerDuration.inSeconds} seconds (at ${status.expirationDate}).',
        );

        _expirationTimer = Timer(timerDuration, () {
          _logger.info('Expiration timer fired. Triggering refresh.');
          add(const SubscriptionEvent.expirationReached());
        });
      }
    }
  }

  Future<void> _onExpirationReached(
    SubscriptionExpirationReached event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info(
      'Processing expiration event. Invalidating cache and refreshing.',
    );
    // Force a status refresh
    _watchSubscriptionStatus.refresh();
    add(const SubscriptionEvent.offeringsRequested());
  }

  Future<void> _onPurchaseRequested(
    SubscriptionPurchaseRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('Purchase requested for package: ${event.package.identifier}');

    final currentState = state;
    if (currentState is SubscriptionStateLoaded) {
      emit(currentState.copyWith(isPurchasing: true));
    } else {
      emit(SubscriptionState.loading(status: state.status));
    }

    final result = await _purchaseSubscription(event.package);

    result.fold(
      (failure) {
        failure.maybeMap(
          cancel: (_) {
            _logger.info('Purchase cancelled by user');
            state.mapOrNull(
              loaded: (s) => emit(s.copyWith(isPurchasing: false)),
            );
          },
          orElse: () {
            _logger.severe('Purchase failed', failure.message);
            emit(
              SubscriptionState.failure(status: state.status, failure: failure),
            );
          },
        );
      },
      (status) {
        _logger.info('Purchase successful for ${event.package.identifier}');
        state.maybeMap(
          loaded: (s) => emit(
            s.copyWith(
              status: status,
              isLocalSuccessOverride: true,
              isPurchasing: true,
            ),
          ),
          orElse: () => emit(SubscriptionState.initial(status: status)),
        );
      },
    );
  }

  Future<void> _onRestoreRequested(
    SubscriptionRestoreRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('Restore purchases requested');
    emit(SubscriptionState.loading(status: state.status));

    final result = await _restorePurchases(NoParams());

    result.fold(
      (failure) {
        _logger.severe('Restore purchases failed', failure.message);
        emit(SubscriptionState.failure(status: state.status, failure: failure));
      },
      (status) {
        _logger.info(
          'Restore purchases successful. Active: ${status.isSubscribed}',
        );
        emit(SubscriptionState.initial(status: status));
        add(const SubscriptionEvent.offeringsRequested());
      },
    );
  }

  Future<void> _onOfferingsRequested(
    SubscriptionOfferingsRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    // If we are in the middle of a purchase flow (isPurchasing = true),
    // we MUST NOT update the state with new offerings.
    // Doing so would:
    // 1. Reset isPurchasing to false (unfreezing the UI early).
    // 2. Update the UI with "post-purchase" data (e.g. removing free trial text)
    //    while the native dialog is possibly still visible.
    //
    // The UI will signal completion via _onPurchaseUICompleted, at which point
    // we will re-fetch offerings.
    final currentState = state;
    if (currentState is SubscriptionStateLoaded && currentState.isPurchasing) {
      _logger.info('Offerings requested but blocked by active purchase flow.');
      return;
    }

    _logger.info('Offerings requested');
    final result = await _getOfferings(NoParams());

    result.fold(
      (failure) {
        _logger.severe('Failed to fetch offerings', failure.message);
        emit(SubscriptionState.failure(status: state.status, failure: failure));
      },
      (offering) {
        _logger.info('Offerings fetched successfully');
        emit(
          SubscriptionState.loaded(
            status: state.status,
            offerings: offering,
            annualPackage: offering.annualPackage,
            monthlyPackage: offering.monthlyPackage,
            discountAnnualPackage: offering.discountAnnualPackage,
          ),
        );
      },
    );
  }

  void _onPlanToggled(
    SubscriptionPlanToggled event,
    Emitter<SubscriptionState> emit,
  ) {
    state.maybeMap(
      loaded: (s) => emit(s.copyWith(isAnnualSelection: event.isAnnual)),
      orElse: () => null,
    );
  }

  @override
  Future<void> close() {
    _expirationTimer?.cancel();
    _statusSubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
