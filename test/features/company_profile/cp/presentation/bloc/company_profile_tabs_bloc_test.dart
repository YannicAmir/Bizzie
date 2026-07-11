import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_event.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_tabs_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/get_tab_layout_usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/set_active_tab_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTabLayoutUseCase extends Mock implements GetTabLayoutUseCase {}

class MockSetActiveTabUseCase extends Mock implements SetActiveTabUseCase {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late MockGetTabLayoutUseCase mockGetTabLayout;
  late MockSetActiveTabUseCase mockSetActiveTab;
  late MockConfigService mockConfigService;

  const ticker = 'AAPL';
  const layout = TabLayout(
    mainTabs: [CompanyProfileTab.business, CompanyProfileTab.news],
    moreTabs: [CompanyProfileTab.roe, CompanyProfileTab.dividends],
  );
  const loadedState = CompanyProfileTabsState.loaded(
    mainTabs: [CompanyProfileTab.business, CompanyProfileTab.news],
    moreTabs: [CompanyProfileTab.roe, CompanyProfileTab.dividends],
    isBizzieChatEnabled: true,
  );

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      const TabActivation(tab: CompanyProfileTab.business, ticker: ticker),
    );
  });

  setUp(() {
    mockGetTabLayout = MockGetTabLayoutUseCase();
    mockSetActiveTab = MockSetActiveTabUseCase();
    mockConfigService = MockConfigService();

    when(() => mockGetTabLayout(any())).thenReturn(const Right(layout));
    when(() => mockSetActiveTab(any())).thenAnswer((_) {});
    when(() => mockConfigService.bizzieChatEnabled).thenReturn(true);
  });

  CompanyProfileTabsBloc buildBloc() => CompanyProfileTabsBloc(
    mockGetTabLayout,
    mockSetActiveTab,
    mockConfigService,
  );

  group('CompanyProfileTabsBloc', () {
    test('constructor_beforeStarted_isInitialState', () {
      final bloc = buildBloc();

      expect(bloc.state, const CompanyProfileTabsState.initial());
      expect(bloc.state.mainTabs, TabLayout.defaults().mainTabs);
      expect(bloc.state.moreTabs, TabLayout.defaults().moreTabs);
      expect(bloc.state.isBizzieChatEnabled, isFalse);
      verifyNever(() => mockGetTabLayout(any()));
      bloc.close();
    });

    blocTest<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      'started_layoutAvailable_emitsLayoutWithConfigFlag',
      build: buildBloc,
      act: (bloc) => bloc.add(const CompanyProfileTabsEvent.started()),
      expect: () => const [loadedState],
    );

    blocTest<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      'started_layoutLoadFails_fallsBackToDefaultLayout',
      build: () {
        when(
          () => mockGetTabLayout(any()),
        ).thenReturn(const Left(Failure.cache('read failed')));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const CompanyProfileTabsEvent.started()),
      verify: (bloc) {
        expect(bloc.state.mainTabs, TabLayout.defaults().mainTabs);
        expect(bloc.state.moreTabs, TabLayout.defaults().moreTabs);
        expect(bloc.state.isBizzieChatEnabled, isTrue);
      },
    );

    blocTest<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      'tabs_always_pinsSecurityFirstAndMoreLast',
      build: buildBloc,
      act: (bloc) => bloc.add(const CompanyProfileTabsEvent.started()),
      verify: (bloc) {
        expect(bloc.state.tabs.first, CompanyProfileTab.security);
        expect(bloc.state.tabs.last, CompanyProfileTab.more);
        expect(
          bloc.state.tabs,
          const [
            CompanyProfileTab.security,
            CompanyProfileTab.business,
            CompanyProfileTab.news,
            CompanyProfileTab.more,
          ],
        );
      },
    );

    blocTest<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      'tabActivated_regularTab_publishesActivationForThatTab',
      build: buildBloc,
      seed: () => loadedState,
      act: (bloc) => bloc.add(
        const CompanyProfileTabsEvent.tabActivated(
          tab: CompanyProfileTab.business,
          ticker: ticker,
        ),
      ),
      expect: () => const <CompanyProfileTabsState>[],
      verify: (_) {
        verify(
          () => mockSetActiveTab(
            const TabActivation(tab: CompanyProfileTab.business, ticker: ticker),
          ),
        ).called(1);
      },
    );

    blocTest<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      'tabActivated_moreTab_publishesActivationForSelectedSubTab',
      build: buildBloc,
      seed: () => loadedState,
      act: (bloc) => bloc.add(
        const CompanyProfileTabsEvent.tabActivated(
          tab: CompanyProfileTab.more,
          ticker: ticker,
        ),
      ),
      expect: () => const <CompanyProfileTabsState>[],
      verify: (_) {
        verify(
          () => mockSetActiveTab(
            const TabActivation(tab: CompanyProfileTab.roe, ticker: ticker),
          ),
        ).called(1);
      },
    );

    blocTest<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      'tabActivated_moreTabWithEmptyMoreSection_publishesNothing',
      build: buildBloc,
      seed: () => const CompanyProfileTabsState.loaded(
        mainTabs: [CompanyProfileTab.business],
        moreTabs: [],
        isBizzieChatEnabled: true,
      ),
      act: (bloc) => bloc.add(
        const CompanyProfileTabsEvent.tabActivated(
          tab: CompanyProfileTab.more,
          ticker: ticker,
        ),
      ),
      expect: () => const <CompanyProfileTabsState>[],
      verify: (_) {
        verifyNever(() => mockSetActiveTab(any()));
      },
    );

    blocTest<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      'moreTabIndexChanged_validIndex_updatesIndexAndActivatesSubTab',
      build: buildBloc,
      seed: () => loadedState,
      act: (bloc) => bloc.add(
        const CompanyProfileTabsEvent.moreTabIndexChanged(
          index: 1,
          ticker: ticker,
        ),
      ),
      expect: () => const [
        CompanyProfileTabsState.loaded(
          mainTabs: [CompanyProfileTab.business, CompanyProfileTab.news],
          moreTabs: [CompanyProfileTab.roe, CompanyProfileTab.dividends],
          moreTabIndex: 1,
          isBizzieChatEnabled: true,
        ),
      ],
      verify: (_) {
        verify(
          () => mockSetActiveTab(
            const TabActivation(
              tab: CompanyProfileTab.dividends,
              ticker: ticker,
            ),
          ),
        ).called(1);
      },
    );

    blocTest<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      'tabOrderChanged_layoutSaved_reloadsLayoutIntoState',
      build: buildBloc,
      seed: () => loadedState,
      act: (bloc) {
        when(() => mockGetTabLayout(any())).thenReturn(
          const Right(
            TabLayout(
              mainTabs: [CompanyProfileTab.news],
              moreTabs: [
                CompanyProfileTab.business,
                CompanyProfileTab.roe,
                CompanyProfileTab.dividends,
              ],
            ),
          ),
        );
        bloc.add(const CompanyProfileTabsEvent.tabOrderChanged());
      },
      expect: () => const [
        CompanyProfileTabsState.loaded(
          mainTabs: [CompanyProfileTab.news],
          moreTabs: [
            CompanyProfileTab.business,
            CompanyProfileTab.roe,
            CompanyProfileTab.dividends,
          ],
          isBizzieChatEnabled: true,
        ),
      ],
    );

    blocTest<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      'tabOrderChanged_moreTabIndexOutOfNewBounds_isPreservedForConsumersToClamp',
      build: buildBloc,
      seed: () => const CompanyProfileTabsState.loaded(
        mainTabs: [CompanyProfileTab.business, CompanyProfileTab.news],
        moreTabs: [CompanyProfileTab.roe, CompanyProfileTab.dividends],
        moreTabIndex: 1,
        isBizzieChatEnabled: true,
      ),
      act: (bloc) {
        when(() => mockGetTabLayout(any())).thenReturn(
          const Right(
            TabLayout(
              mainTabs: [
                CompanyProfileTab.business,
                CompanyProfileTab.news,
                CompanyProfileTab.dividends,
              ],
              moreTabs: [CompanyProfileTab.roe],
            ),
          ),
        );
        bloc.add(const CompanyProfileTabsEvent.tabOrderChanged());
      },
      expect: () => const [
        CompanyProfileTabsState.loaded(
          mainTabs: [
            CompanyProfileTab.business,
            CompanyProfileTab.news,
            CompanyProfileTab.dividends,
          ],
          moreTabs: [CompanyProfileTab.roe],
          moreTabIndex: 1,
          isBizzieChatEnabled: true,
        ),
      ],
    );

    blocTest<CompanyProfileTabsBloc, CompanyProfileTabsState>(
      'reset_afterLayoutLoaded_emitsInitialState',
      build: buildBloc,
      seed: () => loadedState.copyWith(moreTabIndex: 1),
      act: (bloc) => bloc.add(const CompanyProfileTabsEvent.reset()),
      expect: () => [const CompanyProfileTabsState.initial()],
    );
  });
}
