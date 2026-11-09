import 'package:bizzie/core/domain/models/company_filings.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/ai_reports/domain/enums/ai_report_form.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/analytics/ai_reports_tab_view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_ai_reports_state.freezed.dart';

@freezed
abstract class CompanyAiReportsState with _$CompanyAiReportsState {
  const factory CompanyAiReportsState.initial() = _Initial;
  const factory CompanyAiReportsState.loading() = _Loading;
  const factory CompanyAiReportsState.loaded({
    required String ticker,
    required CompanyFilings companyFilings,
    required String summaryButtonLabel,
    @Default(AiReportForm.tenK) AiReportForm selectedForm,
    @Default(AiReportForm.values) List<AiReportForm> forms,
    AiReportsTabViewState? analyticsState,
  }) = CompanyAiReportsLoaded;
  const factory CompanyAiReportsState.failure(Failure failure) = _Failure;
}
