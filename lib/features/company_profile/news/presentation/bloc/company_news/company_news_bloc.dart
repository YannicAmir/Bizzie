import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/news/domain/usecases/get_company_news_usecase.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_event.dart';
import 'package:bizzie/features/company_profile/news/presentation/bloc/company_news/company_news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('CompanyNewsBloc');

@injectable
class CompanyNewsBloc extends Bloc<CompanyNewsEvent, CompanyNewsState> {
  final GetCompanyNewsUseCase _getCompanyNews;

  CompanyNewsBloc(this._getCompanyNews)
    : super(const CompanyNewsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: droppable());
    on<StalenessCheckRequested>(
      _onStalenessCheckRequested,
      transformer: sequential(),
    );
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<CompanyNewsState> emit,
  ) async {
    final isAlreadyLoaded = state.maybeMap(
      loaded: (s) => true,
      orElse: () => false,
    );

    final isRightTicker = state.maybeMap(
      loaded: (s) => s.ticker == event.ticker,
      orElse: () => false,
    );

    if (isAlreadyLoaded && isRightTicker && !event.forceRefresh) {
      _logger.info(
        'Company news already loaded for ${event.ticker} and is the correct ticker. Skipping load (Silent Refresh).',
      );
      return;
    }

    _logger.info(
      'Loading company news for ${event.ticker} (force=${event.forceRefresh})',
    );
    if (!isAlreadyLoaded || !isRightTicker || event.forceRefresh) {
      emit(const CompanyNewsState.loading());
    }

    final result = await _getCompanyNews(event.ticker);

    result.fold(
      (failure) {
        _logger.severe('Failed to load company news', failure);
        emit(CompanyNewsState.failure(failure));
      },
      (tuple) {
        final news = tuple.$1;
        final origin = tuple.$2;
        _logger.info(
          'Successfully loaded company news: ${news.articles.length} articles, origin=$origin',
        );
        emit(
          CompanyNewsState.loaded(
            articles: news.articles,
            ticker: event.ticker,
            dataOrigin: origin,
            lastUpdated: DateTime.now(),
          ),
        );
      },
    );
  }

  Future<void> _onStalenessCheckRequested(
    StalenessCheckRequested event,
    Emitter<CompanyNewsState> emit,
  ) async {
    _logger.info('Staleness check requested for ${event.ticker}');
    state.mapOrNull(
      loaded: (loadedState) {
        final lastUpdated = loadedState.lastUpdated;
        if (lastUpdated != null) {
          final difference = DateTime.now().difference(lastUpdated);
          if (difference.inMinutes >= 5) {
            _logger.info(
              'Company news stale (TTL expired: ${difference.inMinutes}m). Triggering load.',
            );
            add(
              CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true),
            );
          } else {
            _logger.info(
              'Company news still fresh (Last updated: $lastUpdated)',
            );
          }
        } else {
          _logger.info('Company news lastUpdated is null. Triggering load.');
          add(CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true));
        }
      },
      failure: (_) {
        _logger.info('Company news in failure state. Triggering retry.');
        add(CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true));
      },
      initial: (_) {
        _logger.info('Company news in initial state. Triggering load.');
        add(CompanyNewsEvent.loadRequested(event.ticker, forceRefresh: true));
      },
    );
  }
}
