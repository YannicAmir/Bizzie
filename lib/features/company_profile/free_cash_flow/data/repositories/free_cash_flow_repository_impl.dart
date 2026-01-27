import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import '../../domain/interfaces/i_free_cash_flow_repository.dart';
import '../../domain/models/free_cash_flow_stats.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
  static const String usd = 'USD';
}

@LazySingleton(as: IFreeCashFlowRepository)
class FreeCashFlowRepositoryImpl implements IFreeCashFlowRepository {
  final FinancialStatementsRemoteDataSource _remoteDataSource;
  final FinancialStatementsFirestoreDataSource _localDataSource;

  FreeCashFlowRepositoryImpl(this._remoteDataSource, this._localDataSource);

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

  List<FinancialDataPoint> _mapCashFlowDataPoints(
    List<CashFlowStatementDto> data,
    num Function(CashFlowStatementDto) extractor,
  ) {
    return data
        .where((d) => d.date.isNotEmpty)
        .map((d) => d.toFinancialDataPoint(extractor(d).toDouble()))
        .toList();
  }
}
