import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/search/domain/interfaces/i_recommended_brands_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('RecommendedBrandsRepository');

@LazySingleton(as: IRecommendedBrandsRepository)
class RecommendedBrandsRepository implements IRecommendedBrandsRepository {
  final FirebaseFirestore _firestore;

  RecommendedBrandsRepository(this._firestore);

  final Map<String, List<Company>> _cache = {};
  DateTime? _lastFetchTime;

  @override
  Future<Either<Failure, List<Company>>> getBrandsBySector(
    String sector,
  ) async {
    try {
      _invalidateCacheIfNeeded();

      final targetSector = _normalizeSectorName(sector);

      if (_cache.containsKey(targetSector)) {
        _logger.info('Returning cached brands for sector: $targetSector');
        return Right(_cache[targetSector]!);
      }

      _logger.info('Fetching brands for sector: $targetSector');
      var brands = await _fetchFromFirestore(
        targetSector,
        originalSector: sector,
      );

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
      return Left(ServerFailure(e.toString()));
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

  String _normalizeSectorName(String sector) {
    if (sector.contains('_')) {
      return sector
          .split('_')
          .map((word) {
            if (word.isEmpty) return '';
            return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
          })
          .join(' ');
    }
    return sector;
  }

  Future<List<Company>> _fetchFromFirestore(
    String targetSector, {
    required String originalSector,
  }) async {
    final docSnapshot = await _firestore
        .collection('daily_brands')
        .doc('content')
        .get();

    if (!docSnapshot.exists) {
      _logger.warning('daily_brands/content document not found');
      return [];
    }

    final data = docSnapshot.data();
    if (data == null || !data.containsKey('sectors')) {
      _logger.warning('No sectors data found in daily_brands/content');
      return [];
    }

    final sectors = (data['sectors'] as List<dynamic>)
        .cast<Map<String, dynamic>>();

    final sectorData = _findBestMatchingSector(
      sectors,
      targetSector,
      originalSector,
    );

    if (sectorData.isEmpty) {
      return [];
    }

    final products = (sectorData['products'] as List<dynamic>)
        .cast<Map<String, dynamic>>();

    return _mapToCompanies(products);
  }

  Map<String, dynamic> _findBestMatchingSector(
    List<Map<String, dynamic>> sectors,
    String targetSector,
    String originalSector,
  ) {
    var sectorData = sectors.firstWhere(
      (s) => s['name'] == targetSector,
      orElse: () => {},
    );
    if (sectorData.isEmpty) {
      sectorData = sectors.firstWhere(
        (s) => s['name'] == originalSector,
        orElse: () => {},
      );
    }

    if (sectorData.isEmpty) {
      _logger.warning('Sector $targetSector not found. Checking for fallback.');
      if (sectors.isNotEmpty) {
        sectorData = sectors.first;
        _logger.info(
          'Falling back to first available sector: ${sectorData['name']}',
        );
      } else {
        _logger.warning('No sectors available in Firestore.');
        return {};
      }
    }
    return sectorData;
  }

  List<Company> _mapToCompanies(List<Map<String, dynamic>> products) {
    return products.map((p) {
      return Company(
        ticker: p['ticker'] as String,
        name: p['company'] as String,
      );
    }).toList();
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
