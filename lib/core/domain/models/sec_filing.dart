import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sec_filing.freezed.dart';

const String _kReportFormSeparator = '_';
const String _kFilingFormSeparator = '/';

@freezed
abstract class SecFiling with _$SecFiling {
  const SecFiling._();

  const factory SecFiling({
    required String id,
    required String symbol,
    required String companyName,
    required DateTime? filingDate,
    required String formType,
    required String link,
    required String summary,
    double? eps,
    double? revenue,
    String? sentiment,
    String? topic,
    @Default(false) bool isEarnings,
    required DateTime? createdAt,
    required DateTime? analyzedAt,
    String? deepAnalysisId,
    String? deepAnalysisStatus,
  }) = _SecFiling;

  bool isFiledAs(FinancialReport report) {
    final reportDate = report.filingDate;
    final date = filingDate;
    if (reportDate == null || date == null) return false;
    return symbol == report.ticker &&
        formType ==
            report.formType.replaceAll(
              _kReportFormSeparator,
              _kFilingFormSeparator,
            ) &&
        date.year == reportDate.year &&
        date.month == reportDate.month &&
        date.day == reportDate.day;
  }
}
