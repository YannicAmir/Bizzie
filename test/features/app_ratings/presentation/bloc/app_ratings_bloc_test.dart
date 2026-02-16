import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/app_ratings/domain/usecases/track_rating_conditions_usecase.dart';
import 'package:bizzie/features/app_ratings/presentation/bloc/app_ratings_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTrackRatingConditionsUseCase extends Mock
    implements TrackRatingConditionsUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  late MockTrackRatingConditionsUseCase mockUseCase;
  late AppRatingsBloc bloc;

  setUp(() {
    mockUseCase = MockTrackRatingConditionsUseCase();
    bloc = AppRatingsBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('AppRatingsBloc', () {
    test('initial state should be AppRatingsState.initial', () {
      expect(bloc.state, const AppRatingsState.initial());
    });

    blocTest<AppRatingsBloc, AppRatingsState>(
      'interactionDetected_shouldRequestReview_emitsRequestReviewThenIdle',
      build: () {
        // arrange
        when(
          () => mockUseCase(any()),
        ).thenAnswer((_) async => const Right(true));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const AppRatingsEvent.interactionDetected());
      },
      expect: () => [
        // assert
        const AppRatingsState.requestReview(),
        const AppRatingsState.idle(),
      ],
      verify: (_) {
        verify(() => mockUseCase(any())).called(1);
      },
    );

    blocTest<AppRatingsBloc, AppRatingsState>(
      'interactionDetected_shouldNotRequestReview_emitsIdle',
      build: () {
        // arrange
        when(
          () => mockUseCase(any()),
        ).thenAnswer((_) async => const Right(false));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const AppRatingsEvent.interactionDetected());
      },
      expect: () => [
        // assert
        const AppRatingsState.idle(),
      ],
      verify: (_) {
        verify(() => mockUseCase(any())).called(1);
      },
    );

    blocTest<AppRatingsBloc, AppRatingsState>(
      'interactionDetected_useCaseFailure_emitsIdle',
      build: () {
        // arrange
        when(
          () => mockUseCase(any()),
        ).thenAnswer((_) async => Left(Failure.server('error')));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const AppRatingsEvent.interactionDetected());
      },
      expect: () => [
        // assert
        const AppRatingsState.idle(),
      ],
      verify: (_) {
        verify(() => mockUseCase(any())).called(1);
      },
    );

    blocTest<AppRatingsBloc, AppRatingsState>(
      'interactionDetected_exception_emitsIdle',
      build: () {
        // arrange
        when(() => mockUseCase(any())).thenThrow(Exception('Unexpected error'));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const AppRatingsEvent.interactionDetected());
      },
      expect: () => [
        // assert
        const AppRatingsState.idle(),
      ],
      verify: (_) {
        verify(() => mockUseCase(any())).called(1);
      },
    );
  });
}
