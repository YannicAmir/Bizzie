import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/price_chart_widget.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/security_overview_card.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/upcoming_earnings_widget.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/key_metrics_section.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_state_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/price_chart/price_chart_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/upcoming_earnings/upcoming_earnings_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/utils/upcoming_earnings_presentation_extensions.dart';
import 'package:bizzie/di/injection.dart';

class SecurityTab extends StatefulWidget {
  final String ticker;

  const SecurityTab({super.key, required this.ticker});

  @override
  State<SecurityTab> createState() => _SecurityTabState();
}

class _SecurityTabState extends State<SecurityTab>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late final CompanySecurityBloc _securityBloc;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _securityBloc = context.read<CompanySecurityBloc>();
    _securityBloc.add(const CompanySecurityEvent.tabShown());
  }

  @override
  void dispose() {
    _securityBloc.add(const CompanySecurityEvent.tabHidden());
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _securityBloc.add(const CompanySecurityEvent.appBackgrounded());
    } else if (state == AppLifecycleState.resumed) {
      _securityBloc.add(const CompanySecurityEvent.appForegrounded());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<CompanySecurityBloc, CompanySecurityState>(
      builder: (context, securityState) {
        return BlocBuilder<HistoricalPriceEodBloc, HistoricalPriceEodState>(
          builder: (context, priceState) {
            if (securityState.isLoading || priceState.isLoading) {
              return const CompanyProfileLoadingState(
                message: 'Loading Security',
              );
            }

            return securityState.maybeMap(
              failure: (f) => CompanyProfileErrorState(
                message: 'Error loading security',
                onRetry: () {
                  context.read<CompanySecurityBloc>().add(
                    CompanySecurityEvent.loadRequested(
                      widget.ticker,
                      forceRefresh: true,
                    ),
                  );
                  context.read<HistoricalPriceEodBloc>().add(
                    HistoricalPriceEodEvent.loadRequested(widget.ticker),
                  );
                },
              ),
              loaded: (state) {
                final securityDetails = state.securityDetails;
                final prices = priceState.maybeMap(
                  loaded: (s) => s.prices,
                  orElse: () => <HistoricalPriceEod>[],
                );
                final dataSource = priceState.maybeMap(
                  loaded: (s) => s.dataSource,
                  orElse: () => CompanyProfileDataOrigin.api,
                );

                return MultiBlocListener(
                  listeners: [
                    // Bridge performance metadata from HistoricalPriceEodBloc
                    BlocListener<
                      HistoricalPriceEodBloc,
                      HistoricalPriceEodState
                    >(
                      listener: (context, eodState) {
                        eodState.mapOrNull(
                          loaded: (s) {
                            context.read<CompanySecurityBloc>().add(
                              CompanySecurityEvent.priceAnalyticsUpdated(
                                isSuccess: true,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    // Bridge earnings metadata
                    BlocListener<UpcomingEarningsBloc, UpcomingEarningsState>(
                      listener: (context, earningsState) {
                        earningsState.mapOrNull(
                          loaded: (s) {
                            context.read<CompanySecurityBloc>().add(
                              CompanySecurityEvent.earningsAnalyticsUpdated(
                                hasUpcoming: true,
                                daysAway: s.earningsDate.daysAwayLabel,
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
                    dataSource: dataSource,
                  ),
                );
              },
              orElse: () =>
                  const CompanyProfileLoadingState(message: 'Loading Security'),
            );
          },
        );
      },
    );
  }
}

class _SecurityContent extends StatelessWidget {
  final SecurityDetails securityDetails;
  final List<HistoricalPriceEod> prices;
  final CompanyProfileDataOrigin dataSource;

  const _SecurityContent({
    required this.securityDetails,
    required this.prices,
    required this.dataSource,
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
            dataSource: dataSource,
          ),
          const UpcomingEarningsWidget(),
          AppConstants.mainSectionSpacing,
          KeyMetricsSection(details: securityDetails),
          AppConstants.mainSectionSpacing,
          BlocProvider(
            key: ValueKey('price_chart_${prices.length}'),
            create: (context) =>
                getIt<PriceChartBloc>()
                  ..add(PriceChartEvent.historyUpdated(prices)),
            child: BlocListener<PriceChartBloc, PriceChartState>(
              listener: (context, chartState) {
                // Bridge chart interactions
                context.read<CompanySecurityBloc>().add(
                  CompanySecurityEvent.priceAnalyticsUpdated(
                    chartChangeCount: chartState.chartChangeCount,
                    finalTimeframe: chartState.selectedTimeFrame.name,
                  ),
                );
              },
              child: const PriceChartWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
