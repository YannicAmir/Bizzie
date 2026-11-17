import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/onboarding/domain/enums/onboarding_save_outcome.dart';
import 'package:bizzie/features/onboarding/domain/interfaces/i_onboarding_repository.dart';
import 'package:bizzie/features/onboarding/domain/models/complete_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/initial_company_selection.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_field_sources.dart';
import 'package:bizzie/features/onboarding/domain/models/post_onboarding_destination.dart';
import 'package:bizzie/features/onboarding/domain/models/resolved_onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/skip_onboarding_params.dart';
import 'package:bizzie/features/onboarding/domain/models/skip_onboarding_result.dart';
import 'package:bizzie/features/onboarding/domain/services/initial_company_resolver.dart';
import 'package:bizzie/features/onboarding/domain/services/skipped_onboarding_data_resolver.dart';
import 'package:bizzie/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:bizzie/features/onboarding/domain/usecases/resolve_onboarding_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SkipOnboardingUseCase
    implements
        UseCase<Either<Failure, SkipOnboardingResult>, SkipOnboardingParams> {
  final ResolveOnboardingUserUseCase _resolveOnboardingUserUseCase;
  final IOnboardingRepository _onboardingRepository;
  final SkippedOnboardingDataResolver _dataResolver;
  final CompleteOnboardingUseCase _completeOnboardingUseCase;
  final InitialCompanyResolver _initialCompanyResolver;

  SkipOnboardingUseCase(
    this._resolveOnboardingUserUseCase,
    this._onboardingRepository,
    this._dataResolver,
    this._completeOnboardingUseCase,
    this._initialCompanyResolver,
  );

  @override
  Future<Either<Failure, SkipOnboardingResult>> call(
    SkipOnboardingParams params,
  ) async {
    final userResult = await _resolveOnboardingUserUseCase(NoParams());
    return userResult.fold(Left.new, (user) => _persist(params, user.id));
  }

  Future<Either<Failure, SkipOnboardingResult>> _persist(
    SkipOnboardingParams params,
    String uid,
  ) {
    return params.hasExistingProfile
        ? _updateExistingProfile(params, uid)
        : _createProfile(params, uid);
  }

  Future<Either<Failure, SkipOnboardingResult>> _createProfile(
    SkipOnboardingParams params,
    String uid,
  ) async {
    final data = params.data;
    final defaultsResult = await _onboardingRepository.getSkipDefaults();
    return defaultsResult.fold(
      Left.new,
      (defaults) => _save(
        params,
        uid: uid,
        resolved: _dataResolver.resolve(data: data, defaults: defaults),
        initialCompany: _initialCompanyResolver.resolve(
          userSelectedCompanies: data.detectedCompanies,
          defaults: defaults,
        ),
      ),
    );
  }

  Future<Either<Failure, SkipOnboardingResult>> _updateExistingProfile(
    SkipOnboardingParams params,
    String uid,
  ) async {
    final data = params.data;
    final initialCompanyResult = await _initialCompanyFor(
      data.detectedCompanies,
    );
    return initialCompanyResult.fold(
      Left.new,
      (initialCompany) => _save(
        params,
        uid: uid,
        resolved: _dataResolver.unresolved(data),
        initialCompany: initialCompany,
      ),
    );
  }

  Future<Either<Failure, InitialCompanySelection>> _initialCompanyFor(
    List<Company> userSelectedCompanies,
  ) async {
    final userSelection = _initialCompanyResolver.fromUserSelection(
      userSelectedCompanies,
    );
    if (userSelection != null) return Right(userSelection);

    final defaultsResult = await _onboardingRepository.getSkipDefaults();
    return defaultsResult.map(_initialCompanyResolver.fromDefaults);
  }

  Future<Either<Failure, SkipOnboardingResult>> _save(
    SkipOnboardingParams params, {
    required String uid,
    required ResolvedOnboardingData resolved,
    required InitialCompanySelection initialCompany,
  }) async {
    final saveResult = await _completeOnboardingUseCase(
      CompleteOnboardingParams(
        data: resolved.data,
        uid: uid,
        awaitServerAck: false,
        deferNotificationSetup: true,
        hasExistingProfile: params.hasExistingProfile,
      ),
    );

    return saveResult.fold(
      Left.new,
      (outcome) => switch (outcome) {
        OnboardingSaveOutcome.saved => Right(
          _buildResult(params.data, resolved.sources, initialCompany),
        ),
        OnboardingSaveOutcome.existingProfile => const Right(
          SkipOnboardingResult.existingProfile(),
        ),
      },
    );
  }

  SkipOnboardingResult _buildResult(
    OnboardingData data,
    OnboardingFieldSources fieldSources,
    InitialCompanySelection initialCompany,
  ) {
    return SkipOnboardingResult.completed(
      destination: PostOnboardingDestination(
        ticker: initialCompany.ticker,
        tickerSource: initialCompany.source,
        shouldPromptNotifications: !data.hasDecidedNotifications,
        shouldPersistNotificationGrant:
            data.hasDecidedNotifications && data.notificationsEnabled,
      ),
      fieldSources: fieldSources,
    );
  }
}
