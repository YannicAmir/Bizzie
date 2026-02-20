import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/settings/domain/usecases/update_favorite_sector_usecase.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_bloc.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_state.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bizzie/features/settings/presentation/analytics/settings_tracker.dart';

class MockUpdateFavoriteSectorUseCase extends Mock
    implements UpdateFavoriteSectorUseCase {}

class MockSectorService extends Mock implements ISectorService {}

class MockSettingsTracker extends Mock implements SettingsTracker {}

void main() {
  late MockUpdateFavoriteSectorUseCase mockUpdateFavoriteSectorUseCase;
  late MockSectorService mockSectorService;
  late MockSettingsTracker mockTracker;

  setUpAll(() {
    registerFallbackValue(Sector.energy);
  });

  setUp(() {
    mockUpdateFavoriteSectorUseCase = MockUpdateFavoriteSectorUseCase();
    mockSectorService = MockSectorService();
    mockTracker = MockSettingsTracker();

    // Default tracker stubs
    when(() => mockTracker.logSectorChangeViewed()).thenAnswer((_) async {});
    when(
      () => mockTracker.logSectorSelected(sector: any(named: 'sector')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logSectorUpdateSuccess(sector: any(named: 'sector')),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logSectorUpdateFailure(
        sector: any(named: 'sector'),
        error: any(named: 'error'),
      ),
    ).thenAnswer((_) async {});

    // arrange
    when(
      () => mockSectorService.getSectorDisplayName(any()),
    ).thenAnswer((invocation) => invocation.positionalArguments[0] as String);
    when(
      () => mockSectorService.getSectorDescription(any()),
    ).thenReturn('Description');
  });

  group('SelectSectorBloc', () {
    group('initialization', () {
      test(
        'selectSectorBloc_initialState_emitsCorrectInitialFieldsAndLogsView',
        () {
          // arrange
          const initialSector = Sector.healthCare;

          // act
          final bloc = SelectSectorBloc(
            initialSector,
            mockUpdateFavoriteSectorUseCase,
            mockSectorService,
            mockTracker,
          );

          // assert
          expect(bloc.state.initialSector.sector, initialSector);
          expect(bloc.state.availableSectors.first.sector, initialSector);
          verify(() => mockTracker.logSectorChangeViewed()).called(1);
        },
      );

      test('selectSectorBloc_initialStateWithNull_defaultsToITAndLogsView', () {
        // act
        final bloc = SelectSectorBloc(
          null,
          mockUpdateFavoriteSectorUseCase,
          mockSectorService,
          mockTracker,
        );

        // assert
        expect(bloc.state.initialSector.sector, Sector.informationTechnology);
        expect(
          bloc.state.availableSectors.first.sector,
          Sector.informationTechnology,
        );
        verify(() => mockTracker.logSectorChangeViewed()).called(1);
      });
    });

    blocTest<SelectSectorBloc, SelectSectorState>(
      'selectSector_newSectorSelected_emitsStateWithUpdatedSelectionAndLogs',
      build: () => SelectSectorBloc(
        Sector.healthCare,
        mockUpdateFavoriteSectorUseCase,
        mockSectorService,
        mockTracker,
      ),
      act: (bloc) =>
          bloc.add(const SelectSectorEvent.selectSector(Sector.energy)),
      // assert
      expect: () => [
        isA<SelectSectorState>().having(
          (s) => s.selectedSector.sector,
          'selectedSector',
          Sector.energy,
        ),
      ],
      verify: (_) {
        verify(
          () => mockTracker.logSectorSelected(sector: Sector.energy.name),
        ).called(1);
      },
    );

    group('saveChanges', () {
      blocTest<SelectSectorBloc, SelectSectorState>(
        'saveChanges_effectiveChange_emitsLoadingThenSuccessAndLogs',
        // arrange
        setUp: () {
          when(
            () => mockUpdateFavoriteSectorUseCase(any()),
          ).thenAnswer((_) async => const Right(null));
        },
        build: () => SelectSectorBloc(
          Sector.healthCare,
          mockUpdateFavoriteSectorUseCase,
          mockSectorService,
          mockTracker,
        ),
        act: (bloc) {
          bloc.add(const SelectSectorEvent.selectSector(Sector.energy));
          bloc.add(const SelectSectorEvent.saveChanges());
        },
        // assert
        expect: () => [
          isA<SelectSectorState>().having(
            (s) => s.selectedSector.sector,
            'selectedSector',
            Sector.energy,
          ),
          isA<SelectSectorState>().having(
            (s) => s.maybeMap(loading: (_) => true, orElse: () => false),
            'loading',
            true,
          ),
          isA<SelectSectorState>().having(
            (s) => s.maybeMap(success: (_) => true, orElse: () => false),
            'success',
            true,
          ),
        ],
        verify: (_) {
          verify(
            () => mockUpdateFavoriteSectorUseCase(Sector.energy),
          ).called(1);
          verify(
            () =>
                mockTracker.logSectorUpdateSuccess(sector: Sector.energy.name),
          ).called(1);
        },
      );

      blocTest<SelectSectorBloc, SelectSectorState>(
        'saveChanges_noChange_emitsNothing',
        build: () => SelectSectorBloc(
          Sector.healthCare,
          mockUpdateFavoriteSectorUseCase,
          mockSectorService,
          mockTracker,
        ),
        act: (bloc) => bloc.add(const SelectSectorEvent.saveChanges()),
        // assert
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockUpdateFavoriteSectorUseCase(any()));
        },
      );

      blocTest<SelectSectorBloc, SelectSectorState>(
        'saveChanges_onFailure_emitsLoadingThenFailureAndLogs',
        // arrange
        setUp: () {
          when(
            () => mockUpdateFavoriteSectorUseCase(any()),
          ).thenAnswer((_) async => const Left(ServerFailure('Error')));
        },
        build: () => SelectSectorBloc(
          Sector.healthCare,
          mockUpdateFavoriteSectorUseCase,
          mockSectorService,
          mockTracker,
        ),
        act: (bloc) {
          bloc.add(const SelectSectorEvent.selectSector(Sector.energy));
          bloc.add(const SelectSectorEvent.saveChanges());
        },
        // assert
        expect: () => [
          isA<SelectSectorState>().having(
            (s) => s.selectedSector.sector,
            'selectedSector',
            Sector.energy,
          ),
          isA<SelectSectorState>().having(
            (s) => s.maybeMap(loading: (_) => true, orElse: () => false),
            'loading',
            true,
          ),
          isA<SelectSectorState>().having(
            (s) => s.maybeMap(failure: (_) => true, orElse: () => false),
            'failure',
            true,
          ),
        ],
        verify: (_) {
          verify(
            () => mockTracker.logSectorUpdateFailure(
              sector: Sector.energy.name,
              error: 'Error',
            ),
          ).called(1);
        },
      );
    });
    group('Sector Ordering Alphabetical', () {
      test(
        'selectSectorBloc_availableSectors_sortedAlphabeticallyAfterFirstItem',
        () {
          // arrange
          const initialSector = Sector.utilities;

          // act
          final bloc = SelectSectorBloc(
            initialSector,
            mockUpdateFavoriteSectorUseCase,
            mockSectorService,
            mockTracker,
          );

          // assert
          final availableSectors = bloc.state.availableSectors;
          expect(availableSectors.first.sector, initialSector);

          final remaining = availableSectors.skip(1).toList();
          for (var i = 0; i < remaining.length - 1; i++) {
            expect(
              remaining[i].displayName.compareTo(
                    remaining[i + 1].displayName,
                  ) <=
                  0,
              isTrue,
            );
          }
        },
      );
    });
  });
}
