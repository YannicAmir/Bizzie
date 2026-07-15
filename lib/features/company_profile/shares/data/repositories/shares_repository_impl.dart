import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/features/company_profile/financial_statements/data/interfaces/i_financial_statements_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import '../../domain/interfaces/i_shares_repository.dart';
import '../../domain/models/share_stats.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
}

@LazySingleton(as: ISharesRepository)
class SharesRepositoryImpl implements ISharesRepository {
  final ICompanyRepository _companyRepository;
  final FinancialStatementsRemoteDataSource _financialRemoteDataSource;
  final IFinancialStatementsFirestoreDataSource _financialLocalDataSource;

  SharesRepositoryImpl(
    this._companyRepository,
    this._financialRemoteDataSource,
    this._financialLocalDataSource,
  );

  @override
  Future<Either<Failure, (ShareStats, CompanyProfileDataOrigin)>> getShareStats(
    String ticker,
  ) async {
    try {
      final profileResult = await _companyRepository.getProfile(ticker);
      final (current, quoteOrigin) = profileResult.fold(
        (failure) => throw Exception(failure.errorMessage),
        (tuple) {
          final profile = tuple.$1;
          final price = profile.price ?? 0.0;
          final marketCap = profile.marketCap ?? 0.0;
          final shares = price > 0 ? marketCap / price : 0.0;
          return (shares, tuple.$2);
        },
      );

      final annualRes = await _financialLocalDataSource
          .syncLegacyIncomeStatements(
            ticker,
            period: _Consts.annual,
            remoteFetcher: () => _financialRemoteDataSource
                .getLegacyIncomeStatements(ticker, period: _Consts.annual),
          );
      final quartRes = await _financialLocalDataSource
          .syncLegacyIncomeStatements(
            ticker,
            period: _Consts.quarter,
            remoteFetcher: () => _financialRemoteDataSource
                .getLegacyIncomeStatements(ticker, period: _Consts.quarter),
          );

      if (annualRes.isFailure) {
        return left((annualRes as result.CacheFailure).failure);
      }
      if (quartRes.isFailure) {
        return left((quartRes as result.CacheFailure).failure);
      }
      if (annualRes.isNotFound) {
        return left(const Failure.server('Annual data not found'));
      }
      if (quartRes.isNotFound) {
        return left(const Failure.server('Quarterly data not found'));
      }

      final annual = (annualRes as result.CacheSuccess<List<dynamic>>).data;
      final quart = (quartRes as result.CacheSuccess<List<dynamic>>).data;
      final annualOrigin = (annualRes as result.CacheSuccess).origin;
      final quartOrigin = (quartRes as result.CacheSuccess).origin;

      final shareStats = ShareStats(
        currentSharesOutstanding: current,
        annualWeightedAverageShares: annual
            .where((d) => d.date?.isNotEmpty == true)
            .map((d) => (d as dynamic).toWeightedAverageSharesDataPoint())
            .cast<FinancialDataPoint>()
            .toList(),
        quarterlyWeightedAverageShares: quart
            .where((d) => d.date?.isNotEmpty == true)
            .map((d) => (d as dynamic).toWeightedAverageSharesDataPoint())
            .cast<FinancialDataPoint>()
            .toList(),
      );

      final origins = [quoteOrigin, annualOrigin, quartOrigin];
      final finalOrigin = origins.contains(CompanyProfileDataOrigin.api)
          ? CompanyProfileDataOrigin.api
          : origins.contains(CompanyProfileDataOrigin.db)
          ? CompanyProfileDataOrigin.db
          : CompanyProfileDataOrigin.cache;

      return right((shareStats, finalOrigin));
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }
}
