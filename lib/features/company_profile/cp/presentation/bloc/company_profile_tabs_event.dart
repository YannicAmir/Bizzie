import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile_tabs_event.freezed.dart';

@freezed
sealed class CompanyProfileTabsEvent with _$CompanyProfileTabsEvent {
  const factory CompanyProfileTabsEvent.started({
    required bool isSubscribed,
  }) = Started;

  const factory CompanyProfileTabsEvent.tabActivated({
    required CompanyProfileTab tab,
    required String ticker,
  }) = TabActivated;

  const factory CompanyProfileTabsEvent.moreTabIndexChanged({
    required int index,
    required String ticker,
  }) = MoreTabIndexChanged;

  const factory CompanyProfileTabsEvent.tabOrderChanged() = TabOrderChanged;

  const factory CompanyProfileTabsEvent.reset() = Reset;
}
