import 'dart:async';

import 'package:bizzie/features/company_profile/domain/usecases/get_business_profile_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_business/company_business_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_business/company_business_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyBusinessBloc
    extends Bloc<CompanyBusinessEvent, CompanyBusinessState> {
  final GetBusinessProfileUseCase _getBusinessProfileUseCase;

  CompanyBusinessBloc(this._getBusinessProfileUseCase)
    : super(const CompanyBusinessState.initial()) {
    on<CompanyBusinessEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyBusinessEvent event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyBusinessState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      return;
    }

    emit(const CompanyBusinessState.loading());

    final result = await _getBusinessProfileUseCase(event.ticker);

    result.fold(
      (failure) => emit(CompanyBusinessState.failure(failure)),
      (profile) => emit(
        CompanyBusinessState.loaded(profile, lastUpdated: DateTime.now()),
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
              CompanyBusinessEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          }
        }
      },
      failure: (_) => add(
        CompanyBusinessEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
      initial: (_) => add(
        CompanyBusinessEvent.loadRequested(event.ticker, forceRefresh: true),
      ),
    );
  }
}
