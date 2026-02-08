import 'package:bizzie/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_state.dart';
import 'package:bizzie/features/profile/domain/models/profile_display_data.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_state_extensions.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:bizzie/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:bizzie/features/profile/presentation/widgets/profile_info_section.dart';
import 'package:bizzie/features/profile/presentation/widgets/profile_premium_card.dart';
import 'package:bizzie/features/profile/presentation/widgets/sector_highlight_card.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => const _ProfileLoadingView(),
              loading: (_) => const _ProfileLoadingView(),
              failure: (f) =>
                  Center(child: Text('Error: ${f.failure.toString()}')),
              loaded: (state) => _ProfileLoadedView(data: state.data),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileLoadingView extends StatelessWidget {
  const _ProfileLoadingView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mascotAsset = context.select(
      (UserBloc bloc) => bloc.state.mascotAsset,
    );

    return Column(
      children: [
        SizedBox(
          height: 310,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              const ProfileHeaderCard(),
              Positioned(
                top: 170,
                child: ProfileAvatar(assetPath: mascotAsset),
              ),
            ],
          ),
        ),
        const SizedBox(height: 104),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 180,
              height: 180,
              child: CircularProgressIndicator(
                strokeWidth: 10,
                color: theme.colorScheme.primary,
              ),
            ),
            Text('Loading Profile', style: AppTextStyles.loaderMessage),
          ],
        ),
      ],
    );
  }
}

class _ProfileLoadedView extends StatelessWidget {
  final ProfileDisplayData data;

  const _ProfileLoadedView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 310,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              const ProfileHeaderCard(),
              Positioned(
                top: 170,
                child: ProfileAvatar(
                  assetPath: AppAssets.getMascotForSector(data.sectorName),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ProfileInfoSection(
          displayName: data.displayName,
          joinedDate: data.joinedDate,
        ),
        const SizedBox(height: 32),
        Padding(
          padding: AppConstants.profileTabWidgetPadding,
          child: SectorHighlightCard(
            sectorName: data.sectorName,
            sectorDescription: data.sectorDescription,
            sectorPe: data.sectorPe,
            sectorAverageChange: data.sectorAverageChange,
            marketDataDate: data.marketDataDate,
          ),
        ),
        const Spacer(),
        BlocBuilder<SubscriptionBloc, SubscriptionState>(
          builder: (context, subState) {
            if (subState.status.isSubscribed) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: AppConstants.profileTabWidgetPadding,
              child: const ProfilePremiumCard(),
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
