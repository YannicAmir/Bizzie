import 'package:bizzie/app/themes/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_state.dart';
import 'package:bizzie/features/reports/presentation/extensions/reports_state_extensions.dart';

class BizzieBottomNavWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BizzieBottomNavWrapper({super.key, required this.navigationShell});

  void _onTap(BuildContext context, int index) {
    HapticFeedback.lightImpact();
    if (index == navigationShell.currentIndex) {
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    } else {
      navigationShell.goBranch(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color:
                  theme.dividerTheme.color ?? theme.colorScheme.outlineVariant,
              width: theme.dividerTheme.thickness ?? 1.0,
            ),
          ),
        ),
        child: Theme(
          data: theme.copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => _onTap(context, index),
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
                icon: SvgPicture.asset(
                  AppAssets.homeUnselectedIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  AppAssets.homeSelectedIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
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
                icon: SvgPicture.asset(
                  AppAssets.homeProfileUnselectedIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                ),
                activeIcon: SvgPicture.asset(
                  AppAssets.homeProfileSelectedIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
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
        final unreadCount = state.unreadCount(
          context.read<ReportsBloc>().seenWeeklyReportIds,
        );

        return Badge(
          isLabelVisible: unreadCount > 0,
          label: Text(unreadCount > 9 ? '9+' : unreadCount.toString()),
          child: SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isActive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }
}
