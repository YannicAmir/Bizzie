import 'package:bizzie/features/company_profile/ai_reports/domain/enums/ai_report_form.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_ai_reports_event.freezed.dart';

@freezed
sealed class CompanyAiReportsEvent with _$CompanyAiReportsEvent {
  const factory CompanyAiReportsEvent.started(String ticker) = Started;

  const factory CompanyAiReportsEvent.loadRequested(String ticker) =
      LoadRequested;

  const factory CompanyAiReportsEvent.tabShown(String ticker) = TabShown;

  const factory CompanyAiReportsEvent.tabHidden() = TabHidden;

  const factory CompanyAiReportsEvent.appBackgrounded() = AppBackgrounded;

  const factory CompanyAiReportsEvent.appForegrounded() = AppForegrounded;

  const factory CompanyAiReportsEvent.formChanged(AiReportForm form) =
      FormChanged;

  const factory CompanyAiReportsEvent.reportOpened() = ReportOpened;

  const factory CompanyAiReportsEvent.filingLinkOpened() = FilingLinkOpened;

  const factory CompanyAiReportsEvent.reset() = Reset;
}
