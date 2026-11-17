import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ListenToNotificationInteractionsUseCase
    implements StreamUseCase<Map<String, dynamic>, NoParams> {
  final INotificationService _notificationService;

  ListenToNotificationInteractionsUseCase(this._notificationService);

  @override
  Stream<Map<String, dynamic>> call(NoParams params) =>
      _notificationService.payloadStream;
}
