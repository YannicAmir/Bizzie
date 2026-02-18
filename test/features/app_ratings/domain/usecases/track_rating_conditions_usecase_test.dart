import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/app_ratings/domain/interfaces/i_app_ratings_repository.dart';
import 'package:bizzie/features/app_ratings/domain/usecases/track_rating_conditions_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppRatingsRepository extends Mock implements IAppRatingsRepository {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late MockAppRatingsRepository mockRepository;
  late MockConfigService mockConfigService;
  late TrackRatingConditionsUseCase useCase;

  setUp(() {
    mockRepository = MockAppRatingsRepository();
    mockConfigService = MockConfigService();
    useCase = TrackRatingConditionsUseCase(mockRepository, mockConfigService);
    when(() => mockConfigService.reviewPromptEventCount).thenReturn(3);
  });

  group('TrackRatingConditionsUseCase', () {
    test(
      'call_alwaysIncrementsInteractionCount_verifiesInteractionIncrement',
      () async {
        // arrange
        when(
          () => mockRepository.incrementInteractionCount(),
        ).thenAnswer((_) async => {});
        when(
          () => mockRepository.getPromptAttempts(),
        ).thenAnswer((_) async => 0);
        when(
          () => mockRepository.getInteractionCount(),
        ).thenAnswer((_) async => 1);

        // act
        await useCase(NoParams());

        // assert
        verify(() => mockRepository.incrementInteractionCount()).called(1);
      },
    );

    test('call_whenMaxAttemptsReached_returnsRightFalse', () async {
      // arrange
      when(() => mockRepository.getPromptAttempts()).thenAnswer((_) async => 1);

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Right(false));
      verify(() => mockRepository.getPromptAttempts()).called(1);
      verifyNever(() => mockRepository.incrementInteractionCount());
      verifyNever(() => mockRepository.getInteractionCount());
    });

    test('call_whenInteractionThresholdNotMet_returnsRightFalse', () async {
      // arrange
      const threshold = 5;
      when(
        () => mockConfigService.reviewPromptEventCount,
      ).thenReturn(threshold);
      when(() => mockRepository.getPromptAttempts()).thenAnswer((_) async => 0);
      when(
        () => mockRepository.incrementInteractionCount(),
      ).thenAnswer((_) async => {});
      when(
        () => mockRepository.getInteractionCount(),
      ).thenAnswer((_) async => threshold - 1);

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Right(false));
      verify(() => mockRepository.getPromptAttempts()).called(1);
      verify(() => mockRepository.getInteractionCount()).called(1);
    });

    test(
      'call_whenConditionsMet_incrementsAttemptsAndReturnsRightTrue',
      () async {
        // arrange
        const threshold = 5;
        when(
          () => mockConfigService.reviewPromptEventCount,
        ).thenReturn(threshold);
        when(
          () => mockRepository.getPromptAttempts(),
        ).thenAnswer((_) async => 0);
        when(
          () => mockRepository.incrementInteractionCount(),
        ).thenAnswer((_) async => {});
        when(
          () => mockRepository.getInteractionCount(),
        ).thenAnswer((_) async => threshold);
        when(
          () => mockRepository.incrementPromptAttempts(),
        ).thenAnswer((_) async => {});

        // act
        final result = await useCase(NoParams());

        // assert
        expect(result, const Right(true));
        verify(() => mockRepository.getPromptAttempts()).called(1);
        verify(() => mockRepository.incrementPromptAttempts()).called(1);
      },
    );

    test('call_repositoryError_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockRepository.getPromptAttempts(),
      ).thenThrow(Exception('Storage error'));

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, isA<Left<Failure, bool>>());
      result.fold(
        (failure) => expect(failure.message, contains('Storage error')),
        (_) => fail('Should have returned Left'),
      );
    });
  });
}
