import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_bloc.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_event.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_state.dart';
import 'package:bizzie/features/company_profile/segments/presentation/extensions/company_segments_state_extensions.dart';
import 'package:bizzie/features/company_profile/segments/presentation/utils/segment_period_key.dart';
import 'package:bizzie/features/company_profile/segments/presentation/widgets/segment_breakdown_section.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_selector_dropdown.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SegmentsTab extends StatefulWidget {
  final String ticker;

  const SegmentsTab({super.key, required this.ticker});

  @override
  State<SegmentsTab> createState() => _SegmentsTabState();
}

class _SegmentsTabState extends State<SegmentsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<CompanySegmentsBloc>().add(
      CompanySegmentsEvent.stalenessCheckRequested(widget.ticker),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.segments.analyticsName,
      onTabShown: () => context.read<CompanySegmentsBloc>().add(
        CompanySegmentsEvent.tabShown(widget.ticker),
      ),
      onTabHidden: () => context.read<CompanySegmentsBloc>().add(
        const CompanySegmentsEvent.tabHidden(),
      ),
      onAppBackgrounded: () => context.read<CompanySegmentsBloc>().add(
        const CompanySegmentsEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<CompanySegmentsBloc>().add(
        const CompanySegmentsEvent.appForegrounded(),
      ),
      child: BlocBuilder<CompanySegmentsBloc, CompanySegmentsState>(
        builder: (context, state) {
          return state.map(
            initial: (_) =>
                const CompanyProfileLoadingState(message: 'Loading Segments'),
            loading: (_) =>
                const CompanyProfileLoadingState(message: 'Loading Segments'),
            failure: (_) => CompanyProfileErrorState(
              message: 'Error loading segments',
              onRetry: () => context.read<CompanySegmentsBloc>().add(
                CompanySegmentsEvent.loadRequested(
                  widget.ticker,
                  forceRefresh: true,
                ),
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
  final CompanySegmentsLoaded state;

  const _LoadedView({required this.state});

  @override
  Widget build(BuildContext context) {
    final isAnnual = state.isAnnualView;
    final keys = state.periodKeys(isAnnual: isAnnual);

    if (keys.isEmpty) {
      return _SegmentsTabShell(
        isAnnual: isAnnual,
        children: const [
          AppConstants.emptyStateTopSpacing,
          BizzieEmptyState(
            mascotAsset: AppAssets.defaultMascot,
            message: 'No segment data available for this period.',
          ),
        ],
      );
    }

    final selectedKey = state.selectedKey(isAnnual: isAnnual) ?? keys.first;
    final previousKey = SegmentPeriodKey.previous(
      selectedKey,
      isAnnual: isAnnual,
    );

    return _SegmentsTabShell(
      isAnnual: isAnnual,
      children: [
        AppConstants.mainSectionSpacing,
        _PeriodDropdown(
          state: state,
          keys: keys,
          selectedKey: selectedKey,
          isAnnual: isAnnual,
        ),
        AppConstants.mainSectionSpacing,
        _SegmentBreakdown(
          kind: _SegmentBreakdownKind.product,
          state: state,
          isAnnual: isAnnual,
          selectedKey: selectedKey,
          previousKey: previousKey,
        ),
        AppConstants.mainSectionSpacing,
        _SegmentBreakdown(
          kind: _SegmentBreakdownKind.geographic,
          state: state,
          isAnnual: isAnnual,
          selectedKey: selectedKey,
          previousKey: previousKey,
        ),
      ],
    );
  }
}

class _SegmentsTabShell extends StatelessWidget {
  final bool isAnnual;
  final List<Widget> children;

  const _SegmentsTabShell({required this.isAnnual, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_PeriodSwitch(isAnnual: isAnnual), ...children],
      ),
    );
  }
}

class _PeriodDropdown extends StatelessWidget {
  final CompanySegmentsLoaded state;
  final List<String> keys;
  final String selectedKey;
  final bool isAnnual;

  const _PeriodDropdown({
    required this.state,
    required this.keys,
    required this.selectedKey,
    required this.isAnnual,
  });

  @override
  Widget build(BuildContext context) {
    return PeriodSelectorDropdown<String>(
      items: keys,
      selectedItem: selectedKey,
      onItemSelected: (key) => context.read<CompanySegmentsBloc>().add(
        CompanySegmentsEvent.periodKeySelected(key, isAnnual: isAnnual),
      ),
      dateStringExtractor: (key) => state.pairLabel(key, isAnnual: isAnnual),
      modalTitle: 'Segment Periods',
      historyLimit: state.historyLimit,
    );
  }
}

enum _SegmentBreakdownKind {
  product(title: 'Product Revenue', keyPrefix: 'product'),
  geographic(title: 'Geographic Revenue', keyPrefix: 'geographic');

  const _SegmentBreakdownKind({required this.title, required this.keyPrefix});

  final String title;
  final String keyPrefix;
}

class _SegmentBreakdown extends StatelessWidget {
  final _SegmentBreakdownKind kind;
  final CompanySegmentsLoaded state;
  final bool isAnnual;
  final String selectedKey;
  final String? previousKey;

  const _SegmentBreakdown({
    required this.kind,
    required this.state,
    required this.isAnnual,
    required this.selectedKey,
    required this.previousKey,
  });

  RevenueSegment? _segmentForKey(String? key) => switch (kind) {
    _SegmentBreakdownKind.product => state.productSegmentForKey(
      key,
      isAnnual: isAnnual,
    ),
    _SegmentBreakdownKind.geographic => state.geographicSegmentForKey(
      key,
      isAnnual: isAnnual,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return SegmentBreakdownSection(
      key: ValueKey('${kind.keyPrefix}_${isAnnual}_$selectedKey'),
      title: kind.title,
      current: _segmentForKey(selectedKey),
      previous: _segmentForKey(previousKey),
      currentLabel: selectedKey,
      previousLabel: previousKey,
      colorIndices: switch (kind) {
        _SegmentBreakdownKind.product => state.productColorIndices,
        _SegmentBreakdownKind.geographic => state.geographicColorIndices,
      },
      currency: state.reportedCurrency,
      isAnnual: isAnnual,
    );
  }
}

class _PeriodSwitch extends StatelessWidget {
  final bool isAnnual;

  const _PeriodSwitch({required this.isAnnual});

  @override
  Widget build(BuildContext context) {
    return BizzieSwitch(
      options: const ['Yearly', 'Quarterly'],
      selectedIndex: isAnnual ? 0 : 1,
      onChanged: (index) => context.read<CompanySegmentsBloc>().add(
        CompanySegmentsEvent.periodChanged(isAnnual: index == 0),
      ),
    );
  }
}
