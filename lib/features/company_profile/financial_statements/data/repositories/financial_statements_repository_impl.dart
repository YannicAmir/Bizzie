import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/balance_sheet_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import '../../domain/interfaces/i_financial_statements_repository.dart';
import '../../domain/models/balance_sheet.dart';
import '../../domain/models/cash_flow_statement.dart';
import '../../domain/models/full_financials.dart';
import '../../domain/models/income_statement.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
  static const String usd = 'USD';
}

@LazySingleton(as: IFinancialStatementsRepository)
class FinancialStatementsRepositoryImpl
    implements IFinancialStatementsRepository {
  final FinancialStatementsRemoteDataSource _remoteDataSource;
  final FinancialStatementsFirestoreDataSource _localDataSource;

  FinancialStatementsRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

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
              (d) => d.toDomain(
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
              (d) => d.toDomain(
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
              (d) => d.toDomain(
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

      return right(
        FullFinancials(
          annualIncomeStatements: incA
              .map(
                (d) => d.toDomain(
                  multiplier: multiplier,
                  targetCurrency: targetCurrency,
                ),
              )
              .toList(),
          quarterlyIncomeStatements: incQ
              .map(
                (d) => d.toDomain(
                  multiplier: multiplier,
                  targetCurrency: targetCurrency,
                ),
              )
              .toList(),
          annualBalanceSheets: balA,
          quarterlyBalanceSheets: balQ,
          annualCashFlows: cashA
              .map(
                (d) => d.toDomain(
                  multiplier: multiplier,
                  targetCurrency: targetCurrency,
                ),
              )
              .toList(),
          quarterlyCashFlows: cashQ
              .map(
                (d) => d.toDomain(
                  multiplier: multiplier,
                  targetCurrency: targetCurrency,
                ),
              )
              .toList(),
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
}
