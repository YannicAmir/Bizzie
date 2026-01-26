import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/balance_sheet_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/key_metrics_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/legacy_income_statement_dto.dart';

import 'package:bizzie/features/company_profile/data/dtos/ratios_dto.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/domain/models/company_ratios.dart';
import 'package:bizzie/features/company_profile/domain/models/eps_stats.dart';
import 'package:bizzie/features/company_profile/domain/models/fcps_stats.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/free_cash_flow_stats.dart';
import 'package:bizzie/features/company_profile/domain/models/full_financials.dart';
import 'package:bizzie/features/company_profile/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/domain/models/key_metrics.dart';
import 'package:bizzie/features/company_profile/domain/models/net_income_stats.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
  static const String ttm = 'ttm';
  static const String usd = 'USD';
}

@LazySingleton(as: IFinancialRepository)
class FinancialRepositoryImpl implements IFinancialRepository {
  final CompanyRemoteDataSource _remoteDataSource;
  final CompanyFirestoreDataSource _localDataSource;

  FinancialRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, NetIncomeStats>> getNetIncomeStats(
    String ticker,
  ) async {
    try {
      final annual = await _fetchStableIncomeStatements(ticker, _Consts.annual);
      final quart = await _fetchStableIncomeStatements(ticker, _Consts.quarter);

      final conversion = await _getCurrencyMultiplier(
        annual.firstOrNull?.reportedCurrency ??
            quart.firstOrNull?.reportedCurrency,
        ticker,
      );

      return right(
        NetIncomeStats(
          reportedCurrency: conversion.targetCurrency,
          annualNetIncome: _mapStableIncomeDataPoints(
            annual,
            (d) => (d.netIncome ?? 0.0) * conversion.multiplier,
          ),
          quarterlyNetIncome: _mapStableIncomeDataPoints(
            quart,
            (d) => (d.netIncome ?? 0.0) * conversion.multiplier,
          ),
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EpsStats>> getEpsStats(String ticker) async {
    try {
      final annual = await _fetchStableIncomeStatements(ticker, _Consts.annual);
      final quart = await _fetchStableIncomeStatements(ticker, _Consts.quarter);

      final conversion = await _getCurrencyMultiplier(
        annual.firstOrNull?.reportedCurrency ??
            quart.firstOrNull?.reportedCurrency,
        ticker,
      );

      return right(
        EpsStats(
          reportedCurrency: conversion.targetCurrency,
          annualEps: _mapStableIncomeDataPoints(
            annual,
            (d) => (d.epsDiluted ?? 0.0) * conversion.multiplier,
          ),
          quarterlyEps: _mapStableIncomeDataPoints(
            quart,
            (d) => (d.epsDiluted ?? 0.0) * conversion.multiplier,
          ),
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FreeCashFlowStats>> getFreeCashFlowStats(
    String ticker,
  ) async {
    try {
      final annual = await _fetchCashFlowStatements(ticker, _Consts.annual);
      final quart = await _fetchCashFlowStatements(ticker, _Consts.quarter);

      final conversion = await _getCurrencyMultiplier(
        annual.firstOrNull?.reportedCurrency ??
            quart.firstOrNull?.reportedCurrency,
        ticker,
      );

      return right(
        FreeCashFlowStats(
          reportedCurrency: conversion.targetCurrency,
          annualFcf: _mapCashFlowDataPoints(
            annual,
            (d) => d.freeCashFlow * conversion.multiplier,
          ),
          quarterlyFcf: _mapCashFlowDataPoints(
            quart,
            (d) => d.freeCashFlow * conversion.multiplier,
          ),
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FcpsStats>> getFcpsStats(String ticker) async {
    try {
      final annualCF = await _fetchCashFlowStatements(ticker, _Consts.annual);
      final quartCF = await _fetchCashFlowStatements(ticker, _Consts.quarter);
      final annualInc = await _fetchStableIncomeStatements(
        ticker,
        _Consts.annual,
      );
      final quartInc = await _fetchStableIncomeStatements(
        ticker,
        _Consts.quarter,
      );

      final conversion = await _getCurrencyMultiplier(
        annualCF.firstOrNull?.reportedCurrency ??
            annualInc.firstOrNull?.reportedCurrency,
        ticker,
      );

      List<FinancialDataPoint> calculateFcps(
        List<CashFlowStatementDto> cashFlows,
        List<IncomeStatementDto> incomeStatements,
      ) {
        final result = <FinancialDataPoint>[];
        final incomeMap = {for (var i in incomeStatements) i.date: i};

        for (var cf in cashFlows) {
          var income = incomeMap[cf.date];
          if (income != null && (income.weightedAverageShsOutDil ?? 0) > 0) {
            final fcps =
                (cf.freeCashFlow / (income.weightedAverageShsOutDil ?? 1)) *
                conversion
                    .multiplier; // Use 1 to avoid division by zero if null, though condition handles it
            result.add(
              FinancialDataPoint(date: cf.date, period: cf.period, value: fcps),
            );
          }
        }
        return result;
      }

      return right(
        FcpsStats(
          annualFcps: calculateFcps(annualCF, annualInc),
          quarterlyFcps: calculateFcps(quartCF, quartInc),
          reportedCurrency: conversion.targetCurrency,
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BalanceSheet>>> getBalanceSheets(
    String ticker, {
    String period = 'annual',
  }) async {
    try {
      // 1. Fetch Data (Local or Remote)
      List<BalanceSheetDto> dtos;
      final local = await _localDataSource.getCachedBalanceSheets(
        ticker,
        period: period,
      );
      if (local != null) {
        dtos = local;
      } else {
        dtos = await _remoteDataSource.getBalanceSheets(ticker, period: period);
        await _localDataSource.cacheBalanceSheets(ticker, dtos, period: period);
      }

      // 2. Determine Currency Multiplier
      final conversion = await _getCurrencyMultiplier(
        dtos.firstOrNull?.reportedCurrency,
        ticker,
      );

      // 3. Map with Conversion
      return right(
        dtos
            .map(
              (d) => _toBalanceSheet(
                d,
                multiplier: conversion.multiplier,
                targetCurrency: conversion.targetCurrency,
              ),
            )
            .toList(),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CompanyRatios>>> getRatios(
    String ticker, {
    String period = 'annual',
  }) async {
    try {
      final local = await _localDataSource.getCachedRatios(
        ticker,
        isTtm: period == _Consts.ttm,
      );
      if (local != null) return right(local.map(_toRatios).toList());

      final remote = await _remoteDataSource.getRatios(ticker);

      await _localDataSource.cacheRatios(ticker, remote, isTtm: false);
      return right(remote.map(_toRatios).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KeyMetrics>>> getKeyMetrics(
    String ticker, {
    String period = 'annual',
  }) async {
    try {
      final local = await _localDataSource.getCachedKeyMetrics(
        ticker,
        isTtm: period == _Consts.ttm,
      );
      if (local != null) return right(local.map(_toKeyMetrics).toList());

      final remote = await _remoteDataSource.getKeyMetrics(ticker);

      await _localDataSource.cacheKeyMetrics(
        ticker,
        remote,
        isTtm: period == _Consts.ttm,
      );

      return right(remote.map(_toKeyMetrics).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<IncomeStatement>>> getIncomeStatements(
    String ticker, {
    String period = 'annual',
  }) async {
    try {
      final dtos = await _fetchStableIncomeStatements(ticker, period);
      final conversion = await _getCurrencyMultiplier(
        dtos.firstOrNull?.reportedCurrency,
        ticker,
      );
      return right(
        dtos
            .map(
              (d) => _toIncomeStatement(
                d,
                multiplier: conversion.multiplier,
                targetCurrency: conversion.targetCurrency,
              ),
            )
            .toList(),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CashFlowStatement>>> getCashFlowStatements(
    String ticker, {
    String period = 'annual',
  }) async {
    try {
      final dtos = await _fetchCashFlowStatements(ticker, period);
      final conversion = await _getCurrencyMultiplier(
        dtos.firstOrNull?.reportedCurrency,
        ticker,
      );
      return right(
        dtos
            .map(
              (d) => _toCashFlowStatement(
                d,
                multiplier: conversion.multiplier,
                targetCurrency: conversion.targetCurrency,
              ),
            )
            .toList(),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FullFinancials>> getFullFinancials(
    String ticker,
  ) async {
    try {
      final incA = await _fetchLegacyIncomeStatements(ticker, _Consts.annual);
      final incQ = await _fetchLegacyIncomeStatements(ticker, _Consts.quarter);
      final balA = (await getBalanceSheets(
        ticker,
        period: _Consts.annual,
      )).getOrElse(() => []);
      final balQ = (await getBalanceSheets(
        ticker,
        period: _Consts.quarter,
      )).getOrElse(() => []);
      final cashA = await _fetchCashFlowStatements(ticker, _Consts.annual);
      final cashQ = await _fetchCashFlowStatements(ticker, _Consts.quarter);

      final conversion = await _getCurrencyMultiplier(
        incA.firstOrNull?.reportedCurrency,
        ticker,
      );
      final multiplier = conversion.multiplier;
      final targetCurrency = conversion.targetCurrency;

      IncomeStatement mapInc(LegacyIncomeStatementDto d) => IncomeStatement(
        date: d.date,
        symbol: d.symbol,
        reportedCurrency: targetCurrency,
        period: d.period,
        revenue: (d.revenue ?? 0) * multiplier,
        grossProfit: (d.grossProfit ?? 0) * multiplier,
        operatingIncome: (d.operatingIncome ?? 0) * multiplier,
        netIncome: (d.netIncome ?? 0) * multiplier,
        eps: (d.eps ?? 0) * multiplier,
        ebitda: (d.ebitda ?? 0) * multiplier,
        costOfRevenue: (d.costOfRevenue ?? 0) * multiplier,
        operatingExpenses: (d.operatingExpenses ?? 0) * multiplier,
        costAndExpenses: (d.costAndExpenses ?? 0) * multiplier,
      );

      CashFlowStatement mapCash(CashFlowStatementDto d) => CashFlowStatement(
        date: d.date,
        symbol: d.symbol,
        reportedCurrency: targetCurrency,
        period: d.period,
        operatingCashFlow: d.operatingCashFlow * multiplier,
        investingCashFlow: d.netCashProvidedByInvestingActivities * multiplier,
        financingCashFlow: d.netCashProvidedByFinancingActivities * multiplier,
        capitalExpenditure: d.capitalExpenditure * multiplier,
        freeCashFlow: d.freeCashFlow * multiplier,
        dividendsPaid: d.netDividendsPaid * multiplier,
        cashAtBeginningOfPeriod: d.cashAtBeginningOfPeriod * multiplier,
        cashAtEndOfPeriod: d.cashAtEndOfPeriod * multiplier,
      );

      return right(
        FullFinancials(
          annualIncomeStatements: incA.map(mapInc).toList(),
          quarterlyIncomeStatements: incQ.map(mapInc).toList(),
          annualBalanceSheets: balA,
          quarterlyBalanceSheets: balQ,
          annualCashFlows: cashA.map(mapCash).toList(),
          quarterlyCashFlows: cashQ.map(mapCash).toList(),
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Future<List<IncomeStatementDto>> _fetchStableIncomeStatements(
    String ticker,
    String period,
  ) async {
    final local = await _localDataSource.getCachedIncomeStatements(
      ticker,
      period: period,
    );
    if (local != null) return local;

    final remote = await _remoteDataSource.getIncomeStatements(
      ticker,
      period: period,
    );
    await _localDataSource.cacheIncomeStatements(
      ticker,
      remote,
      period: period,
    );
    return remote;
  }

  Future<List<CashFlowStatementDto>> _fetchCashFlowStatements(
    String ticker,
    String period,
  ) async {
    final local = await _localDataSource.getCachedCashFlowStatements(
      ticker,
      period: period,
    );
    if (local != null) return local;

    final remote = await _remoteDataSource.getCashFlowStatements(
      ticker,
      period: period,
    );
    await _localDataSource.cacheCashFlowStatements(
      ticker,
      remote,
      period: period,
    );
    return remote;
  }

  Future<List<LegacyIncomeStatementDto>> _fetchLegacyIncomeStatements(
    String ticker,
    String period,
  ) async {
    final local = await _localDataSource.getCachedLegacyIncomeStatements(
      ticker,
      period: period,
    );
    if (local != null) return local;

    final remote = await _remoteDataSource.getLegacyIncomeStatements(
      ticker,
      period: period,
    );
    await _localDataSource.cacheLegacyIncomeStatements(
      ticker,
      remote,
      period: period,
    );
    return remote;
  }

  Future<({double multiplier, String targetCurrency})> _getCurrencyMultiplier(
    String? reportedCurrency,
    String ticker,
  ) async {
    if (reportedCurrency == null || reportedCurrency == _Consts.usd) {
      return (multiplier: 1.0, targetCurrency: _Consts.usd);
    }

    try {
      final pair = '${reportedCurrency}USD';

      final cachedRate = await _localDataSource.getCachedExchangeRate(pair);
      if (cachedRate != null) {
        return (multiplier: cachedRate, targetCurrency: _Consts.usd);
      }

      final rate = await _remoteDataSource.getExchangeRate(pair);

      if (rate != null) {
        await _localDataSource.cacheExchangeRate(pair, rate);
        return (multiplier: rate, targetCurrency: _Consts.usd);
      }
    } catch (e) {
      // Fallback to reported currency if conversion fails
    }

    return (multiplier: 1.0, targetCurrency: reportedCurrency);
  }

  List<FinancialDataPoint> _mapStableIncomeDataPoints(
    List<IncomeStatementDto> data,
    num Function(IncomeStatementDto) extractor,
  ) {
    return data
        .where((d) => d.date.isNotEmpty)
        .map(
          (d) => FinancialDataPoint(
            date: d.date,
            period: d.period,
            value: extractor(d).toDouble(),
          ),
        )
        .toList();
  }

  List<FinancialDataPoint> _mapCashFlowDataPoints(
    List<CashFlowStatementDto> data,
    num Function(CashFlowStatementDto) extractor,
  ) {
    return data
        .where((d) => d.date.isNotEmpty)
        .map(
          (d) => FinancialDataPoint(
            date: d.date,
            period: d.period,
            value: extractor(d).toDouble(),
          ),
        )
        .toList();
  }

  IncomeStatement _toIncomeStatement(
    IncomeStatementDto d, {
    double multiplier = 1.0,
    String? targetCurrency,
  }) {
    return IncomeStatement(
      date: d.date,
      symbol: d.symbol,
      reportedCurrency: targetCurrency ?? d.reportedCurrency,
      period: d.period,
      revenue: (d.revenue ?? 0.0) * multiplier,
      grossProfit: (d.grossProfit ?? 0.0) * multiplier,
      operatingIncome: (d.operatingIncome ?? 0.0) * multiplier,
      netIncome: (d.netIncome ?? 0.0) * multiplier,
      eps: (d.epsDiluted ?? 0.0) * multiplier,
      ebitda: (d.ebitda ?? 0.0) * multiplier,
      costOfRevenue: (d.costOfRevenue ?? 0.0) * multiplier,
      operatingExpenses: (d.operatingExpenses ?? 0.0) * multiplier,
      costAndExpenses: (d.costAndExpenses ?? 0.0) * multiplier,
    );
  }

  BalanceSheet _toBalanceSheet(
    BalanceSheetDto d, {
    double multiplier = 1.0,
    String? targetCurrency,
  }) {
    return BalanceSheet(
      date: d.date,
      symbol: d.symbol,
      reportedCurrency: targetCurrency ?? d.reportedCurrency,
      period: d.period ?? '',
      totalAssets: (d.totalAssets ?? 0) * multiplier,
      totalLiabilities: (d.totalLiabilities ?? 0) * multiplier,
      totalEquity: (d.totalEquity ?? 0) * multiplier,
      cashAndShortTermInvestments:
          (d.cashAndShortTermInvestments ?? 0) * multiplier,
      totalDebt: (d.totalDebt ?? 0) * multiplier,
      totalCurrentAssets: (d.totalCurrentAssets ?? 0) * multiplier,
      totalNonCurrentAssets: (d.totalNonCurrentAssets ?? 0) * multiplier,
      totalCurrentLiabilities: (d.totalCurrentLiabilities ?? 0) * multiplier,
      totalNonCurrentLiabilities:
          (d.totalNonCurrentLiabilities ?? 0) * multiplier,
      longTermDebt: (d.longTermDebt ?? 0) * multiplier,
      shortTermDebt: (d.shortTermDebt ?? 0) * multiplier,
    );
  }

  CashFlowStatement _toCashFlowStatement(
    CashFlowStatementDto d, {
    double multiplier = 1.0,
    String? targetCurrency,
  }) {
    return CashFlowStatement(
      date: d.date,
      symbol: d.symbol,
      reportedCurrency: targetCurrency ?? d.reportedCurrency,
      period: d.period,
      operatingCashFlow: d.operatingCashFlow * multiplier,
      investingCashFlow: d.netCashProvidedByInvestingActivities * multiplier,
      financingCashFlow: d.netCashProvidedByFinancingActivities * multiplier,
      capitalExpenditure: d.capitalExpenditure * multiplier,
      freeCashFlow: d.freeCashFlow * multiplier,
      dividendsPaid: d.netDividendsPaid * multiplier,
      cashAtBeginningOfPeriod: d.cashAtBeginningOfPeriod * multiplier,
      cashAtEndOfPeriod: d.cashAtEndOfPeriod * multiplier,
    );
  }

  KeyMetrics _toKeyMetrics(KeyMetricsDto d) {
    return KeyMetrics(
      symbol: d.symbol ?? '',
      date: d.date ?? '',
      period: d.period ?? '',
      returnOnEquity: d.returnOnEquity ?? 0,
    );
  }

  CompanyRatios _toRatios(RatiosDto d) {
    return CompanyRatios(
      symbol: d.symbol ?? '',
      date: d.date ?? '',
      period: d.period ?? '',
      priceToEarningsRatio: d.priceToEarningsRatio ?? 0,
      priceToFreeCashFlowRatio: d.priceToFreeCashFlowRatio ?? 0,
    );
  }
}
