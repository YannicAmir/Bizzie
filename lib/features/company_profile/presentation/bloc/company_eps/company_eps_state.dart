import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/eps_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_eps_state.freezed.dart';

@freezed
class CompanyEpsState with _$CompanyEpsState {
  const factory CompanyEpsState.initial() = _Initial;
  const factory CompanyEpsState.loading() = _Loading;
  const factory CompanyEpsState.loaded({
    required EpsStats epsStats,
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanyEpsState.failure(Failure failure) = _Failure;
}
