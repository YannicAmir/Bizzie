import 'package:bizzie/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_state.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/app/themes/app_assets.dart';
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
              initial: (_) => const SizedBox.shrink(),
              loading: (_) => const Center(child: CircularProgressIndicator()),
              failure: (f) =>
                  Center(child: Text('Error: ${f.failure.toString()}')),
              loaded: (state) {
                final data = state.data;
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
                              assetPath: AppAssets.getMascotForSector(
                                data.sectorName,
                              ),
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
                    Spacer(),
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
              },
            );
          },
        ),
      ),
    );
  }
}
