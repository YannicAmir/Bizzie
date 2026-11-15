import 'dart:async';

import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tour_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/cp/presentation/extensions/company_profile_tour_state_extensions.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/company_profile_tour_request.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_tour_scope.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_bloc.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_state.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/extensions/company_revenue_state_extensions.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/company_security_state.dart';
import 'package:bizzie/features/company_profile/security/presentation/extensions/company_security_state_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

final _logger = BizzieLogger('CompanyProfileTourHost');

const _maxTargetRenderFrames = 30;

class CompanyProfileTourHost extends StatefulWidget {
  final String ticker;
  final CompanyProfileTourRequest request;
  final Widget child;

  const CompanyProfileTourHost({
    super.key,
    required this.ticker,
    required this.request,
    required this.child,
  });

  @override
  State<CompanyProfileTourHost> createState() => _CompanyProfileTourHostState();
}

class _CompanyProfileTourHostState extends State<CompanyProfileTourHost> {
  late final CompanyProfileTourBloc _tourBloc;
  late final ShowcaseView _showcaseView;

  @override
  void initState() {
    super.initState();
    _tourBloc = context.read<CompanyProfileTourBloc>();
    _showcaseView = CompanyProfileTourScope.showcaseView
      ..addOnFinishCallback(_onStepFinished);
    _logger.info(
      'Tour host mounted for ${widget.ticker}, scope '
      '${CompanyProfileTourScope.scopeName} resolved',
    );
    _startWhenSettled(context.read<CompanySecurityBloc>().state);
  }

  @override
  void dispose() {
    _logger.info('Tour host disposed for ${widget.ticker}');
    _showcaseView.removeOnFinishCallback(_onStepFinished);
    _dismissShowcase();
    super.dispose();
  }

  void _onStepFinished() {
    _tourBloc.add(const CompanyProfileTourEvent.stepCompleted());
  }

  void _startWhenSettled(CompanySecurityState securityState) {
    if (securityState.isLoading) return;

    _logger.info('Security settled, tour start requested for ${widget.ticker}');
    _tourBloc.add(
      CompanyProfileTourEvent.started(
        ticker: widget.ticker,
        companyName: securityState.resolvedDetails?.name ?? widget.ticker,
        shouldPromptNotifications: widget.request.shouldPromptNotifications,
      ),
    );
  }

  void _onTourStateChanged(
    BuildContext context,
    CompanyProfileTourState state,
  ) {
    state.mapOrNull(
      active: (active) {
        _dismissShowcase();
        if (!active.isAwaitingRevenueData) {
          _showStepAfterFrame(active.step);
          return;
        }
        _resolveRevenueGrowth(
          context,
          context.read<CompanyRevenueBloc>().state,
        );
      },
      finished: (finished) {
        _dismissShowcase();
        final onTourSkipped = widget.request.onTourSkipped;
        if (finished.wasSkipped && onTourSkipped != null) {
          onTourSkipped();
          return;
        }
        if (finished.shouldPromptNotifications) {
          widget.request.onPromptNotifications();
        }
      },
    );
  }

  void _showStepAfterFrame(
    CompanyProfileTourStep step, {
    int framesWaited = 0,
  }) {
    unawaited(
      WidgetsBinding.instance.endOfFrame.then(
        (_) => _showStep(step, framesWaited: framesWaited),
      ),
    );
  }

  void _showStep(CompanyProfileTourStep step, {required int framesWaited}) {
    if (!mounted || _tourBloc.state.visibleStep != step) return;

    final targetKey = CompanyProfileTourScope.targetKey(step);
    if (_showcaseView.isTargetRendered(targetKey)) {
      _logger.info(
        'Tour step ${step.name} target rendered after $framesWaited frames, '
        'showing',
      );
      _showcaseView.startShowCase([targetKey]);
      return;
    }
    if (framesWaited < _maxTargetRenderFrames) {
      _showStepAfterFrame(step, framesWaited: framesWaited + 1);
      return;
    }
    _logger.info(
      'Tour step ${step.name} target not rendered after $framesWaited frames, '
      'skipping step',
    );
    _tourBloc.add(const CompanyProfileTourEvent.targetUnavailableReported());
  }

  void _resolveRevenueGrowth(
    BuildContext context,
    CompanyRevenueState revenueState,
  ) {
    if (!_tourBloc.state.isAwaitingRevenue) return;

    revenueState.mapOrNull(
      loaded: (loaded) {
        if (loaded.period != FinancialPeriod.annual) {
          context.read<CompanyRevenueBloc>().add(
            const CompanyRevenueEvent.periodChanged(
              period: FinancialPeriod.annual,
            ),
          );
          return;
        }
        _tourBloc.add(
          CompanyProfileTourEvent.revenueGrowthResolved(
            loaded.annualGrowthHighlight,
          ),
        );
      },
      failure: (_) => _tourBloc.add(
        const CompanyProfileTourEvent.revenueGrowthResolved(null),
      ),
    );
  }

  void _dismissShowcase() {
    if (_showcaseView.isShowcaseRunning) _showcaseView.dismiss();
  }

  void _onPopInvoked(bool didPop, Object? _) {
    if (didPop) return;
    _tourBloc.add(const CompanyProfileTourEvent.skipRequested());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CompanySecurityBloc, CompanySecurityState>(
          listenWhen: (previous, current) =>
              previous.isLoading && !current.isLoading,
          listener: (_, state) => _startWhenSettled(state),
        ),
        BlocListener<CompanyProfileTourBloc, CompanyProfileTourState>(
          listener: _onTourStateChanged,
        ),
        BlocListener<CompanyRevenueBloc, CompanyRevenueState>(
          listener: _resolveRevenueGrowth,
        ),
      ],
      child:
          BlocSelector<CompanyProfileTourBloc, CompanyProfileTourState, bool>(
            selector: (state) => state.isTourActive,
            builder: (context, isTourActive) => PopScope(
              canPop: !isTourActive,
              onPopInvokedWithResult: _onPopInvoked,
              child: widget.child,
            ),
          ),
    );
  }
}
