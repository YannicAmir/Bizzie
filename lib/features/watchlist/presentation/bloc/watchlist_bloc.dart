import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/watchlist/domain/usecases/add_to_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_enriched_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_events_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/remove_from_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/sync_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/features/watchlist/presentation/analytics/watchlist_analytics.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:bizzie/features/watchlist/domain/models/add_to_watchlist_params.dart';
import 'package:bizzie/features/watchlist/domain/models/remove_from_watchlist_params.dart';
import 'package:bizzie/features/watchlist/domain/models/sync_watchlist_params.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

final _logger = BizzieLogger('WatchlistBloc');

@injectable
class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistUseCase _getWatchlistUseCase;
  final GetEnrichedWatchlistUseCase _getEnrichedWatchlistUseCase;
  final GetWatchlistEventsUseCase _getWatchlistEventsUseCase;
  final AddToWatchlistUseCase _addToWatchlistUseCase;
  final RemoveFromWatchlistUseCase _removeFromWatchlistUseCase;
  final SyncWatchlistUseCase _syncWatchlistUseCase;
  final IAuthRepository _authRepository;
  final WatchlistAnalytics _watchlistAnalytics;

  WatchlistBloc(
    this._getWatchlistUseCase,
    this._getEnrichedWatchlistUseCase,
    this._getWatchlistEventsUseCase,
    this._addToWatchlistUseCase,
    this._removeFromWatchlistUseCase,
    this._syncWatchlistUseCase,
    this._authRepository,
    this._watchlistAnalytics,
  ) : super(const WatchlistState.initial()) {
    on<SyncRequested>(_onSyncRequested, transformer: droppable());
    on<AddRequested>(_onAddRequested, transformer: droppable());
    on<RemoveRequested>(_onRemoveRequested, transformer: droppable());
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<LoadWatchlistEvents>(_onLoadWatchlistEvents, transformer: restartable());
    on<Reset>(_onReset);
  }

  void _onReset(Reset event, Emitter<WatchlistState> emit) {
    _logger.info('Resetting WatchlistBloc');
    emit(const WatchlistState.initial());
  }

  String? get _uid => _authRepository.currentUser?.id;

  String? _normalizedLogoUrl(String? logoUrl) =>
      (logoUrl == null || logoUrl.isEmpty) ? null : logoUrl;

  String? _uidOrEmitFailure(Emitter<WatchlistState> emit) {
    final uid = _uid;
    if (uid == null) {
      emit(WatchlistState.failure(Failure.server("User not authenticated")));
    }
    return uid;
  }

  void _emitOperationFailure(
    String operation,
    Failure failure,
    Emitter<WatchlistState> emit,
  ) {
    _watchlistAnalytics.logOperationFailed(
      operation: operation,
      errorMessage: failure.errorMessage,
    );
    emit(WatchlistState.failure(failure));
  }

  Company _companyFromEvent(AddRequested event) => Company(
    ticker: event.ticker,
    name: event.name ?? event.ticker,
    logoUrl: _normalizedLogoUrl(event.logoUrl),
  );

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<WatchlistState> emit,
  ) async {
    final uid = event.uid ?? _uid;
    if (uid == null) {
      _logger.warning(
        'LoadRequested event without UID and repository UID is null',
      );
      emit(WatchlistState.failure(Failure.server("User not authenticated")));
      return;
    }

    _logger.info('Loading watchlist for UID: $uid');
    emit(const WatchlistState.loading());

    await emit.forEach<
      Either<Failure, (List<Company>, Map<String, WatchlistEventStatus>)>
    >(
      _getEnrichedWatchlistUseCase(uid),
      onData: (result) {
        return result.fold((failure) => WatchlistState.failure(failure), (
          data,
        ) {
          _watchlistAnalytics.setWatchlistItemCount(data.$1.length);
          return WatchlistState.loaded(data.$1, events: data.$2);
        });
      },
      onError: (error, stack) {
        _logger.severe('Watchlist stream error', error, stack);
        return WatchlistState.failure(Failure.server('Stream Error'));
      },
    );
  }

  Future<void> _onLoadWatchlistEvents(
    LoadWatchlistEvents event,
    Emitter<WatchlistState> emit,
  ) async {
    final companies = state.maybeMap(
      loaded: (s) => s.companies,
      orElse: () => null,
    );

    if (companies == null) return;

    final result = await _getWatchlistEventsUseCase(event.tickers);

    result.fold(
      (failure) => _logger.warning('Failed to load watchlist events', failure),
      (events) {
        emit(WatchlistState.loaded(companies, events: events));
      },
    );
  }

  Future<void> _onSyncRequested(
    SyncRequested event,
    Emitter<WatchlistState> emit,
  ) async {
    final uid = _uid;
    if (uid == null) return;

    try {
      final stream = await _getWatchlistUseCase(uid);
      final result = await stream.first;

      await result.fold(
        (failure) async {
          _logger.warning(
            'Sync skipped: Watchlist fetch failed: ${failure.errorMessage}',
          );
        },
        (companies) => _syncActiveTickers(companies),
      );
    } catch (e, stack) {
      _logger.severe('Sync failed unexpectedly', e, stack);
    }
  }

  Future<void> _syncActiveTickers(List<Company> companies) async {
    final tickers = companies.map((c) => c.ticker).toList();
    final syncResult = await _syncWatchlistUseCase(
      SyncWatchlistParams(activeTickers: tickers),
    );

    syncResult.fold(
      (failure) =>
          _logger.warning('Background sync failed: ${failure.errorMessage}'),
      (_) => _logger.info('Background sync successful'),
    );
  }

  Future<void> _onAddRequested(
    AddRequested event,
    Emitter<WatchlistState> emit,
  ) async {
    final uid = _uidOrEmitFailure(emit);
    if (uid == null) return;

    final result = await _addToWatchlistUseCase(
      AddToWatchlistParams(company: _companyFromEvent(event), uid: uid),
    );

    result.fold(
      (failure) => _emitOperationFailure('add', failure, emit),
      (_) {
        _logger.info("Added ${event.ticker}, waiting for stream update");
        _watchlistAnalytics.logItemAdded(
          ticker: event.ticker,
          companyName: event.name ?? event.ticker,
          tabName: event.tabName ?? 'unknown',
          durationOnPageSeconds: event.durationOnPageSeconds ?? 0,
        );
      },
    );
  }

  Future<void> _onRemoveRequested(
    RemoveRequested event,
    Emitter<WatchlistState> emit,
  ) async {
    final uid = _uidOrEmitFailure(emit);
    if (uid == null) return;

    final result = await _removeFromWatchlistUseCase(
      RemoveFromWatchlistParams(ticker: event.ticker, uid: uid),
    );

    result.fold(
      (failure) => _emitOperationFailure('remove', failure, emit),
      (_) {
        _logger.info("Removed ${event.ticker}, waiting for stream update");
        _watchlistAnalytics.logItemRemoved(
          ticker: event.ticker,
          tabName: event.tabName ?? 'unknown',
          durationOnPageSeconds: event.durationOnPageSeconds ?? 0,
        );
      },
    );
  }
}
