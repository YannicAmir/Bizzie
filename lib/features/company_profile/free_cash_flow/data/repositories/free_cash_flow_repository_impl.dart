import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
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
  Future<Either<Failure, (FreeCashFlowStats, CompanyProfileDataOrigin)>>
  getFreeCashFlowStats(String ticker) async {
    try {
      final annualRes = await _localDataSource.syncCashFlowStatements(
        ticker,
        period: _Consts.annual,
        remoteFetcher: () => _remoteDataSource.getCashFlowStatements(
          ticker,
          period: _Consts.annual,
        ),
      );
      final quartRes = await _localDataSource.syncCashFlowStatements(
        ticker,
        period: _Consts.quarter,
        remoteFetcher: () => _remoteDataSource.getCashFlowStatements(
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

              final result = FreeCashFlowStats(
                reportedCurrency: conversion.targetCurrency,
                annualFcf: annual
                    .where((d) => d.date?.isNotEmpty == true)
                    .map(
                      (d) => d.toFreeCashFlowDataPoint(
                        multiplier: conversion.multiplier,
                      ),
                    )
                    .toList(),
                quarterlyFcf: quart
                    .where((d) => d.date?.isNotEmpty == true)
                    .map(
                      (d) => d.toFreeCashFlowDataPoint(
                        multiplier: conversion.multiplier,
                      ),
                    )
                    .toList(),
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
}
