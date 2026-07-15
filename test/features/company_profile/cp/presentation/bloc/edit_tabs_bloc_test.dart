import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/edit_tabs_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/edit_tabs_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/edit_tabs_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/models/edit_tabs_notice.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/save_tab_layout_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSaveTabLayoutUseCase extends Mock implements SaveTabLayoutUseCase {}

const tMainTabs = [
  CompanyProfileTab.chat,
  CompanyProfileTab.business,
  CompanyProfileTab.revenue,
  CompanyProfileTab.netIncome,
];
const tMoreTabs = [CompanyProfileTab.news, CompanyProfileTab.dividends];

const tEditing = EditTabsState.editing(
  initialMainTabs: tMainTabs,
  initialMoreTabs: tMoreTabs,
  mainTabs: tMainTabs,
  moreTabs: tMoreTabs,
  isChatLocked: false,
);

const tChangedMainTabs = [
  CompanyProfileTab.business,
  CompanyProfileTab.chat,
  CompanyProfileTab.revenue,
  CompanyProfileTab.netIncome,
];
const tChangedEditing = EditTabsState.editing(
  initialMainTabs: tMainTabs,
  initialMoreTabs: tMoreTabs,
  mainTabs: tChangedMainTabs,
  moreTabs: tMoreTabs,
  isChatLocked: false,
);
const tChangedLayout = TabLayout(
  mainTabs: tChangedMainTabs,
  moreTabs: tMoreTabs,
);

const tFailure = Failure.cache('save failed');

void main() {
  late MockSaveTabLayoutUseCase mockSaveTabLayout;
  late EditTabsBloc bloc;

  setUpAll(() {
    registerFallbackValue(const TabLayout(mainTabs: [], moreTabs: []));
  });

  setUp(() {
    mockSaveTabLayout = MockSaveTabLayoutUseCase();
    bloc = EditTabsBloc(mockSaveTabLayout);
  });

  tearDown(() => bloc.close());

  group('EditTabsBloc', () {
    group('started', () {
      blocTest<EditTabsBloc, EditTabsState>(
        'started_subscribed_emitsEditingWithChatUnlocked',
        build: () => bloc,
        act: (bloc) => bloc.add(
          const EditTabsEvent.started(
            mainTabs: tMainTabs,
            moreTabs: tMoreTabs,
            isSubscribed: true,
          ),
        ),
        expect: () => const [tEditing],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'started_notSubscribed_emitsEditingWithChatLocked',
        build: () => bloc,
        act: (bloc) => bloc.add(
          const EditTabsEvent.started(
            mainTabs: tMainTabs,
            moreTabs: tMoreTabs,
            isSubscribed: false,
          ),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: tMainTabs,
            initialMoreTabs: tMoreTabs,
            mainTabs: tMainTabs,
            moreTabs: tMoreTabs,
            isChatLocked: true,
          ),
        ],
      );
    });

    group('tabReordered', () {
      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_stateNotEditing_emitsNothing',
        build: () => bloc,
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 1, newIndex: 2),
        ),
        expect: () => const <EditTabsState>[],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_securityRow_emitsNothing',
        build: () => bloc,
        seed: () => tEditing,
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 0, newIndex: 3),
        ),
        expect: () => const <EditTabsState>[],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_lockedChatRow_emitsNothing',
        build: () => bloc,
        // Rows: security(0), locked chat(1), business(2), revenue(3),
        // netIncome(4), divider(5), news(6).
        seed: () => const EditTabsState.editing(
          initialMainTabs: tMainTabs,
          initialMoreTabs: [CompanyProfileTab.news],
          mainTabs: tMainTabs,
          moreTabs: [CompanyProfileTab.news],
          isChatLocked: true,
        ),
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 1, newIndex: 4),
        ),
        expect: () => const <EditTabsState>[],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_mainTabIntoMoreSection_emitsUpdatedLayout',
        build: () => bloc,
        seed: () => tEditing,
        // Rows: security(0), chat(1), business(2), revenue(3), netIncome(4),
        // divider(5), news(6), dividends(7). Move netIncome below the divider.
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 4, newIndex: 6),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: tMainTabs,
            initialMoreTabs: tMoreTabs,
            mainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.revenue,
            ],
            moreTabs: [
              CompanyProfileTab.news,
              CompanyProfileTab.netIncome,
              CompanyProfileTab.dividends,
            ],
            isChatLocked: false,
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_targetAboveLockedChat_clampsBelowLockedRows',
        build: () => bloc,
        // Rows: security(0), locked chat(1), business(2), revenue(3),
        // netIncome(4), divider(5), news(6). Dragging netIncome to index 0
        // must clamp the insert to index 2 (below security and locked chat).
        seed: () => const EditTabsState.editing(
          initialMainTabs: tMainTabs,
          initialMoreTabs: [CompanyProfileTab.news],
          mainTabs: tMainTabs,
          moreTabs: [CompanyProfileTab.news],
          isChatLocked: true,
        ),
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 4, newIndex: 0),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: tMainTabs,
            initialMoreTabs: [CompanyProfileTab.news],
            mainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.netIncome,
              CompanyProfileTab.business,
              CompanyProfileTab.revenue,
            ],
            moreTabs: [CompanyProfileTab.news],
            isChatLocked: true,
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_wouldExceedMaxMainTabs_emitsTooManyMainTabsNotice',
        build: () => bloc,
        // 11 main tabs + pinned Security = 12 (the max). Pulling roe(13) into
        // the main section would make 13, so the reorder is rejected.
        seed: () => const EditTabsState.editing(
          initialMainTabs: [
            CompanyProfileTab.chat,
            CompanyProfileTab.business,
            CompanyProfileTab.news,
            CompanyProfileTab.dividends,
            CompanyProfileTab.revenue,
            CompanyProfileTab.netIncome,
            CompanyProfileTab.eps,
            CompanyProfileTab.freeCash,
            CompanyProfileTab.fcps,
            CompanyProfileTab.shares,
            CompanyProfileTab.financialStatements,
          ],
          initialMoreTabs: [
            CompanyProfileTab.roe,
            CompanyProfileTab.peRatio,
            CompanyProfileTab.pfcfRatio,
          ],
          mainTabs: [
            CompanyProfileTab.chat,
            CompanyProfileTab.business,
            CompanyProfileTab.news,
            CompanyProfileTab.dividends,
            CompanyProfileTab.revenue,
            CompanyProfileTab.netIncome,
            CompanyProfileTab.eps,
            CompanyProfileTab.freeCash,
            CompanyProfileTab.fcps,
            CompanyProfileTab.shares,
            CompanyProfileTab.financialStatements,
          ],
          moreTabs: [
            CompanyProfileTab.roe,
            CompanyProfileTab.peRatio,
            CompanyProfileTab.pfcfRatio,
          ],
          isChatLocked: false,
        ),
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 13, newIndex: 5),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.news,
              CompanyProfileTab.dividends,
              CompanyProfileTab.revenue,
              CompanyProfileTab.netIncome,
              CompanyProfileTab.eps,
              CompanyProfileTab.freeCash,
              CompanyProfileTab.fcps,
              CompanyProfileTab.shares,
              CompanyProfileTab.financialStatements,
            ],
            initialMoreTabs: [
              CompanyProfileTab.roe,
              CompanyProfileTab.peRatio,
              CompanyProfileTab.pfcfRatio,
            ],
            mainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.news,
              CompanyProfileTab.dividends,
              CompanyProfileTab.revenue,
              CompanyProfileTab.netIncome,
              CompanyProfileTab.eps,
              CompanyProfileTab.freeCash,
              CompanyProfileTab.fcps,
              CompanyProfileTab.shares,
              CompanyProfileTab.financialStatements,
            ],
            moreTabs: [
              CompanyProfileTab.roe,
              CompanyProfileTab.peRatio,
              CompanyProfileTab.pfcfRatio,
            ],
            isChatLocked: false,
            notice: EditTabsNotice.tooManyMainTabs(TabLayout.maxMainTabs),
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_wouldFallBelowMinMainTabs_emitsTooFewMainTabsNotice',
        build: () => bloc,
        // 3 main tabs + pinned Security = 4 (the min). Moving revenue(3)
        // below the divider would make 3, so the reorder is rejected.
        seed: () => const EditTabsState.editing(
          initialMainTabs: [
            CompanyProfileTab.chat,
            CompanyProfileTab.business,
            CompanyProfileTab.revenue,
          ],
          initialMoreTabs: [CompanyProfileTab.news],
          mainTabs: [
            CompanyProfileTab.chat,
            CompanyProfileTab.business,
            CompanyProfileTab.revenue,
          ],
          moreTabs: [CompanyProfileTab.news],
          isChatLocked: false,
        ),
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 3, newIndex: 5),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.revenue,
            ],
            initialMoreTabs: [CompanyProfileTab.news],
            mainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.revenue,
            ],
            moreTabs: [CompanyProfileTab.news],
            isChatLocked: false,
            notice: EditTabsNotice.tooFewMainTabs(TabLayout.minMainTabs),
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_invalidReorderWithExistingNotice_clearsThenReEmitsNotice',
        build: () => bloc,
        seed: () => const EditTabsState.editing(
          initialMainTabs: [
            CompanyProfileTab.chat,
            CompanyProfileTab.business,
            CompanyProfileTab.revenue,
          ],
          initialMoreTabs: [CompanyProfileTab.news],
          mainTabs: [
            CompanyProfileTab.chat,
            CompanyProfileTab.business,
            CompanyProfileTab.revenue,
          ],
          moreTabs: [CompanyProfileTab.news],
          isChatLocked: false,
          notice: EditTabsNotice.tooFewMainTabs(TabLayout.minMainTabs),
        ),
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 3, newIndex: 5),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.revenue,
            ],
            initialMoreTabs: [CompanyProfileTab.news],
            mainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.revenue,
            ],
            moreTabs: [CompanyProfileTab.news],
            isChatLocked: false,
          ),
          EditTabsState.editing(
            initialMainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.revenue,
            ],
            initialMoreTabs: [CompanyProfileTab.news],
            mainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.revenue,
            ],
            moreTabs: [CompanyProfileTab.news],
            isChatLocked: false,
            notice: EditTabsNotice.tooFewMainTabs(TabLayout.minMainTabs),
          ),
        ],
      );
    });

    group('saveRequested', () {
      blocTest<EditTabsBloc, EditTabsState>(
        'saveRequested_stateNotEditing_doesNothing',
        build: () => bloc,
        act: (bloc) => bloc.add(const EditTabsEvent.saveRequested()),
        expect: () => const <EditTabsState>[],
        verify: (_) {
          verifyNever(() => mockSaveTabLayout(any()));
        },
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'saveRequested_noChanges_doesNothing',
        build: () => bloc,
        seed: () => tEditing,
        act: (bloc) => bloc.add(const EditTabsEvent.saveRequested()),
        expect: () => const <EditTabsState>[],
        verify: (_) {
          verifyNever(() => mockSaveTabLayout(any()));
        },
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'saveRequested_useCaseSucceeds_emitsSavingThenSaved',
        build: () {
          when(
            () => mockSaveTabLayout(any()),
          ).thenAnswer((_) async => const Right(null));
          return bloc;
        },
        seed: () => tChangedEditing,
        act: (bloc) => bloc.add(const EditTabsEvent.saveRequested()),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: tMainTabs,
            initialMoreTabs: tMoreTabs,
            mainTabs: tChangedMainTabs,
            moreTabs: tMoreTabs,
            isChatLocked: false,
            isSaving: true,
          ),
          EditTabsState.saved(tChangedLayout),
        ],
        verify: (_) {
          verify(() => mockSaveTabLayout(tChangedLayout)).called(1);
        },
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'saveRequested_useCaseFails_emitsSavingFailureThenEditingAgain',
        build: () {
          when(
            () => mockSaveTabLayout(any()),
          ).thenAnswer((_) async => const Left(tFailure));
          return bloc;
        },
        seed: () => tChangedEditing,
        act: (bloc) => bloc.add(const EditTabsEvent.saveRequested()),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: tMainTabs,
            initialMoreTabs: tMoreTabs,
            mainTabs: tChangedMainTabs,
            moreTabs: tMoreTabs,
            isChatLocked: false,
            isSaving: true,
          ),
          EditTabsState.failure(tFailure),
          tChangedEditing,
        ],
        verify: (_) {
          verify(() => mockSaveTabLayout(tChangedLayout)).called(1);
        },
      );
    });

    group('reset', () {
      blocTest<EditTabsBloc, EditTabsState>(
        'reset_fromEditing_emitsInitial',
        build: () => bloc,
        seed: () => tEditing,
        act: (bloc) => bloc.add(const EditTabsEvent.reset()),
        expect: () => const [EditTabsState.initial()],
      );
    });
  });
}
