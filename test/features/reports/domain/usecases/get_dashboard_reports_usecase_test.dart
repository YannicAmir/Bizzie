import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_repository.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/domain/usecases/get_dashboard_reports_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportsRepository extends Mock implements IReportsRepository {}

void main() {
  late GetDashboardReportsUseCase useCase;
  late MockReportsRepository mockRepository;

  setUp(() {
    mockRepository = MockReportsRepository();
    useCase = GetDashboardReportsUseCase(mockRepository);
  });

  const tTickers = ['AAPL', 'GOOGL'];
  const tReportsFeed = ReportsFeed();

  test('call_callsGetReportsFeed', () {
    // arrange
    when(
      () => mockRepository.getReportsFeed(any()),
    ).thenAnswer((_) => Stream.value(const Right(tReportsFeed)));

    // act
    final stream = useCase(tTickers);

    // assert
    expect(stream, emits(const Right(tReportsFeed)));
    verify(() => mockRepository.getReportsFeed(tTickers)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('call_repositoryFailure_returnsFailure', () {
    // arrange
    const tFailure = ServerFailure('Test Error');
    when(
      () => mockRepository.getReportsFeed(any()),
    ).thenAnswer((_) => Stream.value(const Left(tFailure)));

    // act
    final stream = useCase(tTickers);

    // assert
    expect(stream, emits(const Left(tFailure)));
    verify(() => mockRepository.getReportsFeed(tTickers)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
