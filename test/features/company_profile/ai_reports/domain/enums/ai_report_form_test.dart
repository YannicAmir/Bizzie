import 'package:bizzie/features/company_profile/ai_reports/domain/enums/ai_report_form.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AiReportForm.inOrder', () {
    test('inOrder_allFormTypes_followsGivenOrder', () {
      // act
      final result = AiReportForm.inOrder(['8-K', '10-K', 'Recaps', '10-Q']);

      // assert
      expect(result, [
        AiReportForm.eightK,
        AiReportForm.tenK,
        AiReportForm.recaps,
        AiReportForm.tenQ,
      ]);
    });

    test('inOrder_missingFormType_appendsItLast', () {
      // act
      final result = AiReportForm.inOrder(['10-Q', '8-K']);

      // assert
      expect(result, [
        AiReportForm.tenQ,
        AiReportForm.eightK,
        AiReportForm.tenK,
        AiReportForm.recaps,
      ]);
    });

    test('inOrder_unknownAndDuplicateFormTypes_ignoresThem', () {
      // act
      final result = AiReportForm.inOrder([
        'S-1',
        '8-K',
        '8-K',
        '10-K',
        '10-Q',
        'Recaps',
      ]);

      // assert
      expect(result, [
        AiReportForm.eightK,
        AiReportForm.tenK,
        AiReportForm.tenQ,
        AiReportForm.recaps,
      ]);
    });

    test('inOrder_emptyList_returnsAllForms', () {
      // act
      final result = AiReportForm.inOrder([]);

      // assert
      expect(result, AiReportForm.values);
    });
  });
}
