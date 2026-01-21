import 'dart:async';

import 'package:bizzie/features/company_profile/domain/usecases/get_security_details_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_security/company_security_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_security/company_security_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:bloc_concurrency/bloc_concurrency.dart';

@injectable
class CompanySecurityBloc
    extends Bloc<CompanySecurityEvent, CompanySecurityState> {
  final GetSecurityDetailsUseCase _getSecurityDetailsUseCase;

  CompanySecurityBloc(this._getSecurityDetailsUseCase)
    : super(const CompanySecurityState.initial()) {
    on<CompanySecurityEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanySecurityEvent event,
    Emitter<CompanySecurityState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanySecurityState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      return;
    }

    emit(const CompanySecurityState.loading());

    final result = await _getSecurityDetailsUseCase(event.ticker);

    result.fold(
      (failure) => emit(CompanySecurityState.failure(failure)),
      (details) => emit(
        CompanySecurityState.loaded(details, lastUpdated: DateTime.now()),
      ),
    );
  }

  Future<void> _onStalenessCheckRequested(StalenessCheckRequested event) async {
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            add(
              CompanySecurityEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          }
        }
      },
      failure: (_) => add(
        CompanySecurityEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
      initial: (_) => add(
        CompanySecurityEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
    );
  }
}
