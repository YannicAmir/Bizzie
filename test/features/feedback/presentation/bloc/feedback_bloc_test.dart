import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/feedback/domain/usecases/submit_feedback_usecase.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_event.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSubmitFeedbackUseCase extends Mock implements SubmitFeedbackUseCase {}

void main() {
  late FeedbackBloc bloc;
  late MockSubmitFeedbackUseCase mockSubmitFeedbackUseCase;

  setUp(() {
    mockSubmitFeedbackUseCase = MockSubmitFeedbackUseCase();
    bloc = FeedbackBloc(mockSubmitFeedbackUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('FeedbackBloc', () {
    test('initial state is FeedbackState.initial', () {
      expect(bloc.state, const FeedbackState.initial(isCoolingDown: false));
    });

    blocTest<FeedbackBloc, FeedbackState>(
      'emits [loading, success] when Submit is added and usecase returns success',
      build: () {
        when(
          () => mockSubmitFeedbackUseCase(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(const FeedbackEvent.submit('Great app!')),
      expect: () => [
        const FeedbackState.loading(isCoolingDown: false),
        const FeedbackState.success(isCoolingDown: true),
      ],
      verify: (_) {
        verify(() => mockSubmitFeedbackUseCase('Great app!')).called(1);
      },
    );

    blocTest<FeedbackBloc, FeedbackState>(
      'emits [loading, failure] when Submit is added and usecase returns failure',
      build: () {
        when(
          () => mockSubmitFeedbackUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('Server Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const FeedbackEvent.submit('Bug report')),
      expect: () => [
        const FeedbackState.loading(isCoolingDown: false),
        const FeedbackState.failure(
          Failure.server('Server Error'),
          isCoolingDown: true,
        ),
      ],
      verify: (_) {
        verify(() => mockSubmitFeedbackUseCase('Bug report')).called(1);
      },
    );

    blocTest<FeedbackBloc, FeedbackState>(
      'emits [initial] when MessageChanged is added and current state is failure',
      build: () => bloc,
      seed: () => const FeedbackState.failure(
        Failure.server('Error'),
        isCoolingDown: false,
      ),
      act: (bloc) => bloc.add(const FeedbackEvent.messageChanged('New input')),
      expect: () => [const FeedbackState.initial(isCoolingDown: false)],
    );

    blocTest<FeedbackBloc, FeedbackState>(
      'does NOT emit initial when MessageChanged is added and current state is NOT failure',
      build: () => bloc,
      seed: () => const FeedbackState.initial(),
      act: (bloc) => bloc.add(const FeedbackEvent.messageChanged('Typing...')),
      expect: () => [],
    );
  });
}
