import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/edit_tabs_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/edit_tabs_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/edit_tabs_notice.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/edit_tabs_row.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/save_tab_layout_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('EditTabsBloc');

@injectable
class EditTabsBloc extends Bloc<EditTabsEvent, EditTabsState> {
  static const int _pinnedMainTabCount = 1;
  final SaveTabLayoutUseCase _saveTabLayout;

  EditTabsBloc(SaveTabLayoutUseCase saveTabLayout)
    : _saveTabLayout = saveTabLayout,
      super(const EditTabsState.initial()) {
    on<EditTabsStarted>(_onStarted);
    on<EditTabsTabReordered>(_onTabReordered);
    on<EditTabsSaveRequested>(_onSaveRequested, transformer: droppable());
    on<EditTabsReset>(_onReset);
  }

  void _onStarted(EditTabsStarted event, Emitter<EditTabsState> emit) {
    emit(
      EditTabsState.editing(
        initialMainTabs: event.mainTabs,
        initialMoreTabs: event.moreTabs,
        mainTabs: event.mainTabs,
        moreTabs: event.moreTabs,
        isChatLocked: !event.isSubscribed,
      ),
    );
  }

  void _onTabReordered(
    EditTabsTabReordered event,
    Emitter<EditTabsState> emit,
  ) {
    final editing = state.mapOrNull(editing: (s) => s);
    if (editing == null) return;

    final rows = editing.rows;
    final dragging = rows[event.oldIndex];
    if (!dragging.isDraggable) return;

    rows.removeAt(event.oldIndex);
    final minInsertIndex = editing.isChatLocked ? 2 : 1;
    final insertIndex = event.newIndex.clamp(minInsertIndex, rows.length);
    rows.insert(insertIndex, dragging);

    final layout = _partition(rows);
    final notice = _validate(layout);
    if (notice != null) {
      _emitNotice(editing, notice, emit);
      return;
    }

    emit(
      editing.copyWith(
        mainTabs: layout.mainTabs,
        moreTabs: layout.moreTabs,
        notice: null,
      ),
    );
  }

  Future<void> _onSaveRequested(
    EditTabsSaveRequested event,
    Emitter<EditTabsState> emit,
  ) async {
    final editing = state.mapOrNull(editing: (s) => s);
    if (editing == null || !editing.canSave) return;

    emit(editing.copyWith(isSaving: true, notice: null));
    final layout = TabLayout(
      mainTabs: editing.mainTabs,
      moreTabs: editing.moreTabs,
    );
    final result = await _saveTabLayout(layout);
    result.fold((failure) {
      _logger.warning('Failed to save tab layout: $failure');
      emit(EditTabsState.failure(failure));
      emit(editing.copyWith(isSaving: false));
    }, (_) => emit(EditTabsState.saved(layout)));
  }

  void _onReset(EditTabsReset event, Emitter<EditTabsState> emit) {
    emit(const EditTabsState.initial());
  }

  TabLayout _partition(List<EditTabsRow> rows) {
    final mainTabs = <CompanyProfileTab>[];
    final moreTabs = <CompanyProfileTab>[];
    var inMore = false;
    for (final row in rows) {
      switch (row) {
        case EditTabsSecurityRow():
          break;
        case EditTabsDividerRow():
          inMore = true;
        case EditTabsTabRow(:final tab):
          (inMore ? moreTabs : mainTabs).add(tab);
      }
    }
    return TabLayout(mainTabs: mainTabs, moreTabs: moreTabs);
  }

  EditTabsNotice? _validate(TabLayout layout) {
    final mainTabCount = layout.mainTabs.length + _pinnedMainTabCount;
    if (mainTabCount > TabLayout.maxMainTabs) {
      return const EditTabsNotice.tooManyMainTabs(TabLayout.maxMainTabs);
    }
    if (mainTabCount < TabLayout.minMainTabs) {
      return const EditTabsNotice.tooFewMainTabs(TabLayout.minMainTabs);
    }
    return null;
  }

  void _emitNotice(
    EditTabsEditing editing,
    EditTabsNotice notice,
    Emitter<EditTabsState> emit,
  ) {
    emit(editing.copyWith(notice: null));
    emit(editing.copyWith(notice: notice));
  }
}
