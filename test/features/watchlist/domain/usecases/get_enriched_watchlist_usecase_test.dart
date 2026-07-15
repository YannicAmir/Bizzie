import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/watchlist/domain/enums/watchlist_badge_type.dart';
import 'package:bizzie/features/watchlist/domain/models/watchlist_event_status.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_enriched_watchlist_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_events_usecase.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWatchlistUseCase extends Mock implements GetWatchlistUseCase {}

class MockGetWatchlistEventsUseCase extends Mock
    implements GetWatchlistEventsUseCase {}

void main() {
  late GetEnrichedWatchlistUseCase useCase;
  late MockGetWatchlistUseCase mockGetWatchlistUseCase;
  late MockGetWatchlistEventsUseCase mockGetWatchlistEventsUseCase;

  setUp(() {
    mockGetWatchlistUseCase = MockGetWatchlistUseCase();
    mockGetWatchlistEventsUseCase = MockGetWatchlistEventsUseCase();
    useCase = GetEnrichedWatchlistUseCase(
      mockGetWatchlistUseCase,
      mockGetWatchlistEventsUseCase,
    );
  });

  const tUid = 'testUid';
  final tCompanies = [
    const Company(ticker: 'AAPL', name: 'Apple'),
    const Company(ticker: 'TSLA', name: 'Tesla'),
  ];
  final tTickers = ['AAPL', 'TSLA'];
  final tEvents = {
    'AAPL': WatchlistEventStatus(
      badgeText: 'Earnings',
      badgeType: WatchlistBadgeType.neutral,
      eventDate: DateTime.now(),
      lastUpdated: DateTime.now(),
    ),
  };

  group('GetEnrichedWatchlistUseCase', () {
    test('call_fetchSuccess_emitsEnrichedData', () async {
      // arrange
      when(
        () => mockGetWatchlistUseCase(tUid),
      ).thenAnswer((_) async => Stream.value(Right(tCompanies)));
      when(
        () => mockGetWatchlistEventsUseCase(tTickers),
      ).thenAnswer((_) async => Right(tEvents));

      // act
      final result = useCase(tUid);

      // assert
      await expectLater(
        result,
        emits(
          isA<
                Right<
                  Failure,
                  (List<Company>, Map<String, WatchlistEventStatus>)
                >
              >()
              .having((r) => r.value.$1, 'companies', tCompanies)
              .having((r) => r.value.$2, 'events', tEvents),
        ),
      );
      verify(() => mockGetWatchlistUseCase(tUid)).called(1);
      verify(() => mockGetWatchlistEventsUseCase(tTickers)).called(1);
    });

    test('call_eventsFetchFailure_emitsCompaniesWithEmptyEvents', () async {
      // arrange
      when(
        () => mockGetWatchlistUseCase(tUid),
      ).thenAnswer((_) async => Stream.value(Right(tCompanies)));
      when(
        () => mockGetWatchlistEventsUseCase(tTickers),
      ).thenAnswer((_) async => Left(Failure.server('Fetch Error')));

      // act
      final result = useCase(tUid);

      // assert
      await expectLater(
        result,
        emits(
          isA<
                Right<
                  Failure,
                  (List<Company>, Map<String, WatchlistEventStatus>)
                >
              >()
              .having((r) => r.value.$1, 'companies', tCompanies)
              .having((r) => r.value.$2, 'events', isEmpty),
        ),
      );
      verify(() => mockGetWatchlistUseCase(tUid)).called(1);
      verify(() => mockGetWatchlistEventsUseCase(tTickers)).called(1);
    });

    test('call_watchlistFailure_emitsFailure', () async {
      // arrange
      const tFailure = Failure.server('Watchlist Error');
      when(
        () => mockGetWatchlistUseCase(tUid),
      ).thenAnswer((_) async => Stream.value(const Left(tFailure)));

      // act
      final result = useCase(tUid);

      // assert
      await expectLater(result, emits(const Left(tFailure)));
      verify(() => mockGetWatchlistUseCase(tUid)).called(1);
      verifyZeroInteractions(mockGetWatchlistEventsUseCase);
    });

    test('call_streamUpdates_triggersNewEventFetch', () async {
      // arrange
      final secondCompanies = [
        const Company(ticker: 'AAPL', name: 'Apple'),
        const Company(ticker: 'MSFT', name: 'Microsoft'),
      ];
      when(() => mockGetWatchlistUseCase(tUid)).thenAnswer(
        (_) async =>
            Stream.fromIterable([Right(tCompanies), Right(secondCompanies)]),
      );
      when(
        () => mockGetWatchlistEventsUseCase(any()),
      ).thenAnswer((_) async => const Right({}));

      // act
      final result = useCase(tUid);

      // assert
      await expectLater(result, emitsInOrder([isA<Right>(), isA<Right>()]));
      verify(() => mockGetWatchlistUseCase(tUid)).called(1);
      verify(() => mockGetWatchlistEventsUseCase(tTickers)).called(1);
      verify(() => mockGetWatchlistEventsUseCase(['AAPL', 'MSFT'])).called(1);
    });
  });
}
