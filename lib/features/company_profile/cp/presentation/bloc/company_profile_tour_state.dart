import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_highlights_resolver.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile_tour_state.freezed.dart';

@freezed
abstract class CompanyProfileTourState with _$CompanyProfileTourState {
  const factory CompanyProfileTourState.initial() = _Initial;

  const factory CompanyProfileTourState.active({
    required String ticker,
    required String companyName,
    required bool shouldPromptNotifications,
    required CompanyProfileTourStep step,
    @Default(false) bool isAwaitingRevenueData,
    GrowthHighlight? revenueGrowth,
    @Default(<CompanyProfileTourStep>{})
    Set<CompanyProfileTourStep> completedSteps,
  }) = CompanyProfileTourActive;

  const factory CompanyProfileTourState.finished({
    required bool shouldPromptNotifications,
    @Default(false) bool wasSkipped,
  }) = CompanyProfileTourFinished;
}
