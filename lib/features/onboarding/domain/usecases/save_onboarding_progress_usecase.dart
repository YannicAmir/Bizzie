import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_save_outcome.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/save_onboarding_progress_result.dart';
import 'package:bizzie/features/onboarding/domain/services/guest_username_generator.dart';
import 'package:bizzie/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/resolve_onboarding_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveOnboardingProgressUseCase
    implements
        UseCase<Either<Failure, SaveOnboardingProgressResult>, OnboardingData> {
  final ResolveOnboardingUserUseCase _resolveOnboardingUserUseCase;
  final GuestUsernameGenerator _usernameGenerator;
  final CompleteOnboardingUseCase _completeOnboardingUseCase;

  SaveOnboardingProgressUseCase(
    this._resolveOnboardingUserUseCase,
    this._usernameGenerator,
    this._completeOnboardingUseCase,
  );

  @override
  Future<Either<Failure, SaveOnboardingProgressResult>> call(
    OnboardingData data,
  ) async {
    final userResult = await _resolveOnboardingUserUseCase(NoParams());
    return userResult.fold(Left.new, (user) => _save(data, user.id));
  }

  Future<Either<Failure, SaveOnboardingProgressResult>> _save(
    OnboardingData data,
    String uid,
  ) async {
    final saveResult = await _completeOnboardingUseCase(
      CompleteOnboardingParams(
        data: data.copyWith(
          firstName: _usernameGenerator.resolveName(data.firstName),
        ),
        uid: uid,
        awaitServerAck: false,
        deferNotificationSetup: true,
      ),
    );
    return saveResult.map(
      (outcome) => switch (outcome) {
        OnboardingSaveOutcome.saved => SaveOnboardingProgressResult.saved(
          uid: uid,
        ),
        OnboardingSaveOutcome.existingProfile =>
          const SaveOnboardingProgressResult.existingProfile(),
      },
    );
  }
}
