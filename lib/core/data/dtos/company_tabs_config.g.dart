// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_tabs_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompanyTabsConfig _$CompanyTabsConfigFromJson(
  Map<String, dynamic> json,
) => _CompanyTabsConfig(
  mainTabs:
      (json['mainTabs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  moreTabs:
      (json['moreTabs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  bizziePlusTabs:
      (json['bizziePlusTabs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$CompanyTabsConfigToJson(_CompanyTabsConfig instance) =>
    <String, dynamic>{
      'mainTabs': instance.mainTabs,
      'moreTabs': instance.moreTabs,
      'bizziePlusTabs': instance.bizziePlusTabs,
    };
