import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/edit_tabs_notice.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/edit_tabs_row.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_tabs_state.freezed.dart';

@freezed
abstract class EditTabsState with _$EditTabsState {
  const factory EditTabsState.initial() = _Initial;

  const factory EditTabsState.editing({
    required List<CompanyProfileTab> initialMainTabs,
    required List<CompanyProfileTab> initialMoreTabs,
    required List<CompanyProfileTab> mainTabs,
    required List<CompanyProfileTab> moreTabs,
    required List<CompanyProfileTab> bizziePlusTabs,
    required bool isSubscribed,
    @Default(false) bool isSaving,
    EditTabsNotice? notice,
  }) = EditTabsEditing;

  const factory EditTabsState.saved(TabLayout layout) = EditTabsSaved;
  const factory EditTabsState.failure(Failure failure) = _Failure;
}

extension EditTabsEditingX on EditTabsEditing {
  List<EditTabsRow> get rows => [
    const EditTabsRow.mainDivider(),
    const EditTabsRow.security(),
    ...mainTabs.map((tab) => EditTabsRow.tab(tab: tab)),
    const EditTabsRow.divider(),
    ...moreTabs.map((tab) => EditTabsRow.tab(tab: tab)),
    if (bizziePlusTabs.isNotEmpty) ...[
      const EditTabsRow.bizziePlusDivider(),
      ...bizziePlusTabs.map((tab) => EditTabsRow.tab(tab: tab, isLocked: true)),
    ],
  ];

  bool get hasChanges =>
      !const ListEquality<CompanyProfileTab>().equals(
        mainTabs,
        initialMainTabs,
      ) ||
      !const ListEquality<CompanyProfileTab>().equals(
        moreTabs,
        initialMoreTabs,
      );

  bool get canSave => hasChanges && !isSaving;
}
