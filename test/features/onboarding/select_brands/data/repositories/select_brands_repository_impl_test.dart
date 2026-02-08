import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/select_brands/data/datasources/select_brands_remote_datasource.dart';
import 'package:bizzie/features/onboarding/select_brands/data/dtos/daily_brands_dto.dart';
import 'package:bizzie/features/onboarding/select_brands/data/repositories/select_brands_repository_impl.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSelectBrandsRemoteDataSource extends Mock
    implements ISelectBrandsRemoteDataSource {}

class MockConfigService extends Mock implements ConfigService {}

void main() {
  late SelectBrandsRepositoryImpl repository;
  late MockSelectBrandsRemoteDataSource mockRemoteDataSource;
  late MockConfigService mockConfigService;

  setUp(() {
    mockRemoteDataSource = MockSelectBrandsRemoteDataSource();
    mockConfigService = MockConfigService();
    repository = SelectBrandsRepositoryImpl(
      mockRemoteDataSource,
      mockConfigService,
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
        () => mockConfigService.getSectorDisplayName(any()),
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
        // Note: In tDailyBrandsDto, the sector name is 'Tech'.
        // Sector.informationTechnology.displayName is 'Information Technology' (usually).
        // We need them to match or adjust mock data.
        // Let's adjust mock data to match Information Technology.
        expect(sector.first.name, 'Tech Item');
      });
      verify(() => mockRemoteDataSource.fetchDailyBrands()).called(1);
    });

    test('getDailyBrands_remoteNull_returnsMockBrands', () async {
      // arrange
      when(
        () => mockRemoteDataSource.fetchDailyBrands(),
      ).thenAnswer((_) async => null);
      when(
        () => mockConfigService.getSectorDisplayName(any()),
      ).thenReturn('Information Technology');

      // act
      final result = await repository.getDailyBrands(tUserSector);

      // assert
      expect(result.isRight(), isTrue);
      // Verify mocks are returned (based on the _getMockBrands logic)
      result.fold((l) => fail('Should be right'), (r) {
        expect(r.globalBrands, isNotEmpty); // Global mocks
        expect(r.sectorBrands, isNotEmpty); // Sector mocks
      });
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
