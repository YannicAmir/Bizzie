import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand_listing.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/get_daily_brands_params.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/usecases/get_daily_brands_usecase.dart';
import 'package:bizzie/features/onboarding/select_brands/presentation/bloc/select_brands_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingBloc extends MockBloc<OnboardingEvent, OnboardingState>
    implements OnboardingBloc {}

class MockGetDailyBrandsUseCase extends Mock implements GetDailyBrandsUseCase {}

void main() {
  late SelectBrandsBloc bloc;
  late MockOnboardingBloc mockOnboardingBloc;
  late MockGetDailyBrandsUseCase mockGetDailyBrandsUseCase;

  setUp(() {
    mockOnboardingBloc = MockOnboardingBloc();
    mockGetDailyBrandsUseCase = MockGetDailyBrandsUseCase();

    when(
      () => mockOnboardingBloc.stream,
    ).thenAnswer((_) => const Stream.empty());

    bloc = SelectBrandsBloc(mockOnboardingBloc, mockGetDailyBrandsUseCase);
    registerFallbackValue(const GetDailyBrandsParams());
  });

  const tBrand = Brand(
    name: 'Apple',
    company: 'Apple Inc.',
    ticker: 'AAPL',
    sector: 'Tech',
    description: 'desc',
  );

  final tBrandListing = BrandListing(globalBrands: [tBrand], sectorBrands: []);

  group('SelectBrandsBloc', () {
    test('initialState_isInitial', () {
      expect(bloc.state, const SelectBrandsState.initial());
    });

    blocTest<SelectBrandsBloc, SelectBrandsState>(
      'onStarted_success_emitsLoaded',
      build: () {
        when(
          () => mockOnboardingBloc.state,
        ).thenReturn(OnboardingState.initial()); // Mock state for selectBrands
        when(
          () => mockGetDailyBrandsUseCase(any()),
        ).thenAnswer((_) async => Right(tBrandListing));
        return bloc;
      },
      act: (bloc) => bloc.add(const SelectBrandsEvent.started()),
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
      'onStarted_failure_emitsError',
      build: () {
        when(
          () => mockOnboardingBloc.state,
        ).thenReturn(OnboardingState.initial());
        when(
          () => mockGetDailyBrandsUseCase(any()),
        ).thenAnswer((_) async => const Left(Failure.server('error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const SelectBrandsEvent.started()),
      expect: () => [const SelectBrandsState.error('error')],
    );

    blocTest<SelectBrandsBloc, SelectBrandsState>(
      'onToggleBrand_callsOnboardingBloc',
      build: () => bloc,
      act: (bloc) => bloc.add(const SelectBrandsEvent.toggleBrand(tBrand)),
      verify: (_) {
        verify(
          () =>
              mockOnboardingBloc.add(const OnboardingEvent.brandToggled(tBrand)),
        ).called(1);
      },
    );
  });
}
