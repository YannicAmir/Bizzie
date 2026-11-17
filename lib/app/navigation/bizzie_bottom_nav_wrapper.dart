import 'dart:async';

import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_tour_target.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/extensions/reports_state_extensions.dart';
import 'package:bizzie/features/reports/presentation/utils/reports_badge_formatter.dart';

class BizzieBottomNavWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BizzieBottomNavWrapper({super.key, required this.navigationShell});

  void _onTap(int index) {
    unawaited(HapticFeedback.lightImpact());
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _BottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.dividerTheme.color ?? theme.colorScheme.outlineVariant,
            width: theme.dividerTheme.thickness ?? 1.0,
          ),
        ),
      ),
      child: Theme(
        data: theme.copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Stack(
          children: [
            _BottomNavTabBar(currentIndex: currentIndex, onTap: onTap),
            const Positioned.fill(child: _ReportsTourHighlightArea()),
          ],
        ),
      ),
    );
  }
}

class _BottomNavTabBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavTabBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.colorScheme.surface,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.onSurfaceVariant,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: [
        BottomNavigationBarItem(
          icon: _BottomNavIcon(
            assetPath: AppAssets.homeUnselectedIcon,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          activeIcon: _BottomNavIcon(
            assetPath: AppAssets.homeSelectedIcon,
            color: theme.colorScheme.primary,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _ReportsTabIcon(
            iconPath: AppAssets.homeReportsUnselectedIcon,
            theme: theme,
            isActive: false,
          ),
          activeIcon: _ReportsTabIcon(
            iconPath: AppAssets.homeReportsSelectedIcon,
            theme: theme,
            isActive: true,
          ),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          icon: _BottomNavIcon(
            assetPath: AppAssets.homeProfileUnselectedIcon,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          activeIcon: _BottomNavIcon(
            assetPath: AppAssets.homeProfileSelectedIcon,
            color: theme.colorScheme.primary,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}

class _BottomNavIcon extends StatelessWidget {
  final String assetPath;
  final Color color;

  const _BottomNavIcon({required this.assetPath, required this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}

class _ReportsTourHighlightArea extends StatelessWidget {
  const _ReportsTourHighlightArea();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewPaddingOf(context).bottom,
        ),
        child: const Row(
          children: [
            Spacer(),
            Expanded(
              child: CompanyProfileTourCompanionTarget(
                step: CompanyProfileTourStep.stayUpdated,
                child: SizedBox.expand(),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class _ReportsTabIcon extends StatelessWidget {
  final String iconPath;
  final ThemeData theme;
  final bool isActive;

  const _ReportsTabIcon({
    required this.iconPath,
    required this.theme,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        final unreadCount = state.unreadCount;

        return Badge(
          isLabelVisible: unreadCount > 0,
          label: Text(ReportsBadgeFormatter.formatUnreadCount(unreadCount)),
          child: _BottomNavIcon(
            assetPath: iconPath,
            color: isActive
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
          ),
        );
      },
    );
  }
}
