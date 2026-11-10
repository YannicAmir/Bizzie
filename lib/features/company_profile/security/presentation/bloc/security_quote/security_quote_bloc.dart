import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_session_reset_mixin.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/watch_security_quote_usecase.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/security_quote/security_quote_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/security_quote/security_quote_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SecurityQuoteBloc');

@injectable
class SecurityQuoteBloc extends Bloc<SecurityQuoteEvent, SecurityQuoteState>
    with AuthSessionResetMixin<SecurityQuoteEvent, SecurityQuoteState> {
  final WatchSecurityQuoteUseCase _watchSecurityQuote;

  SecurityQuoteBloc(this._watchSecurityQuote, GetAuthStream getAuthStream)
    : super(const SecurityQuoteState.initial()) {
    on<SecurityQuoteEvent>(
      (event, emit) => event.map(
        loadRequested: (e) => _onLoadRequested(e, emit),
        reset: (e) async => _onReset(e, emit),
      ),
      transformer: restartable(),
    );
    resetOnSessionEnd(getAuthStream, const SecurityQuoteEvent.reset());
  }

  bool get _hasLoadedQuote =>
      state.maybeMap(loaded: (_) => true, orElse: () => false);

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<SecurityQuoteState> emit,
  ) async {
    _logger.info('Watching quote for ${event.ticker}');
    emit(const SecurityQuoteState.loading());
    await _watchQuote(event.ticker, emit);
  }

  Future<void> _watchQuote(String ticker, Emitter<SecurityQuoteState> emit) {
    return emit.forEach<Either<Failure, SecurityQuote?>>(
      _watchSecurityQuote(ticker),
      onData: (result) => result.fold(
        _stateForFailure,
        (quote) => _stateForQuote(ticker, quote),
      ),
      onError: (error, stack) {
        _logger.severe('Security quote stream error', error, stack);
        return _stateForFailure(Failure.server(error.toString()));
      },
    );
  }

  SecurityQuoteState _stateForQuote(String ticker, SecurityQuote? quote) {
    if (quote == null) {
      _logger.info('No live quote available for $ticker');
      return const SecurityQuoteState.unavailable();
    }
    return SecurityQuoteState.loaded(quote);
  }

  SecurityQuoteState _stateForFailure(Failure failure) {
    _logger.warning('Failed to load quote: ${failure.errorMessage}');
    return _hasLoadedQuote ? state : SecurityQuoteState.failure(failure);
  }

  void _onReset(Reset event, Emitter<SecurityQuoteState> emit) =>
      emit(const SecurityQuoteState.initial());
}
