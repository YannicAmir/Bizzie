import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/select_brands/data/datasources/select_brands_remote_datasource.dart';
import 'package:bizzie/features/onboarding/select_brands/data/dtos/daily_brands_dto.dart';
import 'package:bizzie/features/onboarding/select_brands/data/repositories/select_brands_repository_impl.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSelectBrandsRemoteDataSource extends Mock
    implements ISelectBrandsRemoteDataSource {}

class MockSectorService extends Mock implements ISectorService {}

void main() {
  late SelectBrandsRepositoryImpl repository;
  late MockSelectBrandsRemoteDataSource mockRemoteDataSource;
  late MockSectorService mockSectorService;

  setUp(() {
    mockRemoteDataSource = MockSelectBrandsRemoteDataSource();
    mockSectorService = MockSectorService();
    repository = SelectBrandsRepositoryImpl(
      mockRemoteDataSource,
      mockSectorService,
    );
  });

  final tDailyBrandsDto = DailyBrandsDto(
    date: DateTime(2026, 1, 25),
    sectors: [
      const DailyBrandSectorDto(
        name: 'All Sectors',
        products: [
          DailyBrandProductDto(
            name: 'Global Item',
            company: 'Global Corp',
            ticker: 'GLBL',
            description: 'desc',
          ),
        ],
      ),
      const DailyBrandSectorDto(
        name: 'Information Technology',
        products: [
          DailyBrandProductDto(
            name: 'Tech Item',
            company: 'Tech Corp',
            ticker: 'TECH',
            description: 'desc',
          ),
        ],
      ),
    ],
  );

  const tUserSector = Sector.informationTechnology;

  group('getDailyBrands', () {
    test('getDailyBrands_remoteSuccess_returnsMappedBrands', () async {
      // arrange
      when(
        () => mockRemoteDataSource.fetchDailyBrands(),
      ).thenAnswer((_) async => tDailyBrandsDto);
      when(
        () => mockSectorService.getSectorDisplayName(any()),
      ).thenReturn('Information Technology');

      // act
      final result = await repository.getDailyBrands(tUserSector);

      // assert
      expect(result.isRight(), isTrue);
      result.fold((l) => fail('Should be right'), (r) {
        final global = r.globalBrands;
        final sector = r.sectorBrands;
        expect(global.length, 1);
        expect(global.first.name, 'Global Item');
        expect(sector.length, 1);
        expect(sector.first.name, 'Tech Item');
      });
      verify(() => mockRemoteDataSource.fetchDailyBrands()).called(1);
    });

    test(
      'getDailyBrands_healthcareNormalization_returnsMappedBrands',
      () async {
        // arrange
        final healthcareDto = DailyBrandsDto(
          date: DateTime(2026, 1, 25),
          sectors: [
            DailyBrandSectorDto(
              name: 'Healthcare',
              products: [
                DailyBrandProductDto(
                  name: 'Health Item',
                  company: 'Health Corp',
                  ticker: 'HLTH',
                  description: 'desc',
                ),
              ],
            ),
          ],
        );

        when(
          () => mockRemoteDataSource.fetchDailyBrands(),
        ).thenAnswer((_) async => healthcareDto);
        when(
          () => mockSectorService.getSectorDisplayName(Sector.healthCare.name),
        ).thenReturn('Health Care');

        // act
        final result = await repository.getDailyBrands(Sector.healthCare);

        // assert
        expect(result.isRight(), isTrue);
        result.fold((l) => fail('Should be right'), (r) {
          expect(r.sectorBrands.length, 1);
          expect(r.sectorBrands.first.name, 'Health Item');
        });
      },
    );

    test('getDailyBrands_remoteNull_returnsFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.fetchDailyBrands(),
      ).thenAnswer((_) async => null);

      // act
      final result = await repository.getDailyBrands(tUserSector);

      // assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(
          failure.errorMessage,
          'Failed to load brands. Please try again later.',
        ),
        (_) => fail('Should be Left'),
      );
    });

    test('getDailyBrands_serverException_returnsServerFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.fetchDailyBrands(),
      ).thenThrow(ServerException(message: 'Server error'));

      // act
      final result = await repository.getDailyBrands(tUserSector);

      // assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should be left'),
      );
    });

    test('getDailyBrands_unexpectedException_returnsServerFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.fetchDailyBrands(),
      ).thenThrow(Exception('unexpected'));

      // act
      final result = await repository.getDailyBrands(tUserSector);

      // assert
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ServerFailure>());
        expect((l as ServerFailure).message, contains('unexpected'));
      }, (r) => fail('Should be left'));
    });
  });
}
