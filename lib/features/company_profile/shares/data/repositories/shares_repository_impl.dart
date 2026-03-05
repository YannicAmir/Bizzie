import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
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
  final FinancialStatementsFirestoreDataSource _financialLocalDataSource;

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
      final quoteResult = await _companyRepository.getQuote(ticker);
      final (current, quoteOrigin) = quoteResult.fold(
        (failure) => throw Exception(failure.message),
        (tuple) => (tuple.$1.sharesOutstanding ?? 0.0, tuple.$2),
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

      return annualRes.map(
        success: (annualS) => quartRes.map(
          success: (quartS) async {
            final annual = annualS.data;
            final quart = quartS.data;

            final result = ShareStats(
              currentSharesOutstanding: current,
              annualWeightedAverageShares: annual
                  .where((d) => d.date?.isNotEmpty == true)
                  .map((d) => d.toWeightedAverageSharesDataPoint())
                  .toList(),
              quarterlyWeightedAverageShares: quart
                  .where((d) => d.date?.isNotEmpty == true)
                  .map((d) => d.toWeightedAverageSharesDataPoint())
                  .toList(),
            );

            final origins = [quoteOrigin, annualS.origin, quartS.origin];
            final finalOrigin = origins.contains(CompanyProfileDataOrigin.api)
                ? CompanyProfileDataOrigin.api
                : origins.contains(CompanyProfileDataOrigin.db)
                ? CompanyProfileDataOrigin.db
                : CompanyProfileDataOrigin.cache;

            return right((result, finalOrigin));
          },
          failure: (f) => left(f.failure),
          notFound: (_) => left(Failure.server('Quarterly data not found')),
        ),
        failure: (f) => left(f.failure),
        notFound: (_) => left(Failure.server('Annual data not found')),
      );
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }
}
