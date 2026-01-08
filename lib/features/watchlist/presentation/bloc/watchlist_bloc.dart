import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/watchlist/domain/usecases/add_to_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/remove_from_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/sync_watchlist_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

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
    on<WatchlistEvent>((event, emit) async {
      await event.map(
        syncRequested: (_) => _onSyncRequested(emit),
        addRequested: (e) => _onAddRequested(e.company, emit),
        removeRequested: (e) => _onRemoveRequested(e.ticker, emit),
        loadRequested: (_) => _onLoadRequested(emit),
      );
    });
  }

  String? get _uid => _authRepository.currentUser?.id;

  Future<void> _onLoadRequested(Emitter<WatchlistState> emit) async {
    final uid = _uid;
    if (uid == null) {
      emit(const WatchlistState.failure("User not authenticated"));
      return;
    }

    emit(const WatchlistState.loading());

    final stream = await _getWatchlistUseCase(uid);

    await emit.forEach(
      stream,
      onData: (result) => result.fold(
        (failure) => WatchlistState.failure(failure.message),
        (companies) => WatchlistState.loaded(companies),
      ),
      onError: (error, stack) {
        _logger.severe('Watchlist stream error', error, stack);
        return WatchlistState.failure("Stream Error: $error");
      },
    );
  }

  Future<void> _onSyncRequested(Emitter<WatchlistState> emit) async {
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
    Company company,
    Emitter<WatchlistState> emit,
  ) async {
    final uid = _uid;
    if (uid == null) {
      emit(const WatchlistState.failure("User not authenticated"));
      return;
    }

    final result = await _addToWatchlistUseCase(
      AddToWatchlistParams(company: company, uid: uid),
    );

    result.fold((failure) => emit(WatchlistState.failure(failure.message)), (
      _,
    ) {
      _logger.info("Added ${company.ticker}, waiting for stream update");
    });
  }

  Future<void> _onRemoveRequested(
    String ticker,
    Emitter<WatchlistState> emit,
  ) async {
    final uid = _uid;
    if (uid == null) {
      emit(const WatchlistState.failure("User not authenticated"));
      return;
    }

    final result = await _removeFromWatchlistUseCase(
      RemoveFromWatchlistParams(ticker: ticker, uid: uid),
    );

    result.fold((failure) => emit(WatchlistState.failure(failure.message)), (
      _,
    ) {
      _logger.info("Removed $ticker, waiting for stream update");
    });
  }
}
