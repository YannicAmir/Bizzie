import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_tabs_notice.freezed.dart';

@freezed
sealed class EditTabsNotice with _$EditTabsNotice {
  const factory EditTabsNotice.tooManyMainTabs(int maxTabs) =
      EditTabsTooManyMainTabs;

  const factory EditTabsNotice.tooFewMainTabs(int minTabs) =
      EditTabsTooFewMainTabs;
}
