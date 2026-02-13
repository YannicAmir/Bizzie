import 'package:bizzie/core/interfaces/i_firebase_functions_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('FirebaseFunctionsService');

@LazySingleton(as: IFirebaseFunctionsService)
class FirebaseFunctionsService implements IFirebaseFunctionsService {
  final FirebaseFunctions _functions;

  FirebaseFunctionsService(this._functions);

  @override
  Future<Map<String, dynamic>> syncUserSubscription() async {
    _logger.info('Calling syncUserSubscription callable...');
    try {
      final result = await _functions
          .httpsCallable(
            'syncUserSubscription',
            options: HttpsCallableOptions(timeout: const Duration(seconds: 30)),
          )
          .call<Map<String, dynamic>>();

      _logger.info(
        'syncUserSubscription returned: active=${result.data['active']}',
      );
      return result.data;
    } on FirebaseFunctionsException catch (e, s) {
      _logger.severe('syncUserSubscription failed with code=${e.code}', e, s);
      rethrow;
    } catch (e, s) {
      _logger.severe('syncUserSubscription unexpected error', e, s);
      rethrow;
    }
  }
}
