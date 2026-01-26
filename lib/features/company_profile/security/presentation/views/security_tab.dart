import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bizzie/features/company_profile/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/historical_price_eod/historical_price_eod_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/historical_price_eod/historical_price_eod_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/price_chart_widget.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/security_overview_card.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/upcoming_earnings_widget.dart';
import 'package:bizzie/features/company_profile/security/presentation/widgets/key_metrics_section.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state_extensions.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/historical_price_eod/historical_price_eod_state_extensions.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/price_chart/price_chart_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/price_chart/price_chart_event.dart';
import 'package:bizzie/di/injection.dart';

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
                return _SecurityContent(
                  securityDetails: securityDetails,
                  prices: prices,
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

  const _SecurityContent({required this.securityDetails, required this.prices});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        children: [
          SecurityOverviewCard(
            securityDetails: securityDetails,
            prices: prices,
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
            child: const PriceChartWidget(),
          ),
        ],
      ),
    );
  }
}
