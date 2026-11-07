import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/domain/models/weekly_report.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/widgets/cards/weekly_report_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReportsWeeklyReportCard extends StatelessWidget {
  final WeeklyReport report;
  final DateTime? lastViewed;

  const ReportsWeeklyReportCard({
    super.key,
    required this.report,
    this.lastViewed,
  });

  void _onCompanyTapped(BuildContext context) {
    final ticker = report.ticker ?? '';
    context.read<ReportsBloc>().add(
      ReportsEvent.filingCardCompanyClicked(ticker: ticker),
    );
    context.goNamed(
      AppRoutes.companyProfileReports,
      pathParameters: {'ticker': ticker},
      extra: Company(ticker: ticker, name: report.companyName ?? ''),
    );
  }

  void _onLockedTapped(BuildContext context) {
    context.read<ReportsBloc>().add(
      ReportsEvent.summarizeLockedClicked(
        ticker: report.ticker ?? '',
        filingType: WeeklyReportCard.filingType,
      ),
    );
    PaywallHelper.showPaywallSequence(context, source: PaywallSource.reports);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, bool>(
      selector: (state) => state.isSubscribed,
      builder: (context, isSubscribed) => WeeklyReportCard(
        report: report,
        isLocked: !isSubscribed,
        lastViewed: lastViewed,
        onCompanyTapped: () => _onCompanyTapped(context),
        onLockedTapped: () => _onLockedTapped(context),
        onReportOpened: () => context.read<ReportsBloc>().add(
          ReportsEvent.linkOpened(
            ticker: report.ticker ?? '',
            filingType: WeeklyReportCard.filingType,
          ),
        ),
      ),
    );
  }
}
