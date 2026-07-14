import 'package:bizzie/features/company_profile/shared/data/interfaces/i_tab_order_local_datasource.dart';
import 'package:bizzie/features/company_profile/shared/data/repositories/tab_order_repository_impl.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_layout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTabOrderLocalDataSource extends Mock
    implements ITabOrderLocalDataSource {}

void main() {
  late TabOrderRepositoryImpl repository;
  late MockTabOrderLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockTabOrderLocalDataSource();
    repository = TabOrderRepositoryImpl(mockLocalDataSource);
  });

  group('TabOrderRepositoryImpl', () {
    group('getTabLayout', () {
      test('getTabLayout_noStoredLayout_returnsDefaults', () {
        // arrange
        when(() => mockLocalDataSource.getMainTabs()).thenReturn(null);
        when(() => mockLocalDataSource.getMoreTabs()).thenReturn(null);

        // act
        final result = repository.getTabLayout();

        // assert
        expect(result.isRight(), isTrue);
        result.fold((_) => fail('Should return right'), (layout) {
          expect(layout.mainTabs, TabLayout.defaultMainTabs);
          expect(layout.moreTabs, TabLayout.defaultMoreTabs);
        });
      });

      test(
        'getTabLayout_storedLayoutMissingNewTabs_appendsMissingToMoreTabs',
        () {
          // arrange - persisted layout predates the segments tab
          when(
            () => mockLocalDataSource.getMainTabs(),
          ).thenReturn('chat,business,revenue,netIncome');
          when(
            () => mockLocalDataSource.getMoreTabs(),
          ).thenReturn('news,dividends');

          // act
          final result = repository.getTabLayout();

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
            expect(layout.moreTabs, contains(CompanyProfileTab.segments));
            expect(
              layout.moreTabs,
              isNot(contains(CompanyProfileTab.security)),
            );
            expect(layout.moreTabs, isNot(contains(CompanyProfileTab.more)));

            final allTabs = {...layout.mainTabs, ...layout.moreTabs};
            final expectedTabs = CompanyProfileTab.values
                .where((tab) => !TabLayout.pinnedTabs.contains(tab))
                .toSet();
            expect(allTabs, expectedTabs);
          });
        },
      );

      test(
        'getTabLayout_storedLayoutContainsAllTabs_preservesStoredOrder',
        () {
          // arrange
          when(
            () => mockLocalDataSource.getMainTabs(),
          ).thenReturn('chat,business,revenue,netIncome,freeCash');
          when(() => mockLocalDataSource.getMoreTabs()).thenReturn(
            'segments,news,dividends,eps,fcps,shares,financialStatements,roe,peRatio,pfcfRatio',
          );

          // act
          final result = repository.getTabLayout();

          // assert
          result.fold((_) => fail('Should return right'), (layout) {
            expect(layout.moreTabs.first, CompanyProfileTab.segments);
            expect(layout.moreTabs.length, 10);
          });
        },
      );

      test(
        'getTabLayout_invalidMainTabCount_fallsBackToDefaultMainTabs',
        () {
          // arrange - two stored main tabs is below the minimum of four
          when(
            () => mockLocalDataSource.getMainTabs(),
          ).thenReturn('chat,business');
          when(() => mockLocalDataSource.getMoreTabs()).thenReturn(null);

          // act
          final result = repository.getTabLayout();

          // assert
          result.fold((_) => fail('Should return right'), (layout) {
            expect(layout.mainTabs, TabLayout.defaultMainTabs);
          });
        },
      );

      test('getTabLayout_unknownStoredTabName_skipsItAndKeepsRest', () {
        // arrange - bogusTab simulates a tab removed in a later app version
        when(
          () => mockLocalDataSource.getMainTabs(),
        ).thenReturn('chat,bogusTab,business,revenue,netIncome');
        when(() => mockLocalDataSource.getMoreTabs()).thenReturn(null);

        // act
        final result = repository.getTabLayout();

        // assert
        expect(result.isRight(), isTrue);
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
        final result = repository.getTabLayout();

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
