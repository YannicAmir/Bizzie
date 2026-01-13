import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_repository.dart';
import 'package:bizzie/features/reports/domain/usecases/get_user_activity_use_case.dart';
import 'package:bizzie/features/user/domain/models/user_activity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportsRepository extends Mock implements IReportsRepository {}

void main() {
  late GetUserActivityUseCase useCase;
  late MockReportsRepository mockRepository;

  setUp(() {
    mockRepository = MockReportsRepository();
    useCase = GetUserActivityUseCase(mockRepository);
  });

  const tUid = 'test_uid';
  const tUserActivity = UserActivity(lastViewedReports: null);

  test('call_callsGetUserActivityStream', () {
    // arrange
    when(
      () => mockRepository.getUserActivityStream(any()),
    ).thenAnswer((_) => Stream.value(const Right(tUserActivity)));

    // act
    final result = useCase(tUid);

    // assert
    expect(result, emits(const Right(tUserActivity)));
    verify(() => mockRepository.getUserActivityStream(tUid));
    verifyNoMoreInteractions(mockRepository);
  });

  test('call_repositoryFailure_returnsFailure', () {
    // arrange
    const tFailure = ServerFailure('Test Failure');
    when(
      () => mockRepository.getUserActivityStream(any()),
    ).thenAnswer((_) => Stream.value(const Left(tFailure)));

    // act
    final result = useCase(tUid);

    // assert
    expect(result, emits(const Left(tFailure)));
    verify(() => mockRepository.getUserActivityStream(tUid));
    verifyNoMoreInteractions(mockRepository);
  });
}
