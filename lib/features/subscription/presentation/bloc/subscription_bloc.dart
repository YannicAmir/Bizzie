import 'dart:async';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/subscription/domain/usecases/watch_subscription_status_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/refresh_subscription_status_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/sync_identity_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/purchase_subscription_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/restore_purchases_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/get_offerings_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/sync_subscription_use_case.dart';
import 'package:bizzie/features/subscription/domain/extensions/subscription_offering_extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/models/analytics_purchase_params.dart';
import 'package:bizzie/features/subscription/presentation/analytics/paywall_analytics.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_tracker.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

final _logger = BizzieLogger('SubscriptionBloc');

@lazySingleton
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final WatchSubscriptionStatusUseCase _watchSubscriptionStatus;
  final RefreshSubscriptionStatusUseCase _refreshSubscriptionStatus;
  final SyncIdentityUseCase _syncIdentity;
  final PurchaseSubscriptionUseCase _purchaseSubscription;
  final RestorePurchasesUseCase _restorePurchases;
  final GetOfferingsUseCase _getOfferings;
  final AuthBloc _authBloc;
  final SyncSubscriptionUseCase _syncSubscription;
  final Stream<bool> _isSubscribedStream;
  final PaywallAnalytics _analytics;
  final OnboardingTracker _onboardingTracker;

  StreamSubscription? _statusSubscription;
  StreamSubscription? _authSubscription;
  Timer? _backgroundSyncTimer;

  SubscriptionBloc(
    this._watchSubscriptionStatus,
    this._refreshSubscriptionStatus,
    this._syncIdentity,
    this._purchaseSubscription,
    this._restorePurchases,
    this._getOfferings,
    this._authBloc,
    this._syncSubscription,
    @Named('isSubscribedStream') this._isSubscribedStream,
    this._analytics,
    this._onboardingTracker,
  ) : super(SubscriptionState.initialState()) {
    on<SubscriptionEventInitialized>(_onInitialized);
    on<SubscriptionStatusUpdated>(_onStatusUpdated);
    on<SubscriptionPurchaseRequested>(_onPurchaseRequested);
    on<SubscriptionRestoreRequested>(_onRestoreRequested);
    on<SubscriptionUserIdentityChanged>(_onUserIdentityChanged);
    on<SubscriptionOfferingsRequested>(_onOfferingsRequested);
    on<SubscriptionRefreshRequested>(_onRefreshRequested);
    on<SubscriptionPlanToggled>(_onPlanToggled);
    on<SubscriptionPurchaseUICompleted>(_onPurchaseUICompleted);
    on<SubscriptionAppResumed>(_onAppResumed);
    on<SubscriptionExpirationReached>(_onExpirationReached);
    on<SubscriptionResetPurchaseState>(_onResetPurchaseState);
    on<SubscriptionViewed>(_onViewed);
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
    final wasSuccessful = state.maybeMap(
      loaded: (s) => s.isLocalSuccessOverride,
      orElse: () => false,
    );

    state.mapOrNull(
      loaded: (s) {
        emit(s.copyWith(isPurchasing: false, isLocalSuccessOverride: false));
        add(const SubscriptionEvent.offeringsRequested());
      },
    );

    if (wasSuccessful) {
      _startBackgroundSyncSafeguard();
    }
  }

  Future<void> _onAppResumed(
    SubscriptionAppResumed event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('App resumed, refreshing subscription status and offerings');

    await _refreshSubscriptionStatus(NoParams());

    add(const SubscriptionEvent.offeringsRequested());
  }

  Future<void> _onViewed(
    SubscriptionViewed event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('Paywall viewed from source: ${event.source}');
    emit(state.copyWith(paywallSource: event.source));
    await _analytics.logViewed(source: event.source);

    if (event.source == PaywallSource.onboarding) {
      await _onboardingTracker.logStepViewed(step: OnboardingStep.paywall);
    }
  }

  Future<void> _onRefreshRequested(
    SubscriptionRefreshRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    _logger.info('Manual subscription status refresh requested');
    await _refreshSubscriptionStatus(NoParams());
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

    await _authSubscription?.cancel();
    _authSubscription = _authBloc.stream.listen((authState) {
      if (authState is AuthAuthenticated) {
        add(SubscriptionEvent.userIdentityChanged(authState.user.id));
      } else if (authState is AuthUnauthenticated) {
        add(const SubscriptionEvent.userIdentityChanged(null));
      }
    });
  }

  Future<void> _onUserIdentityChanged(
    SubscriptionUserIdentityChanged event,
    Emitter<SubscriptionState> emit,
  ) async {
    if (_lastSyncedUid == event.uid && _statusSubscription != null) {
      _logger.info(
        'Identity already synced for ${event.uid}. Skipping redundant refresh.',
      );
      return;
    }

    _logger.info('User identity changed to: ${event.uid}');
    _lastSyncedUid = event.uid;

    await _statusSubscription?.cancel();
    _statusSubscription = null;

    final result = await _syncIdentity(event.uid);

    result.fold(
      (failure) {
        _logger.severe(
          'Failed to sync identity with subscription service',
          failure.message,
        );
      },
      (_) {
        _logger.info('Identity sync successful for: ${event.uid}');
        _refreshSubscriptionStatus(NoParams());
      },
    );

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
    }

    if (event.uid == null) {
      _logger.info('User logged out, resetting subscription state');
      emit(SubscriptionState.initialState());
    }
  }

  String? _lastSyncedUid;

  void _onStatusUpdated(
    SubscriptionStatusUpdated event,
    Emitter<SubscriptionState> emit,
  ) {
    final oldStatus = state.status;
    final newStatus = event.status;

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
      final now = DateTime.now().toUtc();
      if (status.expirationDate!.isAfter(now)) {
        final duration = status.expirationDate!.difference(now);
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
    _refreshSubscriptionStatus(NoParams());
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

        final source = state.paywallSource ?? PaywallSource.app;
        final isTrial = status.periodType == SubscriptionPeriodType.trial;
        final productId = status.activeProductIds.firstOrNull ?? 'unknown';

        final params = AnalyticsPurchaseParams(
          productId: productId,
          packageType: event.package.packageType,
          periodType: status.periodType,
          source: source,
        );

        if (isTrial) {
          _analytics.logTrialStarted(params);
        } else {
          _analytics.logPurchaseSuccess(params);
        }

        if (source == PaywallSource.onboarding) {
          _onboardingTracker.logConversion();
        }

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
    final currentState = state;
    if (currentState is SubscriptionStateLoaded && currentState.isPurchasing) {
      _logger.info('Offerings requested but blocked by active purchase flow.');
      return;
    }

    _logger.info('Offerings requested');

    final status = state.status;
    if (status.isSubscribed && status.expirationDate != null) {
      final now = DateTime.now().toUtc();
      final diff = status.expirationDate!.difference(now);
      if (diff.inMinutes < 35) {
        _logger.info(
          'Near expiration (diff: ${diff.inMinutes}m). Forcing refresh before offerings.',
        );
        await _refreshSubscriptionStatus(NoParams());
      }
    }

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

  void _startBackgroundSyncSafeguard() {
    _backgroundSyncTimer?.cancel();
    _logger.info('Background sync safeguard started (10s countdown).');

    _backgroundSyncTimer = Timer(const Duration(seconds: 10), () async {
      _logger.info('Background sync timer fired. Checking Firestore status...');

      try {
        final isSubscribed = await _isSubscribedStream.first;

        if (isSubscribed) {
          _logger.info(
            'Firestore already shows isSubscribed=true. No sync needed.',
          );
          return;
        }

        _logger.warning(
          'Firestore still shows isSubscribed=false after 10s. '
          'Triggering manual backend sync...',
        );

        final result = await _syncSubscription(NoParams());
        result.fold(
          (failure) => _logger.severe(
            'Background sync failed (graceful degradation): '
            '${failure.message}',
          ),
          (_) => _logger.info('Background sync completed successfully.'),
        );
      } catch (e, s) {
        _logger.severe('Background sync safeguard error (silent)', e, s);
      }
    });
  }

  @override
  Future<void> close() {
    _backgroundSyncTimer?.cancel();
    _expirationTimer?.cancel();
    _statusSubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
