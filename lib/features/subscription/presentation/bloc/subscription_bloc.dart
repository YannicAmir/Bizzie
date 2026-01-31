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

import 'package:bizzie/features/subscription/domain/models/subscription_offering_extensions.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

final _logger = BizzieLogger('SubscriptionBloc');

@injectable
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

    _authSubscription = _authBloc.stream.listen((authState) {
      if (authState is AuthAuthenticated) {
        add(SubscriptionEvent.userIdentityChanged(authState.user.id));
      } else if (authState is AuthUnauthenticated) {
        add(const SubscriptionEvent.userIdentityChanged(null));
      }
    });
  }

  Future<void> _onInitialized(
    SubscriptionEventInitialized event,
    Emitter<SubscriptionState> emit,
  ) async {
    final authState = _authBloc.state;
    if (authState is AuthAuthenticated) {
      add(SubscriptionEvent.userIdentityChanged(authState.user.id));
    }
    add(const SubscriptionEvent.offeringsRequested());
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
      emit(SubscriptionState.initialState());
    }
  }

  void _onStatusUpdated(
    SubscriptionStatusUpdated event,
    Emitter<SubscriptionState> emit,
  ) {
    state.map(
      initial: (s) => emit(s.copyWith(status: event.status)),
      loading: (s) => emit(s.copyWith(status: event.status)),
      loaded: (s) {
        if (s.isLocalSuccessOverride && event.status.isSubscribed) {
          emit(s.copyWith(status: event.status, isLocalSuccessOverride: false));
        } else if (!s.isLocalSuccessOverride) {
          emit(s.copyWith(status: event.status));
        }
      },
      failure: (s) => emit(s.copyWith(status: event.status)),
    );
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
              isPurchasing: false,
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
        _logger.info('Restore purchases successful');
        emit(SubscriptionState.initial(status: status));
        add(const SubscriptionEvent.offeringsRequested());
      },
    );
  }

  Future<void> _onOfferingsRequested(
    SubscriptionOfferingsRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
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

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    _authSubscription?.cancel();
    return super.close();
  }
}
