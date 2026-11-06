import 'package:bizzie/features/company_profile/ai_reports/domain/enums/ai_report_form.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_bloc.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_event.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/bloc/company_ai_reports_state.dart';
import 'package:bizzie/features/company_profile/ai_reports/presentation/extensions/company_ai_reports_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_empty_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/models/filing_view_model.dart';
import 'package:bizzie/shared/widgets/cards/sec_filing_card.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiReportsTab extends StatefulWidget {
  final String ticker;

  const AiReportsTab({super.key, required this.ticker});

  @override
  State<AiReportsTab> createState() => _AiReportsTabState();
}

class _AiReportsTabState extends State<AiReportsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<CompanyAiReportsBloc>().add(
      CompanyAiReportsEvent.started(widget.ticker),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.aiReports.analyticsName,
      onTabShown: () => context.read<CompanyAiReportsBloc>().add(
        CompanyAiReportsEvent.tabShown(widget.ticker),
      ),
      onTabHidden: () => context.read<CompanyAiReportsBloc>().add(
        const CompanyAiReportsEvent.tabHidden(),
      ),
      onAppBackgrounded: () => context.read<CompanyAiReportsBloc>().add(
        const CompanyAiReportsEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<CompanyAiReportsBloc>().add(
        const CompanyAiReportsEvent.appForegrounded(),
      ),
      child: BlocBuilder<CompanyAiReportsBloc, CompanyAiReportsState>(
        builder: (context, state) {
          return state.map(
            initial: (_) =>
                const CompanyProfileLoadingState(message: 'Loading AI Reports'),
            loading: (_) =>
                const CompanyProfileLoadingState(message: 'Loading AI Reports'),
            failure: (_) => CompanyProfileErrorState(
              message: 'Error loading AI reports',
              onRetry: () => context.read<CompanyAiReportsBloc>().add(
                CompanyAiReportsEvent.loadRequested(widget.ticker),
              ),
            ),
            loaded: (loadedState) => _LoadedView(state: loadedState),
          );
        },
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final CompanyAiReportsLoaded state;

  const _LoadedView({required this.state});

  @override
  Widget build(BuildContext context) {
    final filings = state.visibleFilings;

    if (filings.isEmpty) {
      return SingleChildScrollView(
        padding: AppConstants.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FormSwitch(selectedForm: state.selectedForm),
            AppConstants.emptyStateTopSpacing,
            CompanyProfileEmptyState(message: state.emptyMessage),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: AppConstants.pagePadding,
      itemCount: filings.length + 1,
      separatorBuilder: (_, __) => AppConstants.secondarySectionSpacing,
      itemBuilder: (context, index) {
        if (index == 0) return _FormSwitch(selectedForm: state.selectedForm);
        final viewModel = filings[index - 1];
        return _AiReportCard(
          viewModel: viewModel,
          summaryButtonLabel: state.summaryButtonLabel,
        );
      },
    );
  }
}

class _AiReportCard extends StatelessWidget {
  final FilingViewModel viewModel;
  final String summaryButtonLabel;

  const _AiReportCard({
    required this.viewModel,
    required this.summaryButtonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, bool>(
      selector: (state) => state.isSubscribed,
      builder: (context, isSubscribed) => SecFilingCard(
        filing: viewModel.filing,
        financialReport: viewModel.report,
        summaryButtonLabel: summaryButtonLabel,
        isSummaryLocked: !isSubscribed,
        onViewReportTapped: () => context.read<CompanyAiReportsBloc>().add(
          const CompanyAiReportsEvent.filingLinkOpened(),
        ),
        onLockedSummaryTapped: () => PaywallHelper.showLockedTabPaywall(
          context,
          tabName: CompanyProfileTab.aiReports.analyticsName,
        ),
        onSummaryRequested: (_) => context.read<CompanyAiReportsBloc>().add(
          const CompanyAiReportsEvent.reportOpened(),
        ),
      ),
    );
  }
}

class _FormSwitch extends StatelessWidget {
  final AiReportForm selectedForm;

  const _FormSwitch({required this.selectedForm});

  @override
  Widget build(BuildContext context) {
    return BizzieSwitch(
      options: AiReportForm.values.map((form) => form.formType).toList(),
      selectedIndex: selectedForm.index,
      onChanged: (index) => context.read<CompanyAiReportsBloc>().add(
        CompanyAiReportsEvent.formChanged(AiReportForm.values[index]),
      ),
    );
  }
}
