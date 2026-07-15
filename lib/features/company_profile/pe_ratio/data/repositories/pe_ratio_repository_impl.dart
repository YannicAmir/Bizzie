import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/data/interfaces/i_ratios_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_remote_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/ratios_dto.dart';
import '../../domain/interfaces/i_pe_ratio_repository.dart';
import '../../domain/models/pe_ratio.dart';

abstract class _Consts {
  static const String ttm = 'ttm';
}

@LazySingleton(as: IPeRatioRepository)
class PeRatioRepositoryImpl implements IPeRatioRepository {
  final RatiosRemoteDataSource _remoteDataSource;
  final IRatiosFirestoreDataSource _localDataSource;

  PeRatioRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, (List<PeRatio>, CompanyProfileDataOrigin)>>
  getPeRatios(String ticker, {String period = 'annual'}) async {
    try {
      final isTtm = period == _Consts.ttm;
      final res = await _localDataSource.syncRatios(
        ticker,
        isTtm: isTtm,
        remoteFetcher: () async {
          if (isTtm) {
            final ttmList = await _remoteDataSource.getRatiosTtm(ticker);
            return ttmList
                .map(
                  (e) => RatiosDto(
                    symbol: e.symbol,
                    priceToEarningsRatio: e.priceToEarningsRatioTTM,
                    priceToFreeCashFlowRatio: e.priceToFreeCashFlowRatioTTM,
                    period: 'ttm',
                    date: DateTime.now().toIso8601String(),
                  ),
                )
                .toList();
          } else {
            return _remoteDataSource.getRatios(ticker);
          }
        },
      );

      return res.map(
        success: (s) =>
            right((s.data.map((d) => d.toPeRatio()).toList(), s.origin)),
        failure: (f) => left(f.failure),
        notFound: (_) =>
            right((const <PeRatio>[], CompanyProfileDataOrigin.cache)),
      );
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }
}
