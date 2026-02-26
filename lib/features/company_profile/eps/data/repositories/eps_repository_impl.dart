import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/eps/domain/interfaces/i_eps_repository.dart';
import 'package:bizzie/features/company_profile/eps/domain/models/eps_stats.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
  static const String usd = 'USD';
}

@LazySingleton(as: IEpsRepository)
class EpsRepositoryImpl implements IEpsRepository {
  final FinancialStatementsRemoteDataSource _remoteDataSource;
  final FinancialStatementsFirestoreDataSource _localDataSource;

  EpsRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, (EpsStats, CompanyProfileDataOrigin)>> getEpsStats(
    String ticker,
  ) async {
    try {
      final annualRes = await _localDataSource.syncIncomeStatements(
        ticker,
        period: _Consts.annual,
        remoteFetcher: () => _remoteDataSource.getIncomeStatements(
          ticker,
          period: _Consts.annual,
        ),
      );

      final quartRes = await _localDataSource.syncIncomeStatements(
        ticker,
        period: _Consts.quarter,
        remoteFetcher: () => _remoteDataSource.getIncomeStatements(
          ticker,
          period: _Consts.quarter,
        ),
      );

      return annualRes.map(
        success: (annualS) => quartRes.map(
          success: (quartS) async {
            final annual = annualS.data;
            final quart = quartS.data;

            final conversionRes = await _getCurrencyMultiplier(
              annual.firstOrNull?.reportedCurrency ??
                  quart.firstOrNull?.reportedCurrency,
              ticker,
            );

            return conversionRes.fold((f) => left(f), (convData) {
              final conversion = convData.$1;
              final convOrigin = convData.$2;

              final result = EpsStats(
                reportedCurrency: conversion.targetCurrency,
                annualEps: _mapStableIncomeDataPoints(
                  annual,
                  (d) => (d.epsDiluted ?? 0.0) * conversion.multiplier,
                ),
                quarterlyEps: _mapStableIncomeDataPoints(
                  quart,
                  (d) => (d.epsDiluted ?? 0.0) * conversion.multiplier,
                ),
              );

              final origins = [annualS.origin, quartS.origin, convOrigin];
              final finalOrigin = origins.contains(CompanyProfileDataOrigin.api)
                  ? CompanyProfileDataOrigin.api
                  : origins.contains(CompanyProfileDataOrigin.db)
                  ? CompanyProfileDataOrigin.db
                  : CompanyProfileDataOrigin.cache;

              return right((result, finalOrigin));
            });
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
