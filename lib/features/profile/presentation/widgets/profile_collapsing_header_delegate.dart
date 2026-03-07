import 'dart:ui';
import 'package:bizzie/app/l10n/bizzie_localizations.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/profile/presentation/l10n/profile_localizations.dart';
import 'package:bizzie/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';

class ProfileCollapsingHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String displayName;
  final String sectorName;
  final double expandedHeight;
  final double topPadding;
  final String? explicitAvatarAsset;

  ProfileCollapsingHeaderDelegate({
    required this.displayName,
    required this.sectorName,
    required this.expandedHeight,
    required this.topPadding,
    this.explicitAvatarAsset,
  });

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + topPadding;

  @override
  bool shouldRebuild(covariant ProfileCollapsingHeaderDelegate oldDelegate) {
    return displayName != oldDelegate.displayName ||
        sectorName != oldDelegate.sectorName ||
        expandedHeight != oldDelegate.expandedHeight ||
        topPadding != oldDelegate.topPadding ||
        explicitAvatarAsset != oldDelegate.explicitAvatarAsset;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    const avatarTop = 156.0;
    const backgroundHeightExpanded = 230.0;
    final nameTopExpanded = expandedHeight - 45.0;
    final nameTopCollapsed = topPadding + (kToolbarHeight / 2) - 12.0;

    final currentBackgroundHeight =
        lerpDouble(backgroundHeightExpanded, minExtent, t) ?? minExtent;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        const SizedBox.expand(),
        SizedBox(
          height: currentBackgroundHeight,
          width: double.infinity,
          child: _HeaderBackground(t: t),
        ),
        Positioned(
          top: avatarTop - shrinkOffset,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: (1 - t * 4).clamp(0.0, 1.0),
            child: Transform.scale(
              scale: (1 - t).clamp(0.0, 1.0),
              child: Center(
                child: ProfileAvatar(
                  assetPath:
                      explicitAvatarAsset ??
                      AppAssets.getMascotForSector(sectorName),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: topPadding + 10,
          left: 16,
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              final isSubscribed = state.maybeMap(
                loaded: (s) => s.user.isSubscribed,
                orElse: () => false,
              );
              if (isSubscribed) {
                return const _PremiumBadge();
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        Positioned(
          top: topPadding + 10,
          right: 16,
          child: const _SettingsButton(),
        ),
        _AnimatedName(
          t: t,
          displayName: displayName,
          expandedTop: nameTopExpanded,
          collapsedTop: nameTopCollapsed,
          shrinkOffset: shrinkOffset,
        ),
      ],
    );
  }
}

class _HeaderBackground extends StatelessWidget {
  final double t;
  const _HeaderBackground({required this.t});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipPath(
      clipper: _HeaderCurveClipper(t: t),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: theme.colorScheme.primary,
      ),
    );
  }
}

class _AnimatedName extends StatelessWidget {
  final double t;
  final String displayName;
  final double expandedTop;
  final double collapsedTop;
  final double shrinkOffset;

  const _AnimatedName({
    required this.t,
    required this.displayName,
    required this.expandedTop,
    required this.collapsedTop,
    required this.shrinkOffset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final currentTop = lerpDouble(expandedTop - shrinkOffset, collapsedTop, t)!;

    final style = TextStyle.lerp(
      AppTextStyles.h1.copyWith(color: theme.colorScheme.primary),
      AppTextStyles.h2.copyWith(color: theme.colorScheme.surface),
      t,
    );

    return Positioned(
      top: currentTop,
      left: 0,
      right: 0,
      child: Center(
        child: Text(displayName, style: style, textAlign: TextAlign.center),
      ),
    );
  }
}

class _PremiumBadge extends StatelessWidget {
  const _PremiumBadge();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = BizzieLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.bizziePlusIcon,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(
              theme.colorScheme.surface,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            l10n.bizziePlus,
            style: AppTextStyles.bodySmall.copyWith(
              color: theme.colorScheme.surface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () =>
          context.read<ProfileBloc>().add(const ProfileEvent.settingsClicked()),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.settings, color: theme.colorScheme.surface, size: 20),
      ),
    );
  }
}

class _HeaderCurveClipper extends CustomClipper<Path> {
  final double t;
  _HeaderCurveClipper({required this.t});

  @override
  Path getClip(Size size) {
    final path = Path();
    final curveIntensity = 40.0 * (1 - t);
    final bendIntensity = 20.0 * (1 - t);

    path.lineTo(0, size.height - curveIntensity);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + bendIntensity,
      size.width,
      size.height - curveIntensity,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _HeaderCurveClipper oldClipper) =>
      t != oldClipper.t;
}
