import 'package:bizzie/features/subscription/data/dtos/sync_subscription_response_dto.dart';

abstract class IFirebaseFunctionsService {
  Future<SyncSubscriptionResponseDto> syncUserSubscription();
}
