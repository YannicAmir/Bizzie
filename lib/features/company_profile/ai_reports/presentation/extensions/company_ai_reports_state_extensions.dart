import 'package:bizzie/core/domain/models/company_filings.dart';
import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/features/company_profile/ai_reports/domain/enums/ai_report_form.dart';
import 'package:bizzie/features/company_profile/ai_reports/domain/extensions/financial_report_list_extensions.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_state.dart';
import 'package:bizzie/shared/models/filing_view_model.dart';
import 'package:collection/collection.dart';

const String _kReportFormSeparator = '_';
const String _kFilingFormSeparator = '/';

extension CompanyAiReportsLoadedX on CompanyAiReportsLoaded {
  List<FilingViewModel> get visibleFilings =>
      companyFilings.aiReportFilings(selectedForm);

  String get emptyMessage =>
      'No AI ${selectedForm.formType} reports available for $ticker';
}

extension CompanyFilingsAiReportsX on CompanyFilings {
  List<FilingViewModel> aiReportFilings(AiReportForm form) {
    return reports
        .forForm(form)
        .map(
          (report) => switch (_filingFor(report)) {
            final filing? => FilingViewModel(filing: filing, report: report),
            null => null,
          },
        )
        .nonNulls
        .toList();
  }

  SecFiling? _filingFor(FinancialReport report) {
    final matches = filings.where((filing) => filing.isFiledAs(report));
    return matches.firstWhereOrNull((filing) => filing.isEarnings) ??
        matches.firstOrNull;
  }
}

extension on SecFiling {
  bool isFiledAs(FinancialReport report) {
    final reportDate = report.filingDate;
    final date = filingDate;
    if (reportDate == null || date == null) return false;
    return formType ==
            report.formType.replaceAll(
              _kReportFormSeparator,
              _kFilingFormSeparator,
            ) &&
        date.year == reportDate.year &&
        date.month == reportDate.month &&
        date.day == reportDate.day;
  }
}
