import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/fcps_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_fcps_state.freezed.dart';

@freezed
class CompanyFcpsState with _$CompanyFcpsState {
  const factory CompanyFcpsState.initial() = _Initial;
  const factory CompanyFcpsState.loading() = _Loading;
  const factory CompanyFcpsState.loaded({
    required FcpsStats fcpsStats,
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanyFcpsState.failure(Failure failure) = _Failure;
}
