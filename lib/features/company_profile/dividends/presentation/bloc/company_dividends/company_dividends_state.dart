import 'package:bizzie/features/company_profile/dividends/presentation/analytics/dividend_tab_view_state.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_info.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_dividends_state.freezed.dart';

@freezed
class CompanyDividendsState with _$CompanyDividendsState {
  const factory CompanyDividendsState.initial() = _Initial;
  const factory CompanyDividendsState.loading() = _Loading;
  const factory CompanyDividendsState.loaded({
    required DividendInfo dividendInfo,
    required String ticker,
    required int historyLimit,
    required CompanyProfileDataOrigin dataOrigin,
    DateTime? lastUpdated,
    DividendTabViewState? analyticsState,
  }) = _Loaded;
  const factory CompanyDividendsState.error(Failure failure) = _Error;
}
