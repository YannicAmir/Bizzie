import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile_event.freezed.dart';

@freezed
sealed class CompanyProfileEvent with _$CompanyProfileEvent {
  const factory CompanyProfileEvent.opened({
    required String ticker,
    required String companyName,
    required String? industry,
    required String? sector,
    required String initialTabName,
    required bool isWatchlisted,
    required bool isCompany,
    required bool isEtf,
    required bool isFund,
  }) = Opened;

  const factory CompanyProfileEvent.tabViewed({required String tabName}) =
      TabViewed;

  const factory CompanyProfileEvent.watchlistStatusChanged({
    required bool isWatchlisted,
  }) = WatchlistStatusChanged;

  const factory CompanyProfileEvent.lifecycleChanged({
    required BizzieLifecycleState state,
  }) = LifecycleChanged;

  const factory CompanyProfileEvent.editTabsOpened({
    required bool isSubscribed,
  }) = EditTabsOpened;

  const factory CompanyProfileEvent.tabOrderSaved({
    required bool isSubscribed,
    required List<String> mainTabs,
    required List<String> moreTabs,
  }) = TabOrderSaved;

  const factory CompanyProfileEvent.closed() = Closed;
}
