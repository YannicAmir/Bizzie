import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_tabs_event.freezed.dart';

@freezed
sealed class EditTabsEvent with _$EditTabsEvent {
  const factory EditTabsEvent.started({
    required List<CompanyProfileTab> mainTabs,
    required List<CompanyProfileTab> moreTabs,
    required bool isSubscribed,
  }) = EditTabsStarted;

  const factory EditTabsEvent.tabReordered({
    required int oldIndex,
    required int newIndex,
  }) = EditTabsTabReordered;

  const factory EditTabsEvent.saveRequested() = EditTabsSaveRequested;
  const factory EditTabsEvent.reset() = EditTabsReset;
}
