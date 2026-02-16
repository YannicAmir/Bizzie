import 'package:bizzie/services/in_app_review_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mocktail/mocktail.dart';

class MockInAppReview extends Mock implements InAppReview {}

void main() {
  late MockInAppReview mockInAppReview;
  late InAppReviewService service;

  setUp(() {
    mockInAppReview = MockInAppReview();
    service = InAppReviewService.test(mockInAppReview);
  });

  group('InAppReviewService', () {
    group('isAvailable', () {
      test('isAvailable_true_returnsTrue', () async {
        // arrange
        when(() => mockInAppReview.isAvailable()).thenAnswer((_) async => true);

        // act
        final result = await service.isAvailable();

        // assert
        expect(result, isTrue);
        verify(() => mockInAppReview.isAvailable()).called(1);
      });

      test('isAvailable_false_returnsFalse', () async {
        // arrange
        when(
          () => mockInAppReview.isAvailable(),
        ).thenAnswer((_) async => false);

        // act
        final result = await service.isAvailable();

        // assert
        expect(result, isFalse);
        verify(() => mockInAppReview.isAvailable()).called(1);
      });
    });

    group('requestReview', () {
      test('requestReview_serviceAvailable_callsNativeRequestReview', () async {
        // arrange
        when(() => mockInAppReview.isAvailable()).thenAnswer((_) async => true);
        when(() => mockInAppReview.requestReview()).thenAnswer((_) async => {});

        // act
        await service.requestReview();

        // assert
        verify(() => mockInAppReview.isAvailable()).called(1);
        verify(() => mockInAppReview.requestReview()).called(1);
      });

      test(
        'requestReview_serviceUnavailable_doesNotCallNativeRequestReview',
        () async {
          // arrange
          when(
            () => mockInAppReview.isAvailable(),
          ).thenAnswer((_) async => false);

          // act
          await service.requestReview();

          // assert
          verify(() => mockInAppReview.isAvailable()).called(1);
          verifyNever(() => mockInAppReview.requestReview());
        },
      );
    });
  });
}
