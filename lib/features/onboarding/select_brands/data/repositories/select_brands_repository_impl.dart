import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/onboarding/select_brands/data/datasources/select_brands_remote_datasource.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/interfaces/i_select_brands_repository.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand_listing.dart';
import 'package:bizzie/features/onboarding/select_brands/data/dtos/daily_brands_dto.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SelectBrandsRepositoryImpl');

@LazySingleton(as: ISelectBrandsRepository)
class SelectBrandsRepositoryImpl implements ISelectBrandsRepository {
  final ISelectBrandsRemoteDataSource _remoteDataSource;

  SelectBrandsRepositoryImpl(this._remoteDataSource);

  DailyBrandsDto? _cachedDto;

  @override
  Future<Either<Failure, BrandListing>> getDailyBrands(
    Sector? userSector,
  ) async {
    _logger.info('Repository getDailyBrands called');
    try {
      final dailyBrandsDto =
          _cachedDto ?? await _remoteDataSource.fetchDailyBrands();

      if (dailyBrandsDto == null) {
        _logger.warning('dailyBrandsDto is NULL - using mocks');
        return Right(_getMockBrands(userSector));
      }

      _cachedDto = dailyBrandsDto;
      return Right(_mapDtoToBrands(dailyBrandsDto, userSector));
    } on ServerException catch (e) {
      _logger.severe('Server error during getDailyBrands: ${e.message}');
      return Left(Failure.server(e.message));
    } catch (e, stack) {
      _logger.severe('Unexpected error during getDailyBrands', e, stack);
      return Left(
        Failure.server('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  BrandListing _mapDtoToBrands(DailyBrandsDto dto, Sector? userSector) {
    _logger.info(
      'Mapping DTO to Brands. Sectors found: ${dto.sectors.map((s) => s.name).toList()}',
    );

    final globalBrands = <Brand>[];
    final sectorBrands = <Brand>[];

    for (final sectorDto in dto.sectors) {
      final brands = sectorDto.products
          .map((p) => _mapProductToBrand(p, sectorDto.name))
          .toList();

      if (sectorDto.name == 'All Sectors') {
        globalBrands.addAll(brands);
      } else if (userSector != null &&
          sectorDto.name == userSector.displayName) {
        sectorBrands.addAll(brands);
      }
    }

    return BrandListing(globalBrands: globalBrands, sectorBrands: sectorBrands);
  }

  Brand _mapProductToBrand(DailyBrandProductDto product, String sectorName) {
    return Brand(
      name: product.name,
      company: product.company,
      ticker: product.ticker,
      sector: sectorName,
      description: product.description,
    );
  }

  BrandListing _getMockBrands(Sector? userSector) {
    final global = [
      Brand(
        name: 'iPhone',
        company: 'Apple Inc.',
        ticker: 'AAPL',
        sector: 'Information Technology',
        description: 'Tech Giant',
      ),
      Brand(
        name: 'Tesla',
        company: 'Tesla Inc.',
        ticker: 'TSLA',
        sector: 'Consumer Discretionary',
        description: 'EV Manufacturer',
      ),
      Brand(
        name: 'Nike',
        company: 'Nike Inc.',
        ticker: 'NKE',
        sector: 'Consumer Discretionary',
        description: 'Sportswear',
      ),
      Brand(
        name: 'Coca-Cola',
        company: 'The Coca-Cola Company',
        ticker: 'KO',
        sector: 'Consumer Staples',
        description: 'Beverage',
      ),
      Brand(
        name: 'Netflix',
        company: 'Netflix Inc.',
        ticker: 'NFLX',
        sector: 'Communication Services',
        description: 'Streaming',
      ),
    ];

    final sectorSpecific = <Brand>[];
    if (userSector != null) {
      sectorSpecific.add(
        Brand(
          name: '${userSector.displayName} Brand A',
          company: 'Company A',
          ticker: 'AAA',
          sector: userSector.displayName,
          description: 'Mock Description',
        ),
      );
      sectorSpecific.add(
        Brand(
          name: '${userSector.displayName} Brand B',
          company: 'Company B',
          ticker: 'BBB',
          sector: userSector.displayName,
          description: 'Mock Description',
        ),
      );
      sectorSpecific.add(
        Brand(
          name: '${userSector.displayName} Consumer',
          company: 'Company C',
          ticker: 'CCC',
          sector: userSector.displayName,
          description: 'Mock Description',
        ),
      );
    }

    return BrandListing(globalBrands: global, sectorBrands: sectorSpecific);
  }
}
