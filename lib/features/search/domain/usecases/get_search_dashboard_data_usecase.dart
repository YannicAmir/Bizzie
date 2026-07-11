import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/features/search/domain/usecases/get_recommended_brands_usecase.dart';
import 'package:bizzie/features/user/domain/usecases/get_user_usecase.dart';

final _logger = BizzieLogger('GetSearchDashboardDataUseCase');

class SearchDashboardData {
  final String favoriteSector;
  final List<Company> recommendedBrands;

  SearchDashboardData({
    required this.favoriteSector,
    required this.recommendedBrands,
  });
}

@injectable
class GetSearchDashboardDataUseCase {
  final IAuthRepository _authRepository;
  final GetUserUseCase _getUserUseCase;
  final GetRecommendedBrandsUseCase _getRecommendedBrandsUseCase;

  static const String _defaultSector = 'Information Technology';

  GetSearchDashboardDataUseCase(
    this._authRepository,
    this._getUserUseCase,
    this._getRecommendedBrandsUseCase,
  );

  Future<Either<Failure, SearchDashboardData>> execute() async {
    String sector = _defaultSector;

    final currentUser = _authRepository.currentUser;
    if (currentUser != null) {
      final userResult = await _getUserUseCase(currentUser.id);
      sector = userResult.fold(
        (failure) {
          _logger.warning('Failed to fetch user: $failure. Using default.');
          return _defaultSector;
        },
        (user) {
          _logger.info('User fetched, sector: ${user.favoriteSector}');
          return user.favoriteSector;
        },
      );
    } else {
      _logger.info('No logged in user. Using default sector.');
    }

    final brandsResult = await _getRecommendedBrandsUseCase(sector);

    return brandsResult.fold(
      (failure) {
        _logger.severe('Failed to fetch brands: $failure');
        return Left(failure);
      },
      (brands) {
        _logger.info('Brands fetched: ${brands.length}');
        return Right(
          SearchDashboardData(
            favoriteSector: sector,
            recommendedBrands: brands,
          ),
        );
      },
    );
  }
}
