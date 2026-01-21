import 'package:bizzie/features/company_profile/domain/usecases/get_company_news_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_news/company_news_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_news/company_news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyNewsBloc extends Bloc<CompanyNewsEvent, CompanyNewsState> {
  final GetCompanyNewsUseCase _getCompanyNews;

  CompanyNewsBloc(this._getCompanyNews)
    : super(const CompanyNewsState.initial()) {
    on<CompanyNewsEvent>(_onEvent, transformer: droppable());
  }

  Future<void> _onEvent(
    CompanyNewsEvent event,
    Emitter<CompanyNewsState> emit,
  ) async {
    await event.map(
      loadRequested: (e) async => _onLoadRequested(e, emit),
      stalenessCheckRequested: (e) async => _onStalenessCheckRequested(e),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyNewsState> emit,
  ) async {
    if (!event.forceRefresh &&
        state.maybeMap(loaded: (_) => true, orElse: () => false)) {
      return;
    }

    emit(const CompanyNewsState.loading());

    final result = await _getCompanyNews(event.ticker);

    result.fold(
      (failure) => emit(CompanyNewsState.failure(failure)),
      (news) => emit(
        CompanyNewsState.loaded(news.articles, lastUpdated: DateTime.now()),
      ),
    );
  }

  Future<void> _onStalenessCheckRequested(StalenessCheckRequested event) async {
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inMinutes >= 5) {
            add(
              CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          }
        }
      },
      failure: (_) =>
          add(CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true)),
      initial: (_) =>
          add(CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true)),
    );
  }
}
