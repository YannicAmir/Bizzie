import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/utils/string_extensions.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/search/data/datasources/recommended_brands_remote_datasource.dart';
import 'package:bizzie/features/search/data/dtos/recommended_brand_dto.dart';
import 'package:bizzie/features/search/domain/interfaces/i_recommended_brands_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('RecommendedBrandsRepository');

@LazySingleton(as: IRecommendedBrandsRepository)
class RecommendedBrandsRepository implements IRecommendedBrandsRepository {
  final IRecommendedBrandsRemoteDataSource _remoteDataSource;

  RecommendedBrandsRepository(this._remoteDataSource);

  final Map<String, List<Company>> _cache = {};
  DateTime? _lastFetchTime;

  @override
  Future<Either<Failure, List<Company>>> getBrandsBySector(
    String sector,
  ) async {
    try {
      _invalidateCacheIfNeeded();

      final targetSector = sector.toTitleCase();

      if (_cache.containsKey(targetSector)) {
        _logger.info('Returning cached brands for sector: $targetSector');
        return Right(_cache[targetSector]!);
      }

      _logger.info('Fetching brands for sector: $targetSector');
      var brands = await _fetchBrands(targetSector, originalSector: sector);

      if (brands.isEmpty) {
        _logger.warning('Brands list empty. Using HARDCODED fallback.');
        brands = _getFallbackBrands();
      } else {
        _logger.info('Found ${brands.length} brands for sector $targetSector');
      }

      _updateCache(targetSector, brands);

      return Right(brands);
    } catch (e) {
      _logger.severe('Failed to fetch brands by sector: $e');
      return Left(Failure.server(e.toString()));
    }
  }

  void _invalidateCacheIfNeeded() {
    final now = DateTime.now();
    if (_lastFetchTime != null) {
      final isSameDay =
          _lastFetchTime!.year == now.year &&
          _lastFetchTime!.month == now.month &&
          _lastFetchTime!.day == now.day;
      if (!isSameDay) {
        _logger.info('Cache expired (new day). Clearing cache.');
        _cache.clear();
        _lastFetchTime = null;
      }
    }
  }

  Future<List<Company>> _fetchBrands(
    String targetSector, {
    required String originalSector,
  }) async {
    final products = await _remoteDataSource.fetchBrandsForSector(
      targetSector,
      originalSector: originalSector,
    );
    return _mapToCompanies(products);
  }

  List<Company> _mapToCompanies(List<Map<String, dynamic>> products) {
    return products
        .map((p) => RecommendedBrandDto.fromJson(p).toDomain())
        .toList();
  }

  List<Company> _getFallbackBrands() {
    return [
      const Company(ticker: 'AAPL', name: 'Apple Inc.'),
      const Company(ticker: 'MSFT', name: 'Microsoft Corp.'),
      const Company(ticker: 'NVDA', name: 'NVIDIA Corp.'),
      const Company(ticker: 'GOOGL', name: 'Alphabet Inc.'),
      const Company(ticker: 'AMZN', name: 'Amazon.com Inc.'),
    ];
  }

  void _updateCache(String sector, List<Company> brands) {
    _cache[sector] = brands;
    _lastFetchTime = DateTime.now();
  }
}
