import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:dartz/dartz.dart';

abstract class IWatchlistRepository {
  Future<Either<Failure, void>> addToWatchlist(Company company, String uid);
  Future<Either<Failure, void>> removeFromWatchlist(String ticker, String uid);
  Future<Either<Failure, void>> syncSubscriptions(List<String> activeTickers);
  Stream<Either<Failure, List<Company>>> getWatchlistStream(String uid);
}
