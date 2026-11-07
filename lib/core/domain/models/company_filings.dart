import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/core/domain/models/weekly_report.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_filings.freezed.dart';

@freezed
abstract class CompanyFilings with _$CompanyFilings {
  const factory CompanyFilings({
    @Default([]) List<FinancialReport> reports,
    @Default([]) List<SecFiling> filings,
    @Default([]) List<WeeklyReport> weeklyReports,
  }) = _CompanyFilings;
}
