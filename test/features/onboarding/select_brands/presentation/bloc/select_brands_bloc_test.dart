import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream_usecase.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand_listing.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/get_daily_brands_params.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/usecases/get_daily_brands_usecase.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDailyBrandsUseCase extends Mock implements GetDailyBrandsUseCase {}

class MockGetAuthStreamUseCase extends Mock implements GetAuthStreamUseCase {}

MockGetAuthStreamUseCase stubbedGetAuthStream() {
  final mock = MockGetAuthStreamUseCase();
  when(() => mock()).thenAnswer((_) => const Stream.empty());
  return mock;
}

void main() {
  late SelectBrandsBloc bloc;
  late MockGetDailyBrandsUseCase mockGetDailyBrandsUseCase;

  setUp(() {
    mockGetDailyBrandsUseCase = MockGetDailyBrandsUseCase();
    bloc = SelectBrandsBloc(mockGetDailyBrandsUseCase, stubbedGetAuthStream());
    registerFallbackValue(const GetDailyBrandsParams());
  });

  const tBrand = Brand(
    name: 'Apple',
    company: 'Apple Inc.',
    ticker: 'AAPL',
    sector: 'Tech',
    description: 'desc',
  );
  const tSectorName = 'Technology';

  final tBrandListing = BrandListing(globalBrands: [tBrand], sectorBrands: []);

  group('SelectBrandsBloc', () {
    test('initialState_isInitial', () {
      expect(bloc.state, const SelectBrandsState.initial());
    });

    blocTest<SelectBrandsBloc, SelectBrandsState>(
      'onStarted_success_emitsLoaded',
      build: () {
        when(
          () => mockGetDailyBrandsUseCase(any()),
        ).thenAnswer((_) async => Right(tBrandListing));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const SelectBrandsEvent.started(
          sectorName: tSectorName,
          selectedBrands: [],
        ),
      ),
      expect: () => [
        isA<SelectBrandsState>().having(
          (s) =>
              s.maybeMap(loaded: (l) => l.globalBrands.length, orElse: () => 0),
          'globalBrands length',
          1,
        ),
      ],
    );

    blocTest<SelectBrandsBloc, SelectBrandsState>(
      'onStarted_withSectorAndSelection_fetchesSectorAndEmitsSelection',
      build: () {
        when(
          () => mockGetDailyBrandsUseCase(any()),
        ).thenAnswer((_) async => Right(tBrandListing));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const SelectBrandsEvent.started(
          sector: Sector.energy,
          sectorName: tSectorName,
          selectedBrands: [tBrand],
        ),
      ),
      expect: () => [
        isA<SelectBrandsState>()
            .having(
              (s) => s.mapOrNull(loaded: (l) => l.sectorName),
              'sectorName',
              tSectorName,
            )
            .having(
              (s) => s.mapOrNull(
                loaded: (l) => l.selectedBrands.map((vm) => vm.brand).toList(),
              ),
              'selectedBrands',
              [tBrand],
            ),
      ],
      verify: (_) {
        verify(
          () => mockGetDailyBrandsUseCase(
            const GetDailyBrandsParams(sector: Sector.energy),
          ),
        ).called(1);
      },
    );

    blocTest<SelectBrandsBloc, SelectBrandsState>(
      'onStarted_failure_emitsError',
      build: () {
        when(
          () => mockGetDailyBrandsUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('error')));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const SelectBrandsEvent.started(
          sectorName: tSectorName,
          selectedBrands: [],
        ),
      ),
      expect: () => [const SelectBrandsState.error('error')],
    );

    blocTest<SelectBrandsBloc, SelectBrandsState>(
      'onUpdated_afterLoaded_emitsNewSelection',
      build: () {
        when(
          () => mockGetDailyBrandsUseCase(any()),
        ).thenAnswer((_) async => Right(tBrandListing));
        return bloc;
      },
      act: (bloc) async {
        bloc.add(
          const SelectBrandsEvent.started(
            sectorName: tSectorName,
            selectedBrands: [],
          ),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(const SelectBrandsEvent.updated(selectedBrands: [tBrand]));
      },
      skip: 1,
      expect: () => [
        isA<SelectBrandsState>().having(
          (s) => s.mapOrNull(
            loaded: (l) => l.selectedBrands.map((vm) => vm.brand).toList(),
          ),
          'selectedBrands',
          [tBrand],
        ),
      ],
    );

    blocTest<SelectBrandsBloc, SelectBrandsState>(
      'reset_fromLoaded_emitsInitial',
      seed: () => const SelectBrandsState.loaded(
        sectorBrands: [],
        globalBrands: [],
        selectedBrands: [],
        sectorName: tSectorName,
      ),
      build: () => bloc,
      act: (bloc) => bloc.add(const SelectBrandsEvent.reset()),
      expect: () => [const SelectBrandsState.initial()],
    );

    blocTest<SelectBrandsBloc, SelectBrandsState>(
      'reset_thenUpdated_doesNotEmit',
      build: () {
        when(
          () => mockGetDailyBrandsUseCase(any()),
        ).thenAnswer((_) async => Right(tBrandListing));
        return bloc;
      },
      act: (bloc) async {
        bloc.add(
          const SelectBrandsEvent.started(
            sectorName: tSectorName,
            selectedBrands: [],
          ),
        );
        await bloc.stream.firstWhere(
          (s) => s.mapOrNull(loaded: (_) => true) ?? false,
        );
        bloc.add(const SelectBrandsEvent.reset());
        await bloc.stream.firstWhere(
          (s) => s == const SelectBrandsState.initial(),
        );
        bloc.add(const SelectBrandsEvent.updated(selectedBrands: [tBrand]));
      },
      skip: 2,
      expect: () => <SelectBrandsState>[],
    );
  });
}
