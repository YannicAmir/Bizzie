import 'package:bizzie/core/data/dtos/company_tabs_config.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/shared/data/interfaces/i_tab_order_local_datasource.dart';
import 'package:bizzie/features/company_profile/shared/data/repositories/tab_order_repository_impl.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTabOrderLocalDataSource extends Mock
    implements ITabOrderLocalDataSource {}

class MockConfigService extends Mock implements IConfigService {}

const tFreePlusNames = [
  'chat',
  'segments',
  'freeCash',
  'fcps',
  'shares',
  'financialStatements',
  'roe',
  'peRatio',
  'pfcfRatio',
];

const tFreeRemoteConfig = CompanyTabsConfig(
  mainTabs: ['business', 'news', 'dividends', 'revenue'],
  moreTabs: ['netIncome', 'eps'],
  bizziePlusTabs: tFreePlusNames,
);

const tPaidRemoteConfig = CompanyTabsConfig(
  mainTabs: [
    'business',
    'news',
    'dividends',
    'revenue',
    'segments',
    'netIncome',
    'eps',
    'freeCash',
    'fcps',
    'shares',
    'financialStatements',
  ],
  moreTabs: ['roe', 'peRatio', 'pfcfRatio', 'chat'],
);

void main() {
  late TabOrderRepositoryImpl repository;
  late MockTabOrderLocalDataSource mockLocalDataSource;
  late MockConfigService mockConfigService;

  setUp(() {
    mockLocalDataSource = MockTabOrderLocalDataSource();
    mockConfigService = MockConfigService();
    when(
      () => mockConfigService.freeUsersCompanyTabsConfig,
    ).thenReturn(tFreeRemoteConfig);
    when(
      () => mockConfigService.paidUsersCompanyTabsConfig,
    ).thenReturn(tPaidRemoteConfig);
    when(() => mockLocalDataSource.getMainTabs()).thenReturn(null);
    when(() => mockLocalDataSource.getMoreTabs()).thenReturn(null);
    repository = TabOrderRepositoryImpl(mockLocalDataSource, mockConfigService);
  });

  group('TabOrderRepositoryImpl', () {
    group('getTabLayout defaults', () {
      test('getTabLayout_freeUserNoStoredLayout_usesRemoteFreeConfig', () {
        // arrange - stubs from setUp: nothing stored, remote configs set

        // act
        final result = repository.getTabLayout(isSubscribed: false);

        // assert
        result.fold((_) => fail('Should return right'), (layout) {
          expect(layout.mainTabs, [
            CompanyProfileTab.business,
            CompanyProfileTab.news,
            CompanyProfileTab.dividends,
            CompanyProfileTab.revenue,
          ]);
          expect(layout.moreTabs, [
            CompanyProfileTab.netIncome,
            CompanyProfileTab.eps,
          ]);
          expect(layout.bizziePlusTabs, [
            CompanyProfileTab.chat,
            CompanyProfileTab.segments,
            CompanyProfileTab.freeCash,
            CompanyProfileTab.fcps,
            CompanyProfileTab.shares,
            CompanyProfileTab.financialStatements,
            CompanyProfileTab.roe,
            CompanyProfileTab.peRatio,
            CompanyProfileTab.pfcfRatio,
          ]);
        });
      });

      test('getTabLayout_paidUserNoStoredLayout_usesRemotePaidConfig', () {
        // arrange - stubs from setUp

        // act
        final result = repository.getTabLayout(isSubscribed: true);

        // assert
        result.fold((_) => fail('Should return right'), (layout) {
          expect(layout.mainTabs, TabLayout.paidDefaultMainTabs);
          expect(layout.moreTabs, [
            CompanyProfileTab.roe,
            CompanyProfileTab.peRatio,
            CompanyProfileTab.pfcfRatio,
            CompanyProfileTab.chat,
          ]);
          expect(layout.bizziePlusTabs, isEmpty);
        });
      });

      test(
        'getTabLayout_remoteFreeMainTabCountAboveTierMax_fallsBackToBundledDefaults',
        () {
          // arrange - 5 remote main tabs + security = 6, above the free max
          when(() => mockConfigService.freeUsersCompanyTabsConfig).thenReturn(
            const CompanyTabsConfig(
              mainTabs: [
                'business',
                'news',
                'dividends',
                'revenue',
                'netIncome',
              ],
              moreTabs: ['eps'],
              bizziePlusTabs: ['chat'],
            ),
          );

          // act
          final result = repository.getTabLayout(isSubscribed: false);

          // assert
          result.fold((_) => fail('Should return right'), (layout) {
            expect(layout.mainTabs, TabLayout.freeDefaultMainTabs);
            expect(layout.moreTabs, TabLayout.freeDefaultMoreTabs);
            expect(
              layout.bizziePlusTabs,
              TabLayout.freeDefaultBizziePlusTabs,
            );
          });
        },
      );

      test(
        'getTabLayout_remoteConfigContainsUnknownPinnedAndDuplicateNames_skipsThem',
        () {
          // arrange - bogus, pinned and duplicate names must all be dropped
          when(() => mockConfigService.freeUsersCompanyTabsConfig).thenReturn(
            const CompanyTabsConfig(
              mainTabs: [
                'security',
                'bogusTab',
                'business',
                'news',
                'business',
                'dividends',
                'revenue',
                'more',
              ],
              moreTabs: ['netIncome', 'eps'],
              bizziePlusTabs: tFreePlusNames,
            ),
          );

          // act
          final result = repository.getTabLayout(isSubscribed: false);

          // assert
          result.fold((_) => fail('Should return right'), (layout) {
            expect(layout.mainTabs, [
              CompanyProfileTab.business,
              CompanyProfileTab.news,
              CompanyProfileTab.dividends,
              CompanyProfileTab.revenue,
            ]);
          });
        },
      );

      test(
        'getTabLayout_tabMissingFromRemoteFreeConfig_isAppendedToMoreTabs',
        () {
          // arrange - eps is in no remote list, so it must surface in more
          when(() => mockConfigService.freeUsersCompanyTabsConfig).thenReturn(
            const CompanyTabsConfig(
              mainTabs: ['business', 'news', 'dividends', 'revenue'],
              moreTabs: ['netIncome'],
              bizziePlusTabs: tFreePlusNames,
            ),
          );

          // act
          final result = repository.getTabLayout(isSubscribed: false);

          // assert
          result.fold((_) => fail('Should return right'), (layout) {
            expect(layout.moreTabs, [
              CompanyProfileTab.netIncome,
              CompanyProfileTab.eps,
            ]);
          });
        },
      );
    });

    group('getTabLayout with stored layout', () {
      test(
        'getTabLayout_freeUserStoredLayoutContainsBizziePlusTab_removesIt',
        () {
          // arrange - chat is a Bizzie Plus tab and must leave the main list
          when(
            () => mockLocalDataSource.getMainTabs(),
          ).thenReturn('business,news,dividends,chat');
          when(
            () => mockLocalDataSource.getMoreTabs(),
          ).thenReturn('netIncome,eps');

          // act
          final result = repository.getTabLayout(isSubscribed: false);

          // assert
          result.fold((_) => fail('Should return right'), (layout) {
            expect(layout.mainTabs, [
              CompanyProfileTab.business,
              CompanyProfileTab.news,
              CompanyProfileTab.dividends,
            ]);
            expect(layout.moreTabs, [
              CompanyProfileTab.netIncome,
              CompanyProfileTab.eps,
              CompanyProfileTab.revenue,
            ]);
            expect(layout.bizziePlusTabs, contains(CompanyProfileTab.chat));
          });
        },
      );

      test(
        'getTabLayout_freeUserStoredMainTabsExceedTierMax_fallsBackToDefaults',
        () {
          // arrange - 5 stored main tabs + security = 6, above the free max
          when(
            () => mockLocalDataSource.getMainTabs(),
          ).thenReturn('business,news,dividends,revenue,netIncome');
          when(() => mockLocalDataSource.getMoreTabs()).thenReturn('eps');

          // act
          final result = repository.getTabLayout(isSubscribed: false);

          // assert
          result.fold((_) => fail('Should return right'), (layout) {
            expect(layout.mainTabs, [
              CompanyProfileTab.business,
              CompanyProfileTab.news,
              CompanyProfileTab.dividends,
              CompanyProfileTab.revenue,
            ]);
            expect(layout.moreTabs, [
              CompanyProfileTab.netIncome,
              CompanyProfileTab.eps,
            ]);
          });
        },
      );

      test(
        'getTabLayout_paidUserStoredLayout_preservesOrderAndAppendsMissing',
        () {
          // arrange - persisted layout predates newer tabs
          when(
            () => mockLocalDataSource.getMainTabs(),
          ).thenReturn('chat,business,revenue,netIncome');
          when(
            () => mockLocalDataSource.getMoreTabs(),
          ).thenReturn('news,dividends');

          // act
          final result = repository.getTabLayout(isSubscribed: true);

          // assert
          result.fold((_) => fail('Should return right'), (layout) {
            expect(layout.mainTabs, [
              CompanyProfileTab.chat,
              CompanyProfileTab.business,
              CompanyProfileTab.revenue,
              CompanyProfileTab.netIncome,
            ]);
            expect(
              layout.moreTabs.take(2),
              [CompanyProfileTab.news, CompanyProfileTab.dividends],
            );
            expect(layout.bizziePlusTabs, isEmpty);

            final allTabs = {...layout.mainTabs, ...layout.moreTabs};
            final expectedTabs = CompanyProfileTab.values
                .where((tab) => !TabLayout.pinnedTabs.contains(tab))
                .toSet();
            expect(allTabs, expectedTabs);
          });
        },
      );

      test('getTabLayout_unknownStoredTabName_skipsItAndKeepsRest', () {
        // arrange - bogusTab simulates a tab removed in a later app version
        when(
          () => mockLocalDataSource.getMainTabs(),
        ).thenReturn('chat,bogusTab,business,revenue,netIncome');

        // act
        final result = repository.getTabLayout(isSubscribed: true);

        // assert
        result.fold((_) => fail('Should return right'), (layout) {
          expect(layout.mainTabs, [
            CompanyProfileTab.chat,
            CompanyProfileTab.business,
            CompanyProfileTab.revenue,
            CompanyProfileTab.netIncome,
          ]);
        });
      });

      test('getTabLayout_tabStoredInBothLists_keepsItInMainTabsOnly', () {
        // arrange - business persisted in both lists (e.g. partial save)
        when(
          () => mockLocalDataSource.getMainTabs(),
        ).thenReturn('chat,business,revenue,netIncome');
        when(
          () => mockLocalDataSource.getMoreTabs(),
        ).thenReturn('news,business,dividends');

        // act
        final result = repository.getTabLayout(isSubscribed: true);

        // assert
        result.fold((_) => fail('Should return right'), (layout) {
          expect(layout.moreTabs, isNot(contains(CompanyProfileTab.business)));
          expect(
            layout.moreTabs.take(2),
            [CompanyProfileTab.news, CompanyProfileTab.dividends],
          );
          final overlap = layout.mainTabs.toSet().intersection(
            layout.moreTabs.toSet(),
          );
          expect(overlap, isEmpty);
        });
      });
    });

    group('saveTabLayout', () {
      test('saveTabLayout_success_persistsEncodedTabNames', () async {
        // arrange
        when(
          () => mockLocalDataSource.setMainTabs(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockLocalDataSource.setMoreTabs(any()),
        ).thenAnswer((_) async {});
        const layout = TabLayout(
          mainTabs: [CompanyProfileTab.chat, CompanyProfileTab.revenue],
          moreTabs: [CompanyProfileTab.segments, CompanyProfileTab.news],
        );

        // act
        final result = await repository.saveTabLayout(layout);

        // assert
        expect(result.isRight(), isTrue);
        verify(
          () => mockLocalDataSource.setMainTabs('chat,revenue'),
        ).called(1);
        verify(
          () => mockLocalDataSource.setMoreTabs('segments,news'),
        ).called(1);
      });

      test('saveTabLayout_storageThrows_returnsLeftCacheFailure', () async {
        // arrange
        when(
          () => mockLocalDataSource.setMainTabs(any()),
        ).thenThrow(Exception('disk full'));
        const layout = TabLayout(
          mainTabs: [CompanyProfileTab.chat],
          moreTabs: [],
        );

        // act
        final result = await repository.saveTabLayout(layout);

        // assert
        expect(result.isLeft(), isTrue);
        verifyNever(() => mockLocalDataSource.setMoreTabs(any()));
      });
    });
  });
}
