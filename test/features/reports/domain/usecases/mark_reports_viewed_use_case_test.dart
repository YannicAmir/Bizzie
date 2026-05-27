import 'package:bizzie/features/reports/domain/interfaces/i_reports_repository.dart';
import 'package:bizzie/features/reports/domain/models/mark_reports_viewed_params.dart';
import 'package:bizzie/features/reports/domain/usecases/mark_reports_viewed_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockReportsRepository extends Mock implements IReportsRepository {}

void main() {
  late MarkReportsViewedUseCase useCase;
  late MockReportsRepository mockRepository;

  setUp(() {
    mockRepository = MockReportsRepository();
    useCase = MarkReportsViewedUseCase(mockRepository);
  });

  const tUid = 'test_uid';
  final tTimestamp = DateTime(2023, 1, 1);
  final tParams = MarkReportsViewedParams(uid: tUid, timestamp: tTimestamp);

  test('call_callsMarkReportsViewed', () async {
    // arrange
    when(
      () => mockRepository.markReportsViewed(any(), any()),
    ).thenAnswer((_) async => const Right(unit));

    // act
    await useCase(tParams);

    // assert
    verify(() => mockRepository.markReportsViewed(tUid, tTimestamp));
    verifyNoMoreInteractions(mockRepository);
  });
}
