import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/net_income_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_net_income_state.freezed.dart';

@freezed
class CompanyNetIncomeState with _$CompanyNetIncomeState {
  const factory CompanyNetIncomeState.initial() = _Initial;
  const factory CompanyNetIncomeState.loading() = _Loading;
  const factory CompanyNetIncomeState.loaded({
    required NetIncomeStats netIncomeStats,
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanyNetIncomeState.failure(Failure failure) = _Failure;
}
