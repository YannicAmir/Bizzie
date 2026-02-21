import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile_session_summary.freezed.dart';

@freezed
abstract class CompanyProfileSessionSummary
    with _$CompanyProfileSessionSummary {
  const CompanyProfileSessionSummary._();

  const factory CompanyProfileSessionSummary({
    required String sessionId,
    required String ticker,
    required String companyName,
    String? industry,
    String? sector,
    required int tabsCount,
    required List<String> tabsList,
    required int durationSeconds,
    required bool isWatchlisted,
    required bool initWatchlisted,
    required bool isCompany,
    required bool isEtf,
    required bool isFund,
    required bool isFinal,
  }) = _CompanyProfileSessionSummary;
}
