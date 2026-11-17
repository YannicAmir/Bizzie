import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_view_history_repository.dart';
import 'package:bizzie/features/reports/domain/usecases/get_seen_weekly_report_ids_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportsViewHistoryRepository extends Mock
    implements IReportsViewHistoryRepository {}

void main() {
  late GetSeenWeeklyReportIdsUseCase sut;
  late MockReportsViewHistoryRepository mockRepository;

  setUp(() {
    mockRepository = MockReportsViewHistoryRepository();
    sut = GetSeenWeeklyReportIdsUseCase(mockRepository);
  });

  group('GetSeenWeeklyReportIdsUseCase', () {
    test('call_repositoryReturnsRight_returnsRight', () {
      // arrange
      when(
        () => mockRepository.getSeenWeeklyReportIds(),
      ).thenReturn(const Right({'AAPL_2026-01-01'}));

      // act
      final result = sut();

      // assert
      expect(result, const Right<Failure, Set<String>>({'AAPL_2026-01-01'}));
    });

    test('call_repositoryReturnsLeft_returnsLeft', () {
      // arrange
      when(
        () => mockRepository.getSeenWeeklyReportIds(),
      ).thenReturn(const Left(Failure.cache('Error')));

      // act
      final result = sut();

      // assert
      expect(result, const Left<Failure, Set<String>>(Failure.cache('Error')));
    });
  });
}
