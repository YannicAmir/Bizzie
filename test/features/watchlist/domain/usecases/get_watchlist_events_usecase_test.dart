import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/watchlist/domain/interfaces/i_watchlist_events_repository.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_events_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistEventsRepository extends Mock
    implements IWatchlistEventsRepository {}

void main() {
  late GetWatchlistEventsUseCase useCase;
  late MockWatchlistEventsRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistEventsRepository();
    useCase = GetWatchlistEventsUseCase(mockRepository);
  });

  const tTickers = ['AAPL', 'TSLA'];
  final tEvents = <String, WatchlistEventStatus>{};

  group('GetWatchlistEventsUseCase', () {
    test('call_success_returnsEventMapFromRepository', () async {
      // arrange
      when(
        () => mockRepository.getWatchlistEvents(tTickers),
      ).thenAnswer((_) async => Right(tEvents));

      // act
      final result = await useCase(tTickers);

      // assert
      expect(result, Right(tEvents));
      verify(() => mockRepository.getWatchlistEvents(tTickers)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('call_failure_returnsFailureFromRepository', () async {
      // arrange
      const tFailure = Failure.server('Fetch Error');
      when(
        () => mockRepository.getWatchlistEvents(tTickers),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tTickers);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getWatchlistEvents(tTickers)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
