import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_view_history_repository.dart';
import 'package:bizzie/features/reports/domain/usecases/increment_reports_feed_view_count_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportsViewHistoryRepository extends Mock
    implements IReportsViewHistoryRepository {}

void main() {
  late IncrementReportsFeedViewCountUseCase sut;
  late MockReportsViewHistoryRepository mockRepository;

  setUp(() {
    mockRepository = MockReportsViewHistoryRepository();
    sut = IncrementReportsFeedViewCountUseCase(mockRepository);
  });

  group('IncrementReportsFeedViewCountUseCase', () {
    test('call_repositoryReturnsRight_returnsRightCount', () async {
      // arrange
      when(
        () => mockRepository.incrementFeedViewCount(),
      ).thenAnswer((_) async => const Right(3));

      // act
      final result = await sut();

      // assert
      expect(result, const Right<Failure, int>(3));
    });

    test('call_repositoryReturnsLeft_returnsLeft', () async {
      // arrange
      when(
        () => mockRepository.incrementFeedViewCount(),
      ).thenAnswer((_) async => const Left(Failure.cache('Error')));

      // act
      final result = await sut();

      // assert
      expect(result, const Left<Failure, int>(Failure.cache('Error')));
    });
  });
}
