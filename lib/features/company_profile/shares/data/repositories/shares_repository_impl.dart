import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/business/data/datasources/business_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/business/data/datasources/business_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/profile_dtos.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import '../../domain/interfaces/i_shares_repository.dart';
import '../../domain/models/share_stats.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
}

@LazySingleton(as: ISharesRepository)
class SharesRepositoryImpl implements ISharesRepository {
  final BusinessRemoteDataSource _businessRemoteDataSource;
  final BusinessFirestoreDataSource _businessLocalDataSource;
  final FinancialStatementsRemoteDataSource _financialRemoteDataSource;
  final FinancialStatementsFirestoreDataSource _financialLocalDataSource;

  SharesRepositoryImpl(
    this._businessRemoteDataSource,
    this._businessLocalDataSource,
    this._financialRemoteDataSource,
    this._financialLocalDataSource,
  );

  @override
  Future<Either<Failure, ShareStats>> getShareStats(String ticker) async {
    try {
      final quote = await _getQuoteAndCache(ticker);
      final double current = quote.sharesOutstanding ?? 0.0;

      final annual = await _fetchLegacyIncomeStatements(ticker, _Consts.annual);
      final quart = await _fetchLegacyIncomeStatements(ticker, _Consts.quarter);

      List<FinancialDataPoint> mapIncomeDataPoints<T>(
        List<LegacyIncomeStatementDto> data,
        num Function(LegacyIncomeStatementDto) extractor,
      ) {
        return data.where((d) => d.date.isNotEmpty).map((d) {
          return FinancialDataPoint(
            date: d.date,
            period: d.period,
            value: extractor(d).toDouble(),
          );
        }).toList();
      }

      return right(
        ShareStats(
          currentSharesOutstanding: current,
          annualWeightedAverageShares: mapIncomeDataPoints(
            annual,
            (d) => d.weightedAverageShsOutDil ?? 0,
          ),
          quarterlyWeightedAverageShares: mapIncomeDataPoints(
            quart,
            (d) => d.weightedAverageShsOutDil ?? 0,
          ),
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Future<QuoteDto> _getQuoteAndCache(String ticker) async {
    final local = await _businessLocalDataSource.getCachedQuote(ticker);
    if (local != null) return local;

    final remote = await _businessRemoteDataSource.getQuote(ticker);
    if (remote.isEmpty) {
      throw Exception("Quote not found");
    }
    final quote = remote.first;
    await _businessLocalDataSource.cacheQuote(ticker, quote);
    return quote;
  }

  Future<List<LegacyIncomeStatementDto>> _fetchLegacyIncomeStatements(
    String ticker,
    String period,
  ) async {
    final local = await _financialLocalDataSource
        .getCachedLegacyIncomeStatements(ticker, period: period);
    if (local != null) return local;

    final remote = await _financialRemoteDataSource.getLegacyIncomeStatements(
      ticker,
      period: period,
    );
    await _financialLocalDataSource.cacheLegacyIncomeStatements(
      ticker,
      remote,
      period: period,
    );
    return remote;
  }
}
