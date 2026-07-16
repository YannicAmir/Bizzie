import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_tabs_config.freezed.dart';
part 'company_tabs_config.g.dart';

@freezed
abstract class CompanyTabsConfig with _$CompanyTabsConfig {
  const factory CompanyTabsConfig({
    @Default([]) List<String> mainTabs,
    @Default([]) List<String> moreTabs,
    @Default([]) List<String> bizziePlusTabs,
  }) = _CompanyTabsConfig;

  factory CompanyTabsConfig.fromJson(Map<String, dynamic> json) =>
      _$CompanyTabsConfigFromJson(json);
}
