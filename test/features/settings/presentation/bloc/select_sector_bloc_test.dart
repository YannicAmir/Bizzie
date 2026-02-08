import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/settings/domain/usecases/update_favorite_sector_usecase.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_bloc.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_event.dart';
import 'package:bizzie/features/settings/presentation/bloc/select_sector_state.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdateFavoriteSectorUseCase extends Mock
    implements UpdateFavoriteSectorUseCase {}

class MockConfigService extends Mock implements ConfigService {}

void main() {
  late MockUpdateFavoriteSectorUseCase mockUpdateFavoriteSectorUseCase;
  late MockConfigService mockConfigService;

  setUpAll(() {
    registerFallbackValue(Sector.energy);
  });

  setUp(() {
    mockUpdateFavoriteSectorUseCase = MockUpdateFavoriteSectorUseCase();
    mockConfigService = MockConfigService();

    // arrange
    when(
      () => mockConfigService.getSectorDisplayName(any()),
    ).thenAnswer((invocation) => invocation.positionalArguments[0] as String);
    when(
      () => mockConfigService.getSectorDescription(any()),
    ).thenReturn('Description');
  });

  group('SelectSectorBloc', () {
    group('initialization', () {
      test(
        'selectSectorBloc_initialState_emitsCorrectInitialFieldsAndOrdering',
        () {
          // arrange
          const initialSector = Sector.healthCare;

          // act
          final bloc = SelectSectorBloc(
            initialSector,
            mockUpdateFavoriteSectorUseCase,
            mockConfigService,
          );

          // assert
          expect(bloc.state.initialSector.sector, initialSector);
          expect(bloc.state.availableSectors.first.sector, initialSector);
        },
      );

      test(
        'selectSectorBloc_initialStateWithNull_defaultsToInformationTechnologyFirst',
        () {
          // act
          final bloc = SelectSectorBloc(
            null,
            mockUpdateFavoriteSectorUseCase,
            mockConfigService,
          );

          // assert
          expect(bloc.state.initialSector.sector, Sector.informationTechnology);
          expect(
            bloc.state.availableSectors.first.sector,
            Sector.informationTechnology,
          );
        },
      );
    });

    blocTest<SelectSectorBloc, SelectSectorState>(
      'selectSector_newSectorSelected_emitsStateWithUpdatedSelection',
      build: () => SelectSectorBloc(
        Sector.healthCare,
        mockUpdateFavoriteSectorUseCase,
        mockConfigService,
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
    );

    group('saveChanges', () {
      blocTest<SelectSectorBloc, SelectSectorState>(
        'saveChanges_effectiveChange_emitsLoadingThenSuccess',
        // arrange
        setUp: () {
          when(
            () => mockUpdateFavoriteSectorUseCase(any()),
          ).thenAnswer((_) async => const Right(null));
        },
        build: () => SelectSectorBloc(
          Sector.healthCare,
          mockUpdateFavoriteSectorUseCase,
          mockConfigService,
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
        },
      );

      blocTest<SelectSectorBloc, SelectSectorState>(
        'saveChanges_noChange_emitsNothing',
        build: () => SelectSectorBloc(
          Sector.healthCare,
          mockUpdateFavoriteSectorUseCase,
          mockConfigService,
        ),
        act: (bloc) => bloc.add(const SelectSectorEvent.saveChanges()),
        // assert
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockUpdateFavoriteSectorUseCase(any()));
        },
      );

      blocTest<SelectSectorBloc, SelectSectorState>(
        'saveChanges_onFailure_emitsLoadingThenFailure',
        // arrange
        setUp: () {
          when(
            () => mockUpdateFavoriteSectorUseCase(any()),
          ).thenAnswer((_) async => const Left(ServerFailure('Error')));
        },
        build: () => SelectSectorBloc(
          Sector.healthCare,
          mockUpdateFavoriteSectorUseCase,
          mockConfigService,
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
            mockConfigService,
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
