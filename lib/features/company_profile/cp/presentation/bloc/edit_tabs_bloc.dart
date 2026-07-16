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

  static const int _firstDraggableRowIndex = 2;
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
        bizziePlusTabs: event.isSubscribed
            ? const <CompanyProfileTab>[]
            : event.bizziePlusTabs,
        isSubscribed: event.isSubscribed,
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
    final insertIndex = event.newIndex.clamp(
      _firstDraggableRowIndex,
      _maxInsertIndex(rows),
    );
    rows.insert(insertIndex, dragging);

    final layout = _partition(rows);
    final notice = _validate(layout, isSubscribed: editing.isSubscribed);
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
      bizziePlusTabs: editing.bizziePlusTabs,
    );
    final result = await _saveTabLayout(layout);
    result.fold((failure) {
      _logger.warning('Failed to save tab layout: $failure');
      emit(EditTabsState.failure(failure));
      emit(editing.copyWith(isSaving: false, notice: null));
    }, (_) => emit(EditTabsState.saved(layout)));
  }

  void _onReset(EditTabsReset event, Emitter<EditTabsState> emit) {
    emit(const EditTabsState.initial());
  }

  int _maxInsertIndex(List<EditTabsRow> rows) {
    final plusDividerIndex = rows.indexWhere(
      (row) => row is EditTabsBizziePlusDividerRow,
    );
    return plusDividerIndex < 0 ? rows.length : plusDividerIndex;
  }

  TabLayout _partition(List<EditTabsRow> rows) {
    final mainTabs = <CompanyProfileTab>[];
    final moreTabs = <CompanyProfileTab>[];
    var inMore = false;
    for (final row in rows) {
      switch (row) {
        case EditTabsMainDividerRow():
        case EditTabsSecurityRow():
          break;
        case EditTabsDividerRow():
          inMore = true;
        case EditTabsBizziePlusDividerRow():
          return TabLayout(mainTabs: mainTabs, moreTabs: moreTabs);
        case EditTabsTabRow(:final tab):
          (inMore ? moreTabs : mainTabs).add(tab);
      }
    }
    return TabLayout(mainTabs: mainTabs, moreTabs: moreTabs);
  }

  EditTabsNotice? _validate(TabLayout layout, {required bool isSubscribed}) {
    final mainTabCount = layout.mainTabs.length + _pinnedMainTabCount;
    final maxMainTabs = TabLayout.maxMainTabsFor(isSubscribed: isSubscribed);
    final minMainTabs = TabLayout.minMainTabsFor(isSubscribed: isSubscribed);
    final minMoreTabs = TabLayout.minMoreTabsFor(isSubscribed: isSubscribed);
    if (mainTabCount > maxMainTabs) {
      return EditTabsNotice.tooManyMainTabs(maxMainTabs);
    }
    if (mainTabCount < minMainTabs) {
      return EditTabsNotice.tooFewMainTabs(minMainTabs);
    }
    if (layout.moreTabs.length < minMoreTabs) {
      return EditTabsNotice.tooFewMoreTabs(minMoreTabs);
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
