import 'package:bizzie/features/company_profile/domain/models/dividend_info.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_dividends_state.freezed.dart';

@freezed
class CompanyDividendsState with _$CompanyDividendsState {
  const factory CompanyDividendsState.initial() = _Initial;
  const factory CompanyDividendsState.loading() = _Loading;
  const factory CompanyDividendsState.loaded(
    DividendInfo dividendInfo, {
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanyDividendsState.error(Failure failure) = _Error;
}
