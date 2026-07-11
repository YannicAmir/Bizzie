import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_tabs_row.freezed.dart';

@freezed
sealed class EditTabsRow with _$EditTabsRow {
  const EditTabsRow._();

  const factory EditTabsRow.security() = EditTabsSecurityRow;
  const factory EditTabsRow.divider() = EditTabsDividerRow;

  const factory EditTabsRow.tab({
    required CompanyProfileTab tab,
    @Default(false) bool isLocked,
  }) = EditTabsTabRow;

  bool get isDraggable => map(
    security: (_) => false,
    divider: (_) => false,
    tab: (row) => !row.isLocked,
  );
}
