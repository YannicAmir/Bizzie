import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// TODO: Implement actual notification service
@lazySingleton
class ToggleNotificationsUseCase {
  final INotificationService _notificationService;

  ToggleNotificationsUseCase(this._notificationService);

  Future<Either<Failure, void>> call(bool enable) async {
    // This is a placeholder logic as the NotificationService
    // typically manages this via OS settings or topic subscription.
    // For now we assume enabling means subscribing to general topics.
    try {
      if (enable) {
        await _notificationService.subscribeToTopic('general');
      } else {
        await _notificationService.unsubscribeFromTopic('general');
      }
      return const Right(null);
    } catch (e) {
      return Left(Failure.server(e.toString()));
    }
  }
}
