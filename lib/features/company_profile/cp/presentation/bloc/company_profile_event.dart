part of 'company_profile_bloc.dart';

@freezed
class CompanyProfileEvent with _$CompanyProfileEvent {
  const factory CompanyProfileEvent.opened({
    required String ticker,
    required String companyName,
    required String? industry,
    required String? sector,
    required String initialTabName,
    required bool isWatchlisted,
    required bool isCompany,
    required bool isEtf,
    required bool isFund,
  }) = _Opened;

  const factory CompanyProfileEvent.tabViewed({required String tabName}) =
      _TabViewed;

  const factory CompanyProfileEvent.watchlistStatusChanged({
    required bool isWatchlisted,
  }) = _WatchlistStatusChanged;

  const factory CompanyProfileEvent.lifecycleChanged({
    required BizzieLifecycleState state,
  }) = _LifecycleChanged;

  const factory CompanyProfileEvent.moreTabIndexChanged({required int index}) =
      _MoreTabIndexChanged;

  const factory CompanyProfileEvent.closed() = _Closed;
}
