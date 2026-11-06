import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/financial_report.dart';
import 'package:bizzie/core/domain/models/sec_filing.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/widgets/cards/sec_filing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReportsFilingCard extends StatelessWidget {
  final SecFiling filing;
  final FinancialReport? financialReport;
  final DateTime? lastViewed;

  const ReportsFilingCard({
    super.key,
    required this.filing,
    this.financialReport,
    this.lastViewed,
  });

  void _onCompanyTapped(BuildContext context) {
    context.read<ReportsBloc>().add(
      ReportsEvent.filingCardCompanyClicked(ticker: filing.symbol),
    );
    context.goNamed(
      AppRoutes.companyProfileReports,
      pathParameters: {'ticker': filing.symbol},
      extra: Company(ticker: filing.symbol, name: filing.companyName),
    );
  }

  void _onLockedSummaryTapped(BuildContext context) {
    context.read<ReportsBloc>().add(
      ReportsEvent.summarizeLockedClicked(
        ticker: filing.symbol,
        filingType: filing.formType,
      ),
    );
    PaywallHelper.showPaywallSequence(context, source: PaywallSource.reports);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, bool>(
      selector: (state) => state.isSubscribed,
      builder: (context, isSubscribed) => SecFilingCard(
        filing: filing,
        financialReport: financialReport,
        lastViewed: lastViewed,
        summaryButtonLabel: getIt<IConfigService>().aiSummaryButtonLabel,
        isSummaryLocked: !isSubscribed,
        onCompanyTapped: () => _onCompanyTapped(context),
        onViewReportTapped: () => context.read<ReportsBloc>().add(
          ReportsEvent.linkOpened(
            ticker: filing.symbol,
            filingType: filing.formType,
          ),
        ),
        onLockedSummaryTapped: () => _onLockedSummaryTapped(context),
        onSummaryRequested: (isReady) => context.read<ReportsBloc>().add(
          ReportsEvent.summaryRequested(
            ticker: filing.symbol,
            filingType: filing.formType,
            isReady: isReady,
          ),
        ),
      ),
    );
  }
}
