import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/watchlist/domain/usecases/add_to_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/remove_from_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/sync_watchlist_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
  final AddToWatchlistUseCase _addToWatchlistUseCase;
  final RemoveFromWatchlistUseCase _removeFromWatchlistUseCase;
  final SyncWatchlistUseCase _syncWatchlistUseCase;
  final IAuthRepository _authRepository;

  WatchlistBloc(
    this._getWatchlistUseCase,
    this._addToWatchlistUseCase,
    this._removeFromWatchlistUseCase,
    this._syncWatchlistUseCase,
    this._authRepository,
  ) : super(const WatchlistState.initial()) {
    on<SyncRequested>(_onSyncRequested);
    on<AddRequested>(_onAddRequested);
    on<RemoveRequested>(_onRemoveRequested);
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
    on<Reset>(_onReset);
  }

  void _onReset(Reset event, Emitter<WatchlistState> emit) {
    _logger.info('Resetting WatchlistBloc');
    emit(const WatchlistState.initial());
  }

  String? get _uid => _authRepository.currentUser?.id;

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<WatchlistState> emit,
  ) async {
    final uid = _uid;
    if (uid == null) {
      emit(const WatchlistState.failure("User not authenticated"));
      return;
    }

    emit(const WatchlistState.loading());

    final stream = await _getWatchlistUseCase(uid);

    await emit.forEach(
      stream,
      onData: (result) {
        return result.fold(
          (failure) => WatchlistState.failure(failure.message),
          (companies) => WatchlistState.loaded(companies),
        );
      },
      onError: (error, stack) {
        _logger.severe('Watchlist stream error', error, stack);
        return WatchlistState.failure('Stream Error');
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
            'Sync skipped: Watchlist fetch failed: ${failure.message}',
          );
        },
        (companies) async {
          final tickers = companies.map((c) => c.ticker).toList();
          final syncResult = await _syncWatchlistUseCase(
            SyncWatchlistParams(activeTickers: tickers),
          );

          syncResult.fold(
            (failure) =>
                _logger.warning('Background sync failed: ${failure.message}'),
            (_) => _logger.info('Background sync successful'),
          );
        },
      );
    } catch (e, stack) {
      _logger.severe('Sync failed unexpectedly', e, stack);
    }
  }

  Future<void> _onAddRequested(
    AddRequested event,
    Emitter<WatchlistState> emit,
  ) async {
    final uid = _uid;
    if (uid == null) {
      emit(const WatchlistState.failure("User not authenticated"));
      return;
    }

    final company = Company(
      ticker: event.ticker,
      name: event.name ?? event.ticker,
    );

    final result = await _addToWatchlistUseCase(
      AddToWatchlistParams(company: company, uid: uid),
    );

    result.fold((failure) => emit(WatchlistState.failure(failure.message)), (
      _,
    ) {
      _logger.info("Added ${event.ticker}, waiting for stream update");
    });
  }

  Future<void> _onRemoveRequested(
    RemoveRequested event,
    Emitter<WatchlistState> emit,
  ) async {
    final uid = _uid;
    if (uid == null) {
      emit(const WatchlistState.failure("User not authenticated"));
      return;
    }

    final result = await _removeFromWatchlistUseCase(
      RemoveFromWatchlistParams(ticker: event.ticker, uid: uid),
    );

    result.fold((failure) => emit(WatchlistState.failure(failure.message)), (
      _,
    ) {
      _logger.info("Removed ${event.ticker}, waiting for stream update");
    });
  }
}
