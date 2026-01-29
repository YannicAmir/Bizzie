import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import '../../domain/interfaces/i_fcps_repository.dart';
import '../../domain/models/fcps_stats.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
  static const String usd = 'USD';
}

@LazySingleton(as: IFcpsRepository)
class FcpsRepositoryImpl implements IFcpsRepository {
  final FinancialStatementsRemoteDataSource _remoteDataSource;
  final FinancialStatementsFirestoreDataSource _localDataSource;

  FcpsRepositoryImpl(this._remoteDataSource, this._localDataSource);

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
                conversion.multiplier;
            result.add(cf.toFinancialDataPoint(fcps));
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
      return left(Failure.server(e.toString()));
    }
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
      // Fallback
    }

    return (multiplier: 1.0, targetCurrency: reportedCurrency);
  }
}
