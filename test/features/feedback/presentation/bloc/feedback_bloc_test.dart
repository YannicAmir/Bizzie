import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/feedback/domain/usecases/submit_feedback_usecase.dart';
import 'package:bizzie/features/feedback/presentation/analytics/feedback_tracker.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_event.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSubmitFeedbackUseCase extends Mock implements SubmitFeedbackUseCase {}

class MockFeedbackTracker extends Mock implements FeedbackTracker {}

void main() {
  late FeedbackBloc bloc;
  late MockSubmitFeedbackUseCase mockSubmitFeedbackUseCase;
  late MockFeedbackTracker mockTracker;

  setUp(() {
    mockSubmitFeedbackUseCase = MockSubmitFeedbackUseCase();
    mockTracker = MockFeedbackTracker();
    bloc = FeedbackBloc(mockSubmitFeedbackUseCase, mockTracker);

    when(
      () => mockTracker.logFeedbackViewed(
        intentSource: any(named: 'intentSource'),
      ),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.logFeedbackSubmitted(
        messageLength: any(named: 'messageLength'),
      ),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.logFeedbackFailed(error: any(named: 'error')),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.logFeedbackCooldownHit(),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.logFeedbackAbandoned(
        hasTyped: any(named: 'hasTyped'),
        messageLength: any(named: 'messageLength'),
      ),
    ).thenAnswer((_) async => {});
    when(
      () => mockTracker.setTotalFeedbackCount(any()),
    ).thenAnswer((_) async => {});
  });

  tearDown(() {
    bloc.close();
  });

  group('FeedbackBloc', () {
    test('initialState_whenCreated_isInitialState', () {
      // assert
      expect(bloc.state, const FeedbackState.initial(isCoolingDown: false));
    });

    blocTest<FeedbackBloc, FeedbackState>(
      'onFeedbackViewed_whenViewedEventAdded_logsViewedEventWithSource',
      // arrange
      build: () => bloc,
      // act
      act: (bloc) =>
          bloc.add(const FeedbackEvent.viewed(intentSource: 'settings')),
      // assert
      verify: (_) {
        verify(
          () => mockTracker.logFeedbackViewed(intentSource: 'settings'),
        ).called(1);
      },
    );

    blocTest<FeedbackBloc, FeedbackState>(
      'onFeedbackSubmit_whenSubmitEventAddedAndSuccess_emitsStatesAndLogsSuccessAndProperty',
      // arrange
      build: () {
        when(
          () => mockSubmitFeedbackUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => mockTracker.setTotalFeedbackCount(any()),
        ).thenAnswer((_) async => {});
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const FeedbackEvent.submit('Great app!')),
      // assert
      expect: () => [
        const FeedbackState.loading(isCoolingDown: false),
        const FeedbackState.success(isCoolingDown: true),
      ],
      verify: (_) {
        verify(() => mockSubmitFeedbackUseCase('Great app!')).called(1);
        verify(
          () => mockTracker.logFeedbackSubmitted(messageLength: 10),
        ).called(1);
        verify(() => mockTracker.setTotalFeedbackCount(1)).called(1);
      },
    );

    test('close_whenCalledWithoutSuccess_logsAbandonment', () async {
      // arrange
      when(
        () => mockTracker.logFeedbackAbandoned(
          hasTyped: any(named: 'hasTyped'),
          messageLength: any(named: 'messageLength'),
        ),
      ).thenAnswer((_) async => {});

      final testBloc = FeedbackBloc(mockSubmitFeedbackUseCase, mockTracker);
      testBloc.add(const FeedbackEvent.messageChanged('I am typing...'));

      await Future.delayed(Duration.zero);

      // act
      await testBloc.close();

      // assert
      verify(
        () =>
            mockTracker.logFeedbackAbandoned(hasTyped: true, messageLength: 14),
      ).called(1);
    });

    blocTest<FeedbackBloc, FeedbackState>(
      'onFeedbackSubmit_whenSubmitEventAddedAndFailure_emitsLoadingAndFailureAndLogsFailure',
      // arrange
      build: () {
        when(
          () => mockSubmitFeedbackUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('Server Error')));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const FeedbackEvent.submit('Bug report')),
      // assert
      expect: () => [
        const FeedbackState.loading(isCoolingDown: false),
        const FeedbackState.failure(
          Failure.server('Server Error'),
          isCoolingDown: true,
        ),
      ],
      verify: (_) {
        verify(() => mockSubmitFeedbackUseCase('Bug report')).called(1);
        verify(
          () => mockTracker.logFeedbackFailed(error: 'Server Error'),
        ).called(1);
      },
    );

    blocTest<FeedbackBloc, FeedbackState>(
      'onFeedbackSubmit_whenSubmitEventAddedWhileCoolingDown_logsCooldownHitAndDoesNotEmit',
      // arrange
      build: () => bloc,
      seed: () => const FeedbackState.initial(isCoolingDown: true),
      // act
      act: (bloc) => bloc.add(const FeedbackEvent.submit('Spam')),
      // assert
      expect: () => [],
      verify: (_) {
        verify(() => mockTracker.logFeedbackCooldownHit()).called(1);
        verifyNever(() => mockSubmitFeedbackUseCase(any()));
      },
    );

    blocTest<FeedbackBloc, FeedbackState>(
      'onFeedbackMessageChanged_whenMessageChangedEventAddedAndFailure_emitsInitialState',
      // arrange
      build: () => bloc,
      seed: () => const FeedbackState.failure(
        Failure.server('Error'),
        isCoolingDown: false,
      ),
      // act
      act: (bloc) => bloc.add(const FeedbackEvent.messageChanged('New input')),
      // assert
      expect: () => [const FeedbackState.initial(isCoolingDown: false)],
    );

    blocTest<FeedbackBloc, FeedbackState>(
      'onFeedbackMessageChanged_whenMessageChangedEventAddedAndNotFailure_emitsNothing',
      // arrange
      build: () => bloc,
      seed: () => const FeedbackState.initial(),
      // act
      act: (bloc) => bloc.add(const FeedbackEvent.messageChanged('Typing...')),
      // assert
      expect: () => [],
    );
  });
}
