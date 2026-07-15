import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/edit_tabs_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/edit_tabs_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/edit_tabs_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/edit_tabs_notice.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/edit_tabs_row.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_section_divider.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditTabsModal extends StatelessWidget {
  final void Function(TabLayout savedLayout) onSaved;

  const EditTabsModal({super.key, required this.onSaved});

  static void show(
    BuildContext context, {
    required List<CompanyProfileTab> mainTabs,
    required List<CompanyProfileTab> moreTabs,
    required List<CompanyProfileTab> bizziePlusTabs,
    required void Function(TabLayout savedLayout) onSaved,
  }) {
    final isSubscribed = context.read<UserBloc>().state.isSubscribed;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider(
        create: (_) => getIt<EditTabsBloc>()
          ..add(
            EditTabsEvent.started(
              mainTabs: mainTabs,
              moreTabs: moreTabs,
              bizziePlusTabs: bizziePlusTabs,
              isSubscribed: isSubscribed,
            ),
          ),
        child: EditTabsModal(onSaved: onSaved),
      ),
    );
  }

  void _onStateChanged(BuildContext context, EditTabsState state) {
    state.mapOrNull(
      editing: (editing) {
        final notice = editing.notice;
        if (notice == null) return;
        BizzieSnackBar.show(context, message: notice.message);
      },
      saved: (saved) {
        onSaved(saved.layout);
        Navigator.pop(context);
      },
      failure: (failure) {
        BizzieSnackBar.show(
          context,
          message: failure.failure.errorMessage,
          type: BizzieSnackBarType.error,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTabsBloc, EditTabsState>(
      listener: _onStateChanged,
      child: AppBottomModal(
        title: 'Edit Tabs',
        initialChildSize: AppConstants.editTabsModalHeightFactor,
        minChildSize: AppConstants.editTabsModalHeightFactor,
        maxChildSize: AppConstants.editTabsModalHeightFactor,
        builder: (context, scrollController) =>
            _EditTabsContent(scrollController: scrollController),
      ),
    );
  }
}

class _EditTabsContent extends StatelessWidget {
  final ScrollController scrollController;

  const _EditTabsContent({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTabsBloc, EditTabsState>(
      buildWhen: (_, current) =>
          current.mapOrNull(editing: (_) => true) ?? false,
      builder: (context, state) {
        final editing = state.mapOrNull(editing: (s) => s);
        if (editing == null) return const SizedBox.shrink();
        return Column(
          children: [
            Expanded(
              child: _EditTabsList(
                rows: editing.rows,
                scrollController: scrollController,
              ),
            ),
            Padding(
              padding: AppConstants.editTabsSaveButtonPadding,
              child: BizziePrimaryButton(
                title: 'Save',
                isLoading: editing.isSaving,
                onPressed: editing.canSave
                    ? () => context.read<EditTabsBloc>().add(
                        const EditTabsEvent.saveRequested(),
                      )
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EditTabsList extends StatelessWidget {
  final List<EditTabsRow> rows;
  final ScrollController scrollController;

  const _EditTabsList({required this.rows, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      scrollController: scrollController,
      buildDefaultDragHandles: false,
      onReorderItem: (oldIndex, newIndex) => context.read<EditTabsBloc>().add(
        EditTabsEvent.tabReordered(oldIndex: oldIndex, newIndex: newIndex),
      ),
      itemCount: rows.length,
      itemBuilder: (context, index) => _EditTabsRowItem(
        key: rows[index].listKey,
        row: rows[index],
        listIndex: index,
      ),
    );
  }
}

class _EditTabsRowItem extends StatelessWidget {
  final EditTabsRow row;
  final int listIndex;

  const _EditTabsRowItem({
    super.key,
    required this.row,
    required this.listIndex,
  });

  @override
  Widget build(BuildContext context) {
    return row.map(
      mainDivider: (_) => const TabSectionDivider(label: 'Main'),
      security: (_) => const _PinnedSecurityItem(),
      divider: (_) => const TabSectionDivider(label: 'More'),
      bizziePlusDivider: (_) => const TabSectionDivider(label: 'Bizzie Plus'),
      tab: (tabRow) => _DraggableTabItem(
        tab: tabRow.tab,
        listIndex: listIndex,
        isLocked: tabRow.isLocked,
      ),
    );
  }
}

class _PinnedSecurityItem extends StatelessWidget {
  const _PinnedSecurityItem();

  @override
  Widget build(BuildContext context) {
    return _TabItemContainer(
      child: Text(
        CompanyProfileTab.security.label,
        style: AppTextStyles.bodyMedium,
      ),
    );
  }
}

class _DraggableTabItem extends StatelessWidget {
  final CompanyProfileTab tab;
  final int listIndex;
  final bool isLocked;

  const _DraggableTabItem({
    required this.tab,
    required this.listIndex,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _TabItemContainer(
      child: Row(
        children: [
          Expanded(child: Text(tab.label, style: AppTextStyles.bodyMedium)),
          if (isLocked)
            SvgPicture.asset(
              AppAssets.authLockIcon,
              width: AppConstants.editTabsLockIconSize,
              height: AppConstants.editTabsLockIconSize,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            )
          else
            ReorderableDragStartListener(
              index: listIndex,
              child: Icon(
                Icons.drag_handle,
                color: theme.colorScheme.onSurface.withValues(
                  alpha: AppConstants.editTabsDragHandleOpacity,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TabItemContainer extends StatelessWidget {
  final Widget child;

  const _TabItemContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppConstants.selectionModalItemPadding,
      padding: AppConstants.editTabsItemPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: child,
    );
  }
}

const _mainDividerKey = ValueKey<String>('main_divider');
const _securityItemKey = ValueKey<String>('security');
const _moreDividerKey = ValueKey<String>('more_divider');
const _bizziePlusDividerKey = ValueKey<String>('bizzie_plus_divider');

extension on EditTabsRow {
  Key get listKey => map(
    mainDivider: (_) => _mainDividerKey,
    security: (_) => _securityItemKey,
    divider: (_) => _moreDividerKey,
    bizziePlusDivider: (_) => _bizziePlusDividerKey,
    tab: (row) => ValueKey(row.tab.name),
  );
}

extension on EditTabsNotice {
  String get message => map(
    tooManyMainTabs: (notice) =>
        'Main view can hold a maximum of ${notice.maxTabs} tabs',
    tooFewMainTabs: (notice) =>
        'Main view must have at least ${notice.minTabs} tabs',
    tooFewMoreTabs: (notice) =>
        'More view must have at least ${notice.minTabs} tabs',
  );
}
