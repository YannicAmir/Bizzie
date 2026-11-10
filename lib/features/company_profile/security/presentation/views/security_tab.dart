import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/security_quote/security_quote_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/extensions/company_security_state_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/extensions/historical_price_eod_state_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/extensions/security_quote_state_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/utils/upcoming_earnings_presentation_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/key_metrics_section.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/price_chart_widget.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/security_overview_card.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/upcoming_earnings_widget.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _loadingSecurityLabel = 'Loading Security';
const _errorLoadingSecurityLabel = 'Error loading security';

class SecurityTab extends StatefulWidget {
  final String ticker;

  const SecurityTab({super.key, required this.ticker});

  @override
  State<SecurityTab> createState() => _SecurityTabState();
}

class _SecurityTabState extends State<SecurityTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final securityBloc = context.read<CompanySecurityBloc>();
    final eodBloc = context.read<HistoricalPriceEodBloc>();

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.security.analyticsName,
      onTabShown: () =>
          securityBloc.add(CompanySecurityEvent.tabShown(widget.ticker)),
      onTabHidden: () =>
          securityBloc.add(const CompanySecurityEvent.tabHidden()),
      onAppBackgrounded: () =>
          securityBloc.add(const CompanySecurityEvent.appBackgrounded()),
      onAppForegrounded: () {
        securityBloc.add(const CompanySecurityEvent.appForegrounded());
        securityBloc.add(
          CompanySecurityEvent.stalenessCheckRequested(widget.ticker),
        );
        eodBloc.add(
          HistoricalPriceEodEvent.stalenessCheckRequested(widget.ticker),
        );
      },
      child: _SecurityTabBody(ticker: widget.ticker),
    );
  }
}

class _SecurityTabBody extends StatelessWidget {
  final String ticker;

  const _SecurityTabBody({required this.ticker});

  @override
  Widget build(BuildContext context) {
    final securityState = context.watch<CompanySecurityBloc>().state;
    final priceState = context.watch<HistoricalPriceEodBloc>().state;
    final quoteState = context.watch<SecurityQuoteBloc>().state;

    const loadingView = CompanyProfileLoadingState(
      message: _loadingSecurityLabel,
    );

    if (securityState.isLoading || priceState.isLoading) {
      return loadingView;
    }

    return securityState.maybeMap(
      failure: (_) => _SecurityErrorView(ticker: ticker),
      loaded: (state) => _SecurityLoadedView(
        securityDetails: state.securityDetails,
        prices: priceState.prices,
        quote: quoteState.quote,
      ),
      orElse: () => loadingView,
    );
  }
}

class _SecurityErrorView extends StatelessWidget {
  final String ticker;

  const _SecurityErrorView({required this.ticker});

  @override
  Widget build(BuildContext context) {
    return CompanyProfileErrorState(
      message: _errorLoadingSecurityLabel,
      onRetry: () {
        context.read<CompanySecurityBloc>().add(
          CompanySecurityEvent.loadRequested(ticker, forceRefresh: true),
        );
        context.read<HistoricalPriceEodBloc>().add(
          HistoricalPriceEodEvent.loadRequested(ticker),
        );
      },
    );
  }
}

class _SecurityLoadedView extends StatelessWidget {
  final SecurityDetails securityDetails;
  final List<HistoricalPriceEod> prices;
  final SecurityQuote? quote;

  const _SecurityLoadedView({
    required this.securityDetails,
    required this.prices,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HistoricalPriceEodBloc, HistoricalPriceEodState>(
          listener: (context, eodState) {
            eodState.mapOrNull(
              loaded: (_) {
                context.read<CompanySecurityBloc>().add(
                  CompanySecurityEvent.priceAnalyticsUpdated(isSuccess: true),
                );
              },
            );
          },
        ),
        BlocListener<UpcomingEarningsBloc, UpcomingEarningsState>(
          listener: (context, earningsState) {
            earningsState.mapOrNull(
              loaded: (s) {
                context.read<CompanySecurityBloc>().add(
                  CompanySecurityEvent.earningsAnalyticsUpdated(
                    hasUpcoming: true,
                    daysAway: s.earningsDate.calendarDaysAway(),
                  ),
                );
              },
              empty: (_) {
                context.read<CompanySecurityBloc>().add(
                  CompanySecurityEvent.earningsAnalyticsUpdated(
                    hasUpcoming: false,
                  ),
                );
              },
            );
          },
        ),
      ],
      child: _SecurityContent(
        securityDetails: securityDetails,
        prices: prices,
        quote: quote,
      ),
    );
  }
}

class _SecurityContent extends StatelessWidget {
  final SecurityDetails securityDetails;
  final List<HistoricalPriceEod> prices;
  final SecurityQuote? quote;

  const _SecurityContent({
    required this.securityDetails,
    required this.prices,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        children: [
          SecurityOverviewCard(
            securityDetails: securityDetails,
            prices: prices,
            quote: quote,
          ),
          const UpcomingEarningsWidget(),
          AppConstants.mainSectionSpacing,
          KeyMetricsSection(details: securityDetails),
          AppConstants.mainSectionSpacing,
          const _PriceChartAnalyticsReporter(child: PriceChartWidget()),
        ],
      ),
    );
  }
}

class _PriceChartAnalyticsReporter extends StatefulWidget {
  final Widget child;

  const _PriceChartAnalyticsReporter({required this.child});

  @override
  State<_PriceChartAnalyticsReporter> createState() =>
      _PriceChartAnalyticsReporterState();
}

class _PriceChartAnalyticsReporterState
    extends State<_PriceChartAnalyticsReporter> {
  @override
  void initState() {
    super.initState();
    _report(context.read<PriceChartBloc>().state);
  }

  void _report(PriceChartState chartState) {
    context.read<CompanySecurityBloc>().add(
      CompanySecurityEvent.priceAnalyticsUpdated(
        chartChangeCount: chartState.chartChangeCount,
        finalTimeframe: chartState.selectedTimeFrame,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PriceChartBloc, PriceChartState>(
      listener: (_, chartState) => _report(chartState),
      child: widget.child,
    );
  }
}
