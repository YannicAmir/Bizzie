import 'dart:math';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_session_summary.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_state.dart';

extension CompanyProfileStateX on CompanyProfileState {
  CompanyProfileSessionSummary? toSummary({required bool isFinal}) {
    return mapOrNull(
      active: (s) => CompanyProfileSessionSummary(
        sessionId: s.sessionId,
        ticker: s.ticker,
        companyName: s.companyName,
        industry: s.industry,
        sector: s.sector,
        tabsCount: s.viewedTabs.length,
        tabsList: s.viewedTabs.toList(),
        durationSeconds: max(0, s.accumulatedSeconds),
        isWatchlisted: s.currentWatchlisted,
        initWatchlisted: s.initiallyWatchlisted,
        isCompany: s.isCompany,
        isEtf: s.isEtf,
        isFund: s.isFund,
        isFinal: isFinal,
      ),
    );
  }
}
