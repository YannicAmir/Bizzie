import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_bloc.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_state.dart';
import 'package:bizzie/features/company_profile/business/presentation/bloc/company_business_event.dart';
import 'package:bizzie/features/company_profile/business/presentation/widgets/company_info_card.dart';
import 'package:bizzie/features/company_profile/business/presentation/widgets/company_description_card.dart';
import 'package:bizzie/features/company_profile/business/presentation/widgets/sec_filings_card.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BusinessTab extends StatefulWidget {
  final String ticker;

  const BusinessTab({super.key, required this.ticker});

  @override
  State<BusinessTab> createState() => _BusinessTabState();
}

class _BusinessTabState extends State<BusinessTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final businessBloc = context.read<CompanyBusinessBloc>();

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.business.analyticsName,
      onTabShown: () =>
          businessBloc.add(CompanyBusinessEvent.tabShown(widget.ticker)),
      onTabHidden: () =>
          businessBloc.add(const CompanyBusinessEvent.tabHidden()),
      onAppBackgrounded: () =>
          businessBloc.add(const CompanyBusinessEvent.appBackgrounded()),
      onAppForegrounded: () =>
          businessBloc.add(const CompanyBusinessEvent.appForegrounded()),
      child: BlocBuilder<CompanyBusinessBloc, CompanyBusinessState>(
        builder: (context, state) {
          return state.map(
            initial: (_) =>
                const CompanyProfileLoadingState(message: 'Loading Business'),
            loading: (_) =>
                const CompanyProfileLoadingState(message: 'Loading Business'),
            failure: (f) => CompanyProfileErrorState(
              message: 'Error loading business',
              onRetry: () => context.read<CompanyBusinessBloc>().add(
                CompanyBusinessEvent.loadRequested(widget.ticker),
              ),
            ),
            loaded: (loaded) {
              return _BusinessLoadedView(
                profile: loaded.businessProfile,
                historyLimit: loaded.historyLimit,
              );
            },
          );
        },
      ),
    );
  }
}

class _BusinessLoadedView extends StatelessWidget {
  const _BusinessLoadedView({
    required this.profile,
    required this.historyLimit,
  });

  final BusinessProfile profile;
  final int historyLimit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CompanyInfoCard(profile: profile),
          AppConstants.mainSectionSpacing,
          CompanyDescriptionCard(description: profile.description),
          AppConstants.mainSectionSpacing,
          SecFilingsCard(profile: profile, historyCount: historyLimit),
        ],
      ),
    );
  }
}
