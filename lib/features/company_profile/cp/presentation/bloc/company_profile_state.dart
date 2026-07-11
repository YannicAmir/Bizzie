import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile_state.freezed.dart';

@freezed
class CompanyProfileState with _$CompanyProfileState {
  const factory CompanyProfileState.initial() = Initial;

  const factory CompanyProfileState.active({
    required String sessionId,
    required String ticker,
    required String companyName,
    required String? industry,
    required String? sector,
    required Set<String> viewedTabs,
    required String activeTabName,
    required int accumulatedSeconds,
    required DateTime lastActiveStartTime,
    required bool initiallyWatchlisted,
    required bool currentWatchlisted,
    required bool isCompany,
    required bool isEtf,
    required bool isFund,
    required BizzieLifecycleState lifecycleState,
  }) = Active;
}
