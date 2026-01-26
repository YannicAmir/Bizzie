import 'package:bizzie/features/onboarding/select_brands/data/dtos/daily_brands_dto.dart';

import 'package:bizzie/services/firestore_service.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SelectBrandsRemoteDataSource');

abstract class ISelectBrandsRemoteDataSource {
  Future<DailyBrandsDto?> fetchDailyBrands();
}

@Injectable(as: ISelectBrandsRemoteDataSource)
class SelectBrandsRemoteDataSource implements ISelectBrandsRemoteDataSource {
  final FirestoreService _firestoreService;

  SelectBrandsRemoteDataSource(this._firestoreService);

  @override
  Future<DailyBrandsDto?> fetchDailyBrands() async {
    _logger.info('Fetching daily brands document');
    try {
      final data = await _firestoreService.getLatestDocument(
        collectionPath: 'daily_brands',
        orderBy: 'date',
      );

      if (data == null) {
        _logger.warning('No daily brands document found in Firestore');
        return null;
      }

      _logger.info('Daily brands document successfully retrieved');
      return DailyBrandsDto.fromJson(data);
    } on FirebaseException catch (e) {
      _logger.severe('Firebase error while fetching daily brands', e);
      throw ServerException(message: e.message ?? 'Firestore error');
    } catch (e, stack) {
      _logger.severe('Unexpected error while fetching daily brands', e, stack);
      throw ServerException(message: e.toString());
    }
  }
}
