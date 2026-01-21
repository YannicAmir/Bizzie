import 'package:bizzie/features/company_profile/domain/usecases/get_dividend_info_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_dividends/company_dividends_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_dividends/company_dividends_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyDividendsBloc
    extends Bloc<CompanyDividendsEvent, CompanyDividendsState> {
  final GetDividendInfoUseCase _getDividendInfo;

  CompanyDividendsBloc(this._getDividendInfo)
    : super(const CompanyDividendsState.initial()) {
    on<CompanyDividendsEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyDividendsEvent event,
    Emitter<CompanyDividendsState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyDividendsState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      return;
    }

    emit(const CompanyDividendsState.loading());

    final result = await _getDividendInfo(event.ticker);

    result.fold(
      (failure) => emit(CompanyDividendsState.error(failure)),
      (info) =>
          emit(CompanyDividendsState.loaded(info, lastUpdated: DateTime.now())),
    );
  }

  Future<void> _onStalenessCheckRequested(StalenessCheckRequested event) async {
    state.maybeMap(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inHours >= 24) {
            add(
              CompanyDividendsEvent.loadRequested(
                event.ticker,
                forceRefresh: true,
              ),
            );
          }
        } else {
          add(
            CompanyDividendsEvent.loadRequested(
              event.ticker,
              forceRefresh: true,
            ),
          );
        }
      },
      orElse: () {
        state.maybeMap(
          initial: (_) =>
              add(CompanyDividendsEvent.loadRequested(event.ticker)),
          orElse: () {},
        );
      },
    );
  }
}
