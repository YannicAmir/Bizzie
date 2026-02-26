import 'package:bizzie/core/enums/data_origin.dart';
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
  Future<Either<Failure, (FcpsStats, CompanyProfileDataOrigin)>> getFcpsStats(
    String ticker,
  ) async {
    try {
      final annualCFRes = await _localDataSource.syncCashFlowStatements(
        ticker,
        period: _Consts.annual,
        remoteFetcher: () => _remoteDataSource.getCashFlowStatements(
          ticker,
          period: _Consts.annual,
        ),
      );
      final quartCFRes = await _localDataSource.syncCashFlowStatements(
        ticker,
        period: _Consts.quarter,
        remoteFetcher: () => _remoteDataSource.getCashFlowStatements(
          ticker,
          period: _Consts.quarter,
        ),
      );
      final annualIncRes = await _localDataSource.syncIncomeStatements(
        ticker,
        period: _Consts.annual,
        remoteFetcher: () => _remoteDataSource.getIncomeStatements(
          ticker,
          period: _Consts.annual,
        ),
      );
      final quartIncRes = await _localDataSource.syncIncomeStatements(
        ticker,
        period: _Consts.quarter,
        remoteFetcher: () => _remoteDataSource.getIncomeStatements(
          ticker,
          period: _Consts.quarter,
        ),
      );

      return annualCFRes.map(
        success: (annualCFS) => quartCFRes.map(
          success: (quartCFS) => annualIncRes.map(
            success: (annualIncS) => quartIncRes.map(
              success: (quartIncS) async {
                final annualCF = annualCFS.data;
                final quartCF = quartCFS.data;
                final annualInc = annualIncS.data;
                final quartInc = quartIncS.data;

                final conversionRes = await _getCurrencyMultiplier(
                  annualCF.firstOrNull?.reportedCurrency ??
                      annualInc.firstOrNull?.reportedCurrency,
                  ticker,
                );

                return conversionRes.fold((f) => left(f), (convData) {
                  final conversion = convData.$1;
                  final convOrigin = convData.$2;

                  List<FinancialDataPoint> calculateFcps(
                    List<CashFlowStatementDto> cashFlows,
                    List<IncomeStatementDto> incomeStatements,
                  ) {
                    final result = <FinancialDataPoint>[];
                    final incomeMap = {
                      for (var i in incomeStatements) i.date: i,
                    };

                    for (var cf in cashFlows) {
                      var income = incomeMap[cf.date];
                      if (income != null &&
                          (income.weightedAverageShsOutDil ?? 0) > 0) {
                        final fcps =
                            (cf.freeCashFlow /
                                (income.weightedAverageShsOutDil ?? 1)) *
                            conversion.multiplier;
                        result.add(cf.toFinancialDataPoint(fcps));
                      }
                    }
                    return result;
                  }

                  final result = FcpsStats(
                    annualFcps: calculateFcps(annualCF, annualInc),
                    quarterlyFcps: calculateFcps(quartCF, quartInc),
                    reportedCurrency: conversion.targetCurrency,
                  );

                  final origins = [
                    annualCFS.origin,
                    quartCFS.origin,
                    annualIncS.origin,
                    quartIncS.origin,
                    convOrigin,
                  ];
                  final finalOrigin =
                      origins.contains(CompanyProfileDataOrigin.api)
                      ? CompanyProfileDataOrigin.api
                      : origins.contains(CompanyProfileDataOrigin.db)
                      ? CompanyProfileDataOrigin.db
                      : CompanyProfileDataOrigin.cache;

                  return right((result, finalOrigin));
                });
              },
              failure: (f) => left(f.failure),
              notFound: (_) =>
                  left(Failure.server('Quarterly income data not found')),
            ),
            failure: (f) => left(f.failure),
            notFound: (_) =>
                left(Failure.server('Annual income data not found')),
          ),
          failure: (f) => left(f.failure),
          notFound: (_) =>
              left(Failure.server('Quarterly cash flow data not found')),
        ),
        failure: (f) => left(f.failure),
        notFound: (_) =>
            left(Failure.server('Annual cash flow data not found')),
      );
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }

  Future<
    Either<
      Failure,
      (({double multiplier, String targetCurrency}), CompanyProfileDataOrigin)
    >
  >
  _getCurrencyMultiplier(String? reportedCurrency, String ticker) async {
    if (reportedCurrency == null || reportedCurrency == _Consts.usd) {
      return right((
        (multiplier: 1.0, targetCurrency: _Consts.usd),
        CompanyProfileDataOrigin.cache,
      ));
    }

    try {
      final pair = '${reportedCurrency}USD';

      final res = await _localDataSource.syncExchangeRate(
        pair,
        remoteFetcher: () =>
            _remoteDataSource.getExchangeRate(pair).then((v) => v ?? 1.0),
      );

      return res.map(
        success: (s) => right((
          (multiplier: s.data, targetCurrency: _Consts.usd),
          s.origin,
        )),
        failure: (f) => left(f.failure),
        notFound: (_) => right((
          (multiplier: 1.0, targetCurrency: reportedCurrency),
          CompanyProfileDataOrigin.cache,
        )),
      );
    } catch (e) {
      return right((
        (multiplier: 1.0, targetCurrency: reportedCurrency),
        CompanyProfileDataOrigin.cache,
      ));
    }
  }
}
