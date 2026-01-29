import 'package:bizzie/features/onboarding/select_brands/data/dtos/daily_brands_dto.dart';

import 'package:bizzie/services/firestore_service.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

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
      final dailyBrands = await _firestoreService
          .getLatestDocument<DailyBrandsDto>(
            collectionPath: 'daily_brands',
            orderBy: 'date',
            fromJson: DailyBrandsDto.fromJson,
            toJson: (dto) => dto.toJson(),
          );

      if (dailyBrands == null) {
        _logger.warning('No daily brands document found in Firestore');
        return null;
      }

      _logger.info('Daily brands document successfully retrieved');
      return dailyBrands;
    } catch (e, stack) {
      _logger.severe('Error while fetching daily brands', e, stack);
      throw ServerException(message: 'Failed to fetch daily brands: $e');
    }
  }
}
