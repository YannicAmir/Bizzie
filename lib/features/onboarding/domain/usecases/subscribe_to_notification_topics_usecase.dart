import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/interfaces/i_notification_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/notification_topics_params.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SubscribeToNotificationTopicsUseCase
    implements UseCase<Either<Failure, void>, NotificationTopicsParams> {
  final INotificationRepository _notificationRepository;

  SubscribeToNotificationTopicsUseCase(this._notificationRepository);

  @override
  Future<Either<Failure, void>> call(NotificationTopicsParams params) async {
    final sectorName = params.sectorName;
    if (sectorName != null) {
      final sectorResult = await _notificationRepository.subscribeToSectorTopic(
        sectorName,
      );
      if (sectorResult.isLeft()) return sectorResult;
    }
    for (final ticker in params.tickers) {
      final tickerResult = await _notificationRepository.subscribeToTickerTopic(
        ticker,
      );
      if (tickerResult.isLeft()) return tickerResult;
    }
    return const Right(null);
  }
}
