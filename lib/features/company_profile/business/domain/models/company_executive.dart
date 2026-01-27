import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_executive.freezed.dart';

@freezed
abstract class CompanyExecutive with _$CompanyExecutive {
  const factory CompanyExecutive({
    required String name,
    required String title,
    String? gender,
    double? totalPay,
    String? currencyPay,
    int? yearBorn,
  }) = _CompanyExecutive;
}
