import 'package:bizzie/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/company_profile/domain/models/share_stats.dart';

part 'company_shares_state.freezed.dart';

@freezed
class CompanySharesState with _$CompanySharesState {
  const factory CompanySharesState.initial() = _Initial;
  const factory CompanySharesState.loading() = _Loading;
  const factory CompanySharesState.loaded({
    required ShareStats shareStats,
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanySharesState.failure(Failure failure) = _Failure;
}
