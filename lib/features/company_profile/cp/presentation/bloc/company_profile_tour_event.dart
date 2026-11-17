import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_highlights_resolver.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile_tour_event.freezed.dart';

@freezed
sealed class CompanyProfileTourEvent with _$CompanyProfileTourEvent {
  const factory CompanyProfileTourEvent.started({
    required String ticker,
    required String companyName,
    required bool shouldPromptNotifications,
  }) = TourStarted;

  const factory CompanyProfileTourEvent.stepCompleted() = TourStepCompleted;

  const factory CompanyProfileTourEvent.previousRequested() =
      TourPreviousRequested;

  const factory CompanyProfileTourEvent.revenueTabSelected() =
      TourRevenueTabSelected;

  const factory CompanyProfileTourEvent.revenueGrowthResolved(
    GrowthHighlight? growth,
  ) = TourRevenueGrowthResolved;

  const factory CompanyProfileTourEvent.targetUnavailableReported() =
      TourTargetUnavailableReported;

  const factory CompanyProfileTourEvent.skipRequested() = TourSkipRequested;

  const factory CompanyProfileTourEvent.reset() = TourReset;
}
