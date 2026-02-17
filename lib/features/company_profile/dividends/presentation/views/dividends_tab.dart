import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/dividends/domain/extensions/dividend_event_extensions.dart';
import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_info.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_bloc.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_event.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/bloc/company_dividends/company_dividends_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/widgets/dividends/dividend_overview_section.dart';
import 'package:bizzie/features/company_profile/dividends/presentation/widgets/dividends/dividend_payment_history_section.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DividendsTab extends StatefulWidget {
  final String ticker;

  const DividendsTab({super.key, required this.ticker});

  @override
  State<DividendsTab> createState() => _DividendsTabState();
}

class _DividendsTabState extends State<DividendsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<CompanySecurityBloc, CompanySecurityState>(
      builder: (context, securityState) {
        final currentPrice = securityState.maybeMap(
          loaded: (s) => s.securityDetails.price ?? 0.0,
          orElse: () => 0.0,
        );

        return BlocBuilder<CompanyDividendsBloc, CompanyDividendsState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => const CompanyProfileLoadingState(
                message: 'Loading Dividends',
              ),
              loading: (_) => const CompanyProfileLoadingState(
                message: 'Loading Dividends',
              ),
              error: (e) => CompanyProfileErrorState(
                message: 'Error loading dividends',
                onRetry: () => context.read<CompanyDividendsBloc>().add(
                  CompanyDividendsEvent.loadRequested(widget.ticker),
                ),
              ),
              loaded: (data) => _DividendsLoadedState(
                dividendInfo: data.dividendInfo,
                ticker: widget.ticker,
                currentPrice: currentPrice,
                historyLimit: data.historyLimit,
              ),
            );
          },
        );
      },
    );
  }
}

class _DividendsLoadedState extends StatelessWidget {
  final DividendInfo dividendInfo;
  final String ticker;
  final double currentPrice;
  final int historyLimit;

  const _DividendsLoadedState({
    required this.dividendInfo,
    required this.ticker,
    required this.currentPrice,
    required this.historyLimit,
  });

  @override
  Widget build(BuildContext context) {
    if (dividendInfo.history.isEmpty) {
      return _DividendsEmptyState(ticker: ticker);
    }

    final latest = dividendInfo.history.first;
    final numberFormat = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
      name: 'USD',
    );

    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DividendOverviewSection(
            latestEvent: latest,
            history: dividendInfo.history,
            currentPrice: currentPrice,
          ),
          AppConstants.mainSectionSpacing,
          BizzieExpandableChart(
            data: dividendInfo.history.toChartData(),
            positiveColor: AppColors.primary,
            numberFormat: numberFormat,
            visibleCount: historyLimit,
            thresholdCount: historyLimit,
          ),
          AppConstants.mainSectionSpacing,
          DividendPaymentHistorySection(
            history: dividendInfo.history,
            historyLimit: historyLimit,
          ),
        ],
      ),
    );
  }
}

class _DividendsEmptyState extends StatelessWidget {
  final String ticker;

  const _DividendsEmptyState({required this.ticker});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.maybeMap(
        loaded: (u) => AppAssets.getMascotForSector(u.user.favoriteSector),
        orElse: () => AppAssets.defaultMascot,
      ),
      builder: (context, mascot) {
        return LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: BizzieEmptyState(
                mascotAsset: mascot,
                title: 'No dividend',
                message: '$ticker does not currently pay a dividend',
                isFullPage: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
