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

// Paid-tier fixtures: main 4 (+ security = 5, within 3..12), more 3 (min 3).
const tMainTabs = [
  CompanyProfileTab.chat,
  CompanyProfileTab.business,
  CompanyProfileTab.revenue,
  CompanyProfileTab.netIncome,
];
const tMoreTabs = [
  CompanyProfileTab.news,
  CompanyProfileTab.dividends,
  CompanyProfileTab.roe,
];

const tEditing = EditTabsState.editing(
  initialMainTabs: tMainTabs,
  initialMoreTabs: tMoreTabs,
  mainTabs: tMainTabs,
  moreTabs: tMoreTabs,
  bizziePlusTabs: [],
  isSubscribed: true,
);

// Free-tier fixtures: main 4 (+ security = 5, the max), more 2 (min 2).
const fMainTabs = [
  CompanyProfileTab.business,
  CompanyProfileTab.news,
  CompanyProfileTab.dividends,
  CompanyProfileTab.revenue,
];
const fMoreTabs = [CompanyProfileTab.netIncome, CompanyProfileTab.eps];
const fPlusTabs = [CompanyProfileTab.chat, CompanyProfileTab.segments];

const fEditing = EditTabsState.editing(
  initialMainTabs: fMainTabs,
  initialMoreTabs: fMoreTabs,
  mainTabs: fMainTabs,
  moreTabs: fMoreTabs,
  bizziePlusTabs: fPlusTabs,
  isSubscribed: false,
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
  bizziePlusTabs: [],
  isSubscribed: true,
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
        'started_subscribed_emitsEditingWithoutBizziePlusTabs',
        build: () => bloc,
        act: (bloc) => bloc.add(
          const EditTabsEvent.started(
            mainTabs: tMainTabs,
            moreTabs: tMoreTabs,
            bizziePlusTabs: fPlusTabs,
            isSubscribed: true,
          ),
        ),
        expect: () => const [tEditing],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'started_notSubscribed_emitsEditingWithBizziePlusTabs',
        build: () => bloc,
        act: (bloc) => bloc.add(
          const EditTabsEvent.started(
            mainTabs: fMainTabs,
            moreTabs: fMoreTabs,
            bizziePlusTabs: fPlusTabs,
            isSubscribed: false,
          ),
        ),
        expect: () => const [fEditing],
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
          const EditTabsEvent.tabReordered(oldIndex: 1, newIndex: 4),
        ),
        expect: () => const <EditTabsState>[],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_lockedBizziePlusRow_emitsNothing',
        build: () => bloc,
        // Free rows: mainDivider(0), security(1), business(2), news(3),
        // dividends(4), revenue(5), divider(6), netIncome(7), eps(8),
        // plusDivider(9), chat(10, locked), segments(11, locked).
        seed: () => fEditing,
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 10, newIndex: 3),
        ),
        expect: () => const <EditTabsState>[],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_mainTabIntoMoreSection_emitsUpdatedLayout',
        build: () => bloc,
        seed: () => tEditing,
        // Paid rows: mainDivider(0), security(1), chat(2), business(3),
        // revenue(4), netIncome(5), divider(6), news(7), dividends(8),
        // roe(9). Move netIncome below the divider.
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 5, newIndex: 7),
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
              CompanyProfileTab.roe,
            ],
            bizziePlusTabs: [],
            isSubscribed: true,
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_targetAboveSecurity_clampsBelowSecurityRow',
        build: () => bloc,
        seed: () => tEditing,
        // Dragging netIncome(5) to index 0 must clamp the insert to index 2
        // (below the 'Main' header and the pinned security row).
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 5, newIndex: 0),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: tMainTabs,
            initialMoreTabs: tMoreTabs,
            mainTabs: [
              CompanyProfileTab.netIncome,
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.revenue,
            ],
            moreTabs: tMoreTabs,
            bizziePlusTabs: [],
            isSubscribed: true,
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_targetInsideBizziePlusSection_clampsAboveIt',
        build: () => bloc,
        // Free rows: mainDivider(0), security(1), business(2), news(3),
        // dividends(4), revenue(5), divider(6), netIncome(7), eps(8),
        // plusDivider(9), chat(10), segments(11). Dragging netIncome to the
        // very end must clamp the insert above the Bizzie Plus divider.
        seed: () => fEditing,
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 7, newIndex: 12),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: fMainTabs,
            initialMoreTabs: fMoreTabs,
            mainTabs: fMainTabs,
            moreTabs: [CompanyProfileTab.eps, CompanyProfileTab.netIncome],
            bizziePlusTabs: fPlusTabs,
            isSubscribed: false,
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_wouldExceedFreeMaxMainTabs_emitsTooManyMainTabsNotice',
        build: () => bloc,
        // Free main is at its max (4 + security = 5). Pulling netIncome(7)
        // into the main section would make 6, so the reorder is rejected.
        seed: () => fEditing,
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 7, newIndex: 3),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: fMainTabs,
            initialMoreTabs: fMoreTabs,
            mainTabs: fMainTabs,
            moreTabs: fMoreTabs,
            bizziePlusTabs: fPlusTabs,
            isSubscribed: false,
            notice: EditTabsNotice.tooManyMainTabs(TabLayout.freeMaxMainTabs),
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_wouldFallBelowFreeMinMoreTabs_emitsTooFewMoreTabsNotice',
        build: () => bloc,
        // Free rows: mainDivider(0), security(1), business(2), news(3),
        // dividends(4), divider(5), revenue(6), netIncome(7), plusDivider(8),
        // chat(9). Moving netIncome into main leaves one more tab, below
        // the min of 2.
        seed: () => const EditTabsState.editing(
          initialMainTabs: [
            CompanyProfileTab.business,
            CompanyProfileTab.news,
            CompanyProfileTab.dividends,
          ],
          initialMoreTabs: [
            CompanyProfileTab.revenue,
            CompanyProfileTab.netIncome,
          ],
          mainTabs: [
            CompanyProfileTab.business,
            CompanyProfileTab.news,
            CompanyProfileTab.dividends,
          ],
          moreTabs: [CompanyProfileTab.revenue, CompanyProfileTab.netIncome],
          bizziePlusTabs: [CompanyProfileTab.chat],
          isSubscribed: false,
        ),
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 7, newIndex: 2),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: [
              CompanyProfileTab.business,
              CompanyProfileTab.news,
              CompanyProfileTab.dividends,
            ],
            initialMoreTabs: [
              CompanyProfileTab.revenue,
              CompanyProfileTab.netIncome,
            ],
            mainTabs: [
              CompanyProfileTab.business,
              CompanyProfileTab.news,
              CompanyProfileTab.dividends,
            ],
            moreTabs: [CompanyProfileTab.revenue, CompanyProfileTab.netIncome],
            bizziePlusTabs: [CompanyProfileTab.chat],
            isSubscribed: false,
            notice: EditTabsNotice.tooFewMoreTabs(TabLayout.freeMinMoreTabs),
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_wouldFallBelowPaidMinMainTabs_emitsTooFewMainTabsNotice',
        build: () => bloc,
        // Paid rows: mainDivider(0), security(1), chat(2), business(3),
        // divider(4), news(5), dividends(6), revenue(7). Main is at the paid
        // min of 3 incl. security; moving business below the divider is
        // rejected.
        seed: () => const EditTabsState.editing(
          initialMainTabs: [CompanyProfileTab.chat, CompanyProfileTab.business],
          initialMoreTabs: [
            CompanyProfileTab.news,
            CompanyProfileTab.dividends,
            CompanyProfileTab.revenue,
          ],
          mainTabs: [CompanyProfileTab.chat, CompanyProfileTab.business],
          moreTabs: [
            CompanyProfileTab.news,
            CompanyProfileTab.dividends,
            CompanyProfileTab.revenue,
          ],
          bizziePlusTabs: [],
          isSubscribed: true,
        ),
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 3, newIndex: 5),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
            ],
            initialMoreTabs: [
              CompanyProfileTab.news,
              CompanyProfileTab.dividends,
              CompanyProfileTab.revenue,
            ],
            mainTabs: [CompanyProfileTab.chat, CompanyProfileTab.business],
            moreTabs: [
              CompanyProfileTab.news,
              CompanyProfileTab.dividends,
              CompanyProfileTab.revenue,
            ],
            bizziePlusTabs: [],
            isSubscribed: true,
            notice: EditTabsNotice.tooFewMainTabs(TabLayout.paidMinMainTabs),
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_wouldFallBelowPaidMinMoreTabs_emitsTooFewMoreTabsNotice',
        build: () => bloc,
        // Paid more is at its min of 3; pulling news(6) into main is rejected.
        seed: () => tEditing,
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 7, newIndex: 3),
        ),
        expect: () => const [
          EditTabsState.editing(
            initialMainTabs: tMainTabs,
            initialMoreTabs: tMoreTabs,
            mainTabs: tMainTabs,
            moreTabs: tMoreTabs,
            bizziePlusTabs: [],
            isSubscribed: true,
            notice: EditTabsNotice.tooFewMoreTabs(TabLayout.paidMinMoreTabs),
          ),
        ],
      );

      blocTest<EditTabsBloc, EditTabsState>(
        'tabReordered_invalidReorderWithExistingNotice_clearsThenReEmitsNotice',
        build: () => bloc,
        seed: () => const EditTabsState.editing(
          initialMainTabs: tMainTabs,
          initialMoreTabs: tMoreTabs,
          mainTabs: tMainTabs,
          moreTabs: tMoreTabs,
          bizziePlusTabs: [],
          isSubscribed: true,
          notice: EditTabsNotice.tooFewMoreTabs(TabLayout.paidMinMoreTabs),
        ),
        act: (bloc) => bloc.add(
          const EditTabsEvent.tabReordered(oldIndex: 7, newIndex: 3),
        ),
        expect: () => const [
          tEditing,
          EditTabsState.editing(
            initialMainTabs: tMainTabs,
            initialMoreTabs: tMoreTabs,
            mainTabs: tMainTabs,
            moreTabs: tMoreTabs,
            bizziePlusTabs: [],
            isSubscribed: true,
            notice: EditTabsNotice.tooFewMoreTabs(TabLayout.paidMinMoreTabs),
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
            bizziePlusTabs: [],
            isSubscribed: true,
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
            bizziePlusTabs: [],
            isSubscribed: true,
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
