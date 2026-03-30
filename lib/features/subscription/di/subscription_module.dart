import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:injectable/injectable.dart';

/// Provides a `Stream<bool>` of the user's subscription status,
/// derived from the User domain layer's `userStream`.
///
/// This decouples the Subscription feature from the User feature.
/// The Bloc receives a plain `Stream<bool>` and has zero knowledge
/// of `UserModel` or `IUserRepository`.
@module
abstract class SubscriptionModule {
  @Named('isSubscribedStream')
  @lazySingleton
  Stream<bool> isSubscribedStream(IUserRepository userRepository) =>
      userRepository.userStream
          .map((user) => user?.isSubscribed ?? false)
          .distinct()
          .asBroadcastStream();
}
