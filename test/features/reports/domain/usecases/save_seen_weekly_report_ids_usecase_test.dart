import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_view_history_repository.dart';
import 'package:bizzie/features/reports/domain/usecases/save_seen_weekly_report_ids_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportsViewHistoryRepository extends Mock
    implements IReportsViewHistoryRepository {}

const tIds = {'AAPL_2026-01-01'};

void main() {
  late SaveSeenWeeklyReportIdsUseCase sut;
  late MockReportsViewHistoryRepository mockRepository;

  setUp(() {
    mockRepository = MockReportsViewHistoryRepository();
    sut = SaveSeenWeeklyReportIdsUseCase(mockRepository);
  });

  group('SaveSeenWeeklyReportIdsUseCase', () {
    test('call_repositoryReturnsRight_returnsRight', () async {
      // arrange
      when(
        () => mockRepository.saveSeenWeeklyReportIds(tIds),
      ).thenAnswer((_) async => const Right(unit));

      // act
      final result = await sut(tIds);

      // assert
      expect(result, const Right<Failure, Unit>(unit));
      verify(() => mockRepository.saveSeenWeeklyReportIds(tIds)).called(1);
    });

    test('call_repositoryReturnsLeft_returnsLeft', () async {
      // arrange
      when(
        () => mockRepository.saveSeenWeeklyReportIds(tIds),
      ).thenAnswer((_) async => const Left(Failure.cache('Error')));

      // act
      final result = await sut(tIds);

      // assert
      expect(result, const Left<Failure, Unit>(Failure.cache('Error')));
    });
  });
}
