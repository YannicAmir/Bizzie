import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tab_activation.freezed.dart';

@freezed
abstract class TabActivation with _$TabActivation {
  const factory TabActivation({
    required CompanyProfileTab tab,
    required String ticker,
  }) = _TabActivation;
}
