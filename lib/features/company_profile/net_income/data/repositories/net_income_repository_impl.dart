import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/net_income/domain/interfaces/i_net_income_repository.dart';
import 'package:bizzie/features/company_profile/net_income/domain/models/net_income_stats.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
  static const String usd = 'USD';
}

@LazySingleton(as: INetIncomeRepository)
class NetIncomeRepositoryImpl implements INetIncomeRepository {
  final FinancialStatementsRemoteDataSource _remoteDataSource;
  final FinancialStatementsFirestoreDataSource _localDataSource;

  NetIncomeRepositoryImpl(this._remoteDataSource, this._localDataSource);

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
        .map((d) => d.toFinancialDataPoint(extractor(d).toDouble()))
        .toList();
  }
}
