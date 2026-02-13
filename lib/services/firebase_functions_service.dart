import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/interfaces/i_firebase_functions_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/subscription/data/dtos/sync_subscription_response_dto.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('FirebaseFunctionsService');

@LazySingleton(as: IFirebaseFunctionsService)
class FirebaseFunctionsService implements IFirebaseFunctionsService {
  final FirebaseFunctions _functions;

  FirebaseFunctionsService(this._functions);

  @override
  Future<SyncSubscriptionResponseDto> syncUserSubscription() async {
    const functionName = 'syncUserSubscription';
    const timeout = Duration(seconds: 30);

    _logger.info('Starting $functionName (timeout: ${timeout.inSeconds}s)...');
    try {
      final result = await _functions
          .httpsCallable(
            functionName,
            options: HttpsCallableOptions(timeout: timeout),
          )
          .call<Map<String, dynamic>>();

      final dto = SyncSubscriptionResponseDto.fromJson(result.data);

      _logger.info(
        '$functionName complete: active=${dto.active}, status=${dto.status ?? 'N/A'}',
      );

      return dto;
    } on FirebaseFunctionsException catch (e, s) {
      _logger.severe(
        '$functionName failed: code=${e.code}, message=${e.message}',
        e,
        s,
      );
      throw ServerException(message: e.message ?? 'Cloud function error');
    } catch (e, s) {
      _logger.severe('$functionName unexpected error', e, s);
      throw ServerException(message: e.toString());
    }
  }
}
