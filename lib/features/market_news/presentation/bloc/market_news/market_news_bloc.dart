import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:bizzie/features/market_news/domain/usecases/watch_market_news_usecase.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'market_news_event.dart';
part 'market_news_state.dart';
part 'market_news_bloc.freezed.dart';

final _logger = BizzieLogger('MarketNewsBloc');

@injectable
class MarketNewsBloc extends Bloc<MarketNewsEvent, MarketNewsState> {
  final WatchMarketNewsUseCase _watchMarketNews;

  MarketNewsBloc(this._watchMarketNews)
    : super(const MarketNewsState.initial()) {
    on<LoadRequested>(_onLoadRequested, transformer: restartable());
  }

  Future<void> _onLoadRequested(
    LoadRequested event,
    Emitter<MarketNewsState> emit,
  ) async {
    _logger.info('Loading general market news');
    emit(const MarketNewsState.loading());

    await emit.forEach<Either<Failure, List<MarketNewsArticle>>>(
      _watchMarketNews(NoParams()),
      onData: (result) => result.fold(
        (failure) => MarketNewsState.failure(failure),
        (articles) => MarketNewsState.loaded(articles),
      ),
      onError: (error, stack) {
        _logger.severe('Market news stream error', error, stack);
        return MarketNewsState.failure(
          Failure.server('Unable to load market news'),
        );
      },
    );
  }
}
