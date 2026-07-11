import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/interfaces/i_financial_statements_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/balance_sheet_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_exchange_rate_repository.dart';
import '../../domain/interfaces/i_financial_statements_repository.dart';
import '../../domain/models/balance_sheet.dart';
import '../../domain/models/cash_flow_statement.dart';
import '../../domain/models/full_financials.dart';
import '../../domain/models/income_statement.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
}

@LazySingleton(as: IFinancialStatementsRepository)
class FinancialStatementsRepositoryImpl
    implements IFinancialStatementsRepository {
  final FinancialStatementsRemoteDataSource _remoteDataSource;
  final IFinancialStatementsFirestoreDataSource _localDataSource;
  final IExchangeRateRepository _exchangeRateRepository;

  FinancialStatementsRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._exchangeRateRepository,
  );

  @override
  Future<Either<Failure, (List<BalanceSheet>, CompanyProfileDataOrigin)>>
  getBalanceSheets(String ticker, {String period = 'annual'}) async {
    final res = await _localDataSource.syncBalanceSheets(
      ticker,
      period: period,
      remoteFetcher: () =>
          _remoteDataSource.getBalanceSheets(ticker, period: period),
    );

    if (res.isFailure) {
      return left((res as result.CacheFailure).failure);
    }
    if (res.isNotFound) {
      return left(const Failure.server('Balance sheets not found'));
    }

    final successRes = res as result.CacheSuccess<List<BalanceSheetDto>>;
    final dtos = successRes.data;
    final origin = successRes.origin;

    final conversionRes = await _exchangeRateRepository.getMultiplier(
      reportedCurrency: dtos.firstOrNull?.reportedCurrency,
      ticker: ticker,
    );

    return conversionRes.fold((f) => left(f), (convData) {
      final conversion = convData.$1;
      final convOrigin = convData.$2;

      final results = dtos
          .map(
            (d) => d.toDomain(
              multiplier: conversion.multiplier,
              targetCurrency: conversion.targetCurrency,
            ),
          )
          .cast<BalanceSheet>()
          .toList();

      final origins = [origin, convOrigin];
      final finalOrigin = origins.contains(CompanyProfileDataOrigin.api)
          ? CompanyProfileDataOrigin.api
          : origins.contains(CompanyProfileDataOrigin.db)
          ? CompanyProfileDataOrigin.db
          : CompanyProfileDataOrigin.cache;

      return right((results, finalOrigin));
    });
  }

  @override
  Future<Either<Failure, (List<IncomeStatement>, CompanyProfileDataOrigin)>>
  getIncomeStatements(String ticker, {String period = 'annual'}) async {
    final res = await _localDataSource.syncIncomeStatements(
      ticker,
      period: period,
      remoteFetcher: () =>
          _remoteDataSource.getIncomeStatements(ticker, period: period),
    );

    if (res.isFailure) {
      return left((res as result.CacheFailure).failure);
    }
    if (res.isNotFound) {
      return left(const Failure.server('Income statements not found'));
    }

    final successRes = res as result.CacheSuccess<List<IncomeStatementDto>>;
    final dtos = successRes.data;
    final origin = successRes.origin;

    final conversionRes = await _exchangeRateRepository.getMultiplier(
      reportedCurrency: dtos.firstOrNull?.reportedCurrency,
      ticker: ticker,
    );

    return conversionRes.fold((f) => left(f), (convData) {
      final conversion = convData.$1;
      final convOrigin = convData.$2;

      final results = dtos
          .map(
            (d) => d.toDomain(
              multiplier: conversion.multiplier,
              targetCurrency: conversion.targetCurrency,
            ),
          )
          .cast<IncomeStatement>()
          .toList();

      final origins = [origin, convOrigin];
      final finalOrigin = origins.contains(CompanyProfileDataOrigin.api)
          ? CompanyProfileDataOrigin.api
          : origins.contains(CompanyProfileDataOrigin.db)
          ? CompanyProfileDataOrigin.db
          : CompanyProfileDataOrigin.cache;

      return right((results, finalOrigin));
    });
  }

  @override
  Future<Either<Failure, (List<CashFlowStatement>, CompanyProfileDataOrigin)>>
  getCashFlowStatements(String ticker, {String period = 'annual'}) async {
    final res = await _localDataSource.syncCashFlowStatements(
      ticker,
      period: period,
      remoteFetcher: () =>
          _remoteDataSource.getCashFlowStatements(ticker, period: period),
    );

    if (res.isFailure) {
      return left((res as result.CacheFailure).failure);
    }
    if (res.isNotFound) {
      return left(const Failure.server('Cash flow statements not found'));
    }

    final successRes = res as result.CacheSuccess<List<CashFlowStatementDto>>;
    final dtos = successRes.data;
    final origin = successRes.origin;

    final conversionRes = await _exchangeRateRepository.getMultiplier(
      reportedCurrency: dtos.firstOrNull?.reportedCurrency,
      ticker: ticker,
    );

    return conversionRes.fold((f) => left(f), (convData) {
      final conversion = convData.$1;
      final convOrigin = convData.$2;

      final results = dtos
          .map(
            (d) => d.toDomain(
              multiplier: conversion.multiplier,
              targetCurrency: conversion.targetCurrency,
            ),
          )
          .cast<CashFlowStatement>()
          .toList();

      final origins = [origin, convOrigin];
      final finalOrigin = origins.contains(CompanyProfileDataOrigin.api)
          ? CompanyProfileDataOrigin.api
          : origins.contains(CompanyProfileDataOrigin.db)
          ? CompanyProfileDataOrigin.db
          : CompanyProfileDataOrigin.cache;

      return right((results, finalOrigin));
    });
  }

  @override
  Future<Either<Failure, (FullFinancials, CompanyProfileDataOrigin)>>
  getFullFinancials(String ticker) async {
    try {
      final incAData = await _fetchLegacyIncomeStatements(
        ticker,
        _Consts.annual,
      );
      final incQData = await _fetchLegacyIncomeStatements(
        ticker,
        _Consts.quarter,
      );

      final balAData = await getBalanceSheets(ticker, period: _Consts.annual);
      final balQData = await getBalanceSheets(ticker, period: _Consts.quarter);

      final cashAData = await _fetchCashFlowStatements(ticker, _Consts.annual);
      final cashQData = await _fetchCashFlowStatements(ticker, _Consts.quarter);

      final incA = incAData.$1;
      final incQ = incQData.$1;
      final balA = balAData
          .getOrElse(() => ([], CompanyProfileDataOrigin.cache))
          .$1;
      final balQ = balQData
          .getOrElse(() => ([], CompanyProfileDataOrigin.cache))
          .$1;
      final cashA = cashAData.$1;
      final cashQ = cashQData.$1;

      final conversionRes = await _exchangeRateRepository.getMultiplier(
        reportedCurrency: incA.firstOrNull?.reportedCurrency,
        ticker: ticker,
      );

      return conversionRes.fold((f) => left(f), (convData) {
        final conversion = convData.$1;
        final convOrigin = convData.$2;
        final multiplier = conversion.multiplier;
        final targetCurrency = conversion.targetCurrency;

        final origins = [
          incAData.$2,
          incQData.$2,
          balAData.getOrElse(() => ([], CompanyProfileDataOrigin.cache)).$2,
          balQData.getOrElse(() => ([], CompanyProfileDataOrigin.cache)).$2,
          cashAData.$2,
          cashQData.$2,
          convOrigin,
        ];

        final finalOrigin = origins.contains(CompanyProfileDataOrigin.api)
            ? CompanyProfileDataOrigin.api
            : origins.contains(CompanyProfileDataOrigin.db)
            ? CompanyProfileDataOrigin.db
            : CompanyProfileDataOrigin.cache;

        return right((
          FullFinancials(
            annualIncomeStatements: incA
                .map(
                  (d) => (d as dynamic).toDomain(
                    multiplier: multiplier,
                    targetCurrency: targetCurrency,
                  ),
                )
                .cast<IncomeStatement>()
                .toList(),
            quarterlyIncomeStatements: incQ
                .map(
                  (d) => (d as dynamic).toDomain(
                    multiplier: multiplier,
                    targetCurrency: targetCurrency,
                  ),
                )
                .cast<IncomeStatement>()
                .toList(),
            annualBalanceSheets: balA,
            quarterlyBalanceSheets: balQ,
            annualCashFlows: cashA
                .map(
                  (d) => (d as dynamic).toDomain(
                    multiplier: multiplier,
                    targetCurrency: targetCurrency,
                  ),
                )
                .cast<CashFlowStatement>()
                .toList(),
            quarterlyCashFlows: cashQ
                .map(
                  (d) => (d as dynamic).toDomain(
                    multiplier: multiplier,
                    targetCurrency: targetCurrency,
                  ),
                )
                .cast<CashFlowStatement>()
                .toList(),
          ),
          finalOrigin,
        ));
      });
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }

  Future<(List<CashFlowStatementDto>, CompanyProfileDataOrigin)>
  _fetchCashFlowStatements(String ticker, String period) async {
    final res = await _localDataSource.syncCashFlowStatements(
      ticker,
      period: period,
      remoteFetcher: () =>
          _remoteDataSource.getCashFlowStatements(ticker, period: period),
    );

    return res.map(
      success: (s) => (s.data, s.origin),
      failure: (_) =>
          (const <CashFlowStatementDto>[], CompanyProfileDataOrigin.cache),
      notFound: (_) =>
          (const <CashFlowStatementDto>[], CompanyProfileDataOrigin.cache),
    );
  }

  Future<(List<LegacyIncomeStatementDto>, CompanyProfileDataOrigin)>
  _fetchLegacyIncomeStatements(String ticker, String period) async {
    final res = await _localDataSource.syncLegacyIncomeStatements(
      ticker,
      period: period,
      remoteFetcher: () =>
          _remoteDataSource.getLegacyIncomeStatements(ticker, period: period),
    );

    return res.map(
      success: (s) => (s.data, s.origin),
      failure: (_) =>
          (const <LegacyIncomeStatementDto>[], CompanyProfileDataOrigin.cache),
      notFound: (_) =>
          (const <LegacyIncomeStatementDto>[], CompanyProfileDataOrigin.cache),
    );
  }
}
