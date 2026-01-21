import 'package:bizzie/features/company_profile/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_business/company_business_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_business/company_business_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/business/company_info_card.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_business/company_business_event.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_loading_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/business/company_description_card.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/business/sec_filings_card.dart';
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
    return BlocBuilder<CompanyBusinessBloc, CompanyBusinessState>(
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
            final profile = loaded.businessProfile;
            return _BusinessLoadedView(profile: profile);
          },
        );
      },
    );
  }
}

class _BusinessLoadedView extends StatelessWidget {
  const _BusinessLoadedView({required this.profile});

  final BusinessProfile profile;

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
          SecFilingsCard(
            annualFilings: profile.annualFilings,
            quarterlyFilings: profile.quarterlyFilings,
          ),
        ],
      ),
    );
  }
}
