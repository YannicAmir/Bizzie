import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/app_ratings/domain/interfaces/i_app_ratings_repository.dart';
import 'package:bizzie/features/app_ratings/domain/usecases/track_rating_conditions_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppRatingsRepository extends Mock implements IAppRatingsRepository {}

void main() {
  late MockAppRatingsRepository mockRepository;
  late TrackRatingConditionsUseCase useCase;

  setUp(() {
    mockRepository = MockAppRatingsRepository();
    useCase = TrackRatingConditionsUseCase(mockRepository);
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
      when(
        () => mockRepository.incrementInteractionCount(),
      ).thenAnswer((_) async => {});
      when(() => mockRepository.getPromptAttempts()).thenAnswer((_) async => 1);

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Right(false));
      verify(() => mockRepository.getPromptAttempts()).called(1);
      verifyNever(() => mockRepository.getInteractionCount());
    });

    test('call_whenInteractionThresholdNotMet_returnsRightFalse', () async {
      // arrange
      when(
        () => mockRepository.incrementInteractionCount(),
      ).thenAnswer((_) async => {});
      when(() => mockRepository.getPromptAttempts()).thenAnswer((_) async => 0);
      when(
        () => mockRepository.getInteractionCount(),
      ).thenAnswer((_) async => 6);

      // act
      final result = await useCase(NoParams());

      // assert
      expect(result, const Right(false));
      verify(() => mockRepository.getInteractionCount()).called(1);
    });

    test(
      'call_whenConditionsMet_incrementsAttemptsAndReturnsRightTrue',
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
        ).thenAnswer((_) async => 7);
        when(
          () => mockRepository.incrementPromptAttempts(),
        ).thenAnswer((_) async => {});

        // act
        final result = await useCase(NoParams());

        // assert
        expect(result, const Right(true));
        verify(() => mockRepository.incrementPromptAttempts()).called(1);
      },
    );

    test('call_repositoryError_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockRepository.incrementInteractionCount(),
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
