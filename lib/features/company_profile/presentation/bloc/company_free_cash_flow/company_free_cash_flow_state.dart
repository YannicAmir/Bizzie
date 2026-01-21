import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/free_cash_flow_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_free_cash_flow_state.freezed.dart';

@freezed
class CompanyFreeCashFlowState with _$CompanyFreeCashFlowState {
  const factory CompanyFreeCashFlowState.initial() = _Initial;
  const factory CompanyFreeCashFlowState.loading() = _Loading;
  const factory CompanyFreeCashFlowState.loaded({
    required FreeCashFlowStats fcfStats,
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanyFreeCashFlowState.failure(Failure failure) = _Failure;
}
