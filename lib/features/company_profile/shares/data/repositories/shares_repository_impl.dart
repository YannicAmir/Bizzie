import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/quote_dto.dart';
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
  final FinancialStatementsFirestoreDataSource _financialLocalDataSource;

  SharesRepositoryImpl(
    this._companyRepository,
    this._financialRemoteDataSource,
    this._financialLocalDataSource,
  );

  @override
  Future<Either<Failure, ShareStats>> getShareStats(String ticker) async {
    try {
      final quote = await _getQuote(ticker);
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

  Future<QuoteDto> _getQuote(String ticker) async {
    final result = await _companyRepository.getQuote(ticker);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (quote) => _fromDomain(quote),
    );
  }

  QuoteDto _fromDomain(dynamic quote) {
    // Mapping from StockQuote (Domain) back to QuoteDto to preserve logic flow
    // or refactor getShareStats to use Domain model.
    // Simpler to map back for now or adjust getShareStats to use StockQuote.
    // StockQuote has sharesOutstanding.
    return QuoteDto(
      symbol: quote.symbol,
      name: quote.name,
      price: quote.price,
      change: quote.change,
      changesPercentage: quote.changesPercentage,
      marketCap: quote.marketCap,
      pe: quote.pe,
      eps: quote.eps,
      volume: quote.volume,
      sharesOutstanding: quote.sharesOutstanding,
    );
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
