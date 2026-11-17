import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetupNotificationInteractionsUseCase
    implements UseCase<Either<Failure, void>, NoParams> {
  final INotificationService _notificationService;

  SetupNotificationInteractionsUseCase(this._notificationService);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    await _notificationService.setupInteractions();
    return const Right(null);
  }
}
