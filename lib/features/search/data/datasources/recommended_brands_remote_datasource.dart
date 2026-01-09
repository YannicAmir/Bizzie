import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

abstract class IRecommendedBrandsRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchBrandsForSector(
    String targetSector, {
    required String originalSector,
  });
}

@Injectable(as: IRecommendedBrandsRemoteDataSource)
class RecommendedBrandsRemoteDataSource
    implements IRecommendedBrandsRemoteDataSource {
  final FirebaseFirestore _firestore;
  static final _logger = BizzieLogger('RecommendedBrandsRemoteDataSource');

  RecommendedBrandsRemoteDataSource(this._firestore);

  @override
  Future<List<Map<String, dynamic>>> fetchBrandsForSector(
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

    return (sectorData['products'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
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
}
