import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CompanyProfileTourScope extends StatefulWidget {
  static const String scopeName = 'company_profile_tour';

  static final GlobalKey _companyOverviewKey = GlobalKey(
    debugLabel: 'company_profile_tour_company_overview',
  );
  static final GlobalKey _tabsKey = GlobalKey(
    debugLabel: 'company_profile_tour_tabs',
  );
  static final GlobalKey _revenueTabKey = GlobalKey(
    debugLabel: 'company_profile_tour_revenue_tab',
  );
  static final GlobalKey _revenueGrowthKey = GlobalKey(
    debugLabel: 'company_profile_tour_revenue_growth',
  );
  static final GlobalKey _stayUpdatedKey = GlobalKey(
    debugLabel: 'company_profile_tour_stay_updated',
  );

  final Widget child;

  const CompanyProfileTourScope({super.key, required this.child});

  static GlobalKey targetKey(CompanyProfileTourStep step) => switch (step) {
    CompanyProfileTourStep.companyOverview => _companyOverviewKey,
    CompanyProfileTourStep.tabs => _tabsKey,
    CompanyProfileTourStep.revenueTab => _revenueTabKey,
    CompanyProfileTourStep.revenueGrowth => _revenueGrowthKey,
    CompanyProfileTourStep.stayUpdated => _stayUpdatedKey,
  };

  static ShowcaseView get showcaseView => ShowcaseView.getNamed(scopeName);

  @override
  State<CompanyProfileTourScope> createState() =>
      _CompanyProfileTourScopeState();
}

class _CompanyProfileTourScopeState extends State<CompanyProfileTourScope> {
  static int _mountedScopeCount = 0;

  @override
  void initState() {
    super.initState();
    if (_mountedScopeCount++ > 0) return;
    ShowcaseView.register(
      scope: CompanyProfileTourScope.scopeName,
      semanticEnable: true,
    );
  }

  @override
  void dispose() {
    if (--_mountedScopeCount == 0) {
      CompanyProfileTourScope.showcaseView.unregister();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
