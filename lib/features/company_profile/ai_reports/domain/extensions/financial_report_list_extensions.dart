import 'package:bizzie/features/company_profile/ai_reports/domain/enums/ai_report_form.dart';
import 'package:bizzie/core/domain/models/financial_report.dart';

extension FinancialReportListX on List<FinancialReport> {
  List<FinancialReport> forForm(AiReportForm form) {
    return where((report) => report.formType.startsWith(form.formType)).toList()
      ..sort((a, b) => b._sortDate.compareTo(a._sortDate));
  }
}

extension on FinancialReport {
  DateTime get _sortDate => filingDate ?? dateAnalyzed ?? DateTime(0);
}
