import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/eps/domain/interfaces/i_eps_repository.dart';
import 'package:bizzie/features/company_profile/eps/domain/models/eps_stats.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_exchange_rate_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
}

@LazySingleton(as: IEpsRepository)
class EpsRepositoryImpl implements IEpsRepository {
  final FinancialStatementsRemoteDataSource _remoteDataSource;
  final FinancialStatementsFirestoreDataSource _localDataSource;
  final IExchangeRateRepository _exchangeRateRepository;

  EpsRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._exchangeRateRepository,
  );

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

      if (annualRes.isFailure) {
        return left((annualRes as result.CacheFailure).failure);
      }
      if (quartRes.isFailure) {
        return left((quartRes as result.CacheFailure).failure);
      }
      if (annualRes.isNotFound) {
        return left(const Failure.server('Annual data not found'));
      }
      if (quartRes.isNotFound) {
        return left(const Failure.server('Quarterly data not found'));
      }

      final annual = (annualRes as result.CacheSuccess<List<dynamic>>).data;
      final quart = (quartRes as result.CacheSuccess<List<dynamic>>).data;
      final annualOrigin = (annualRes as result.CacheSuccess).origin;
      final quartOrigin = (quartRes as result.CacheSuccess).origin;

      final conversionRes = await _exchangeRateRepository.getMultiplier(
        reportedCurrency:
            annual.firstOrNull?.reportedCurrency ??
            quart.firstOrNull?.reportedCurrency,
        ticker: ticker,
      );

      return conversionRes.fold((f) => left(f), (convData) {
        final conversion = convData.$1;
        final convOrigin = convData.$2;

        final epsStats = EpsStats(
          reportedCurrency: conversion.targetCurrency,
          annualEps: annual
              .where((d) => d.date?.isNotEmpty == true)
              .map(
                (d) => (d as dynamic).toEpsDataPoint(
                  multiplier: conversion.multiplier,
                ),
              )
              .cast<FinancialDataPoint>()
              .toList(),
          quarterlyEps: quart
              .where((d) => d.date?.isNotEmpty == true)
              .map(
                (d) => (d as dynamic).toEpsDataPoint(
                  multiplier: conversion.multiplier,
                ),
              )
              .cast<FinancialDataPoint>()
              .toList(),
        );

        final origins = [annualOrigin, quartOrigin, convOrigin];
        final finalOrigin = origins.contains(CompanyProfileDataOrigin.api)
            ? CompanyProfileDataOrigin.api
            : origins.contains(CompanyProfileDataOrigin.db)
            ? CompanyProfileDataOrigin.db
            : CompanyProfileDataOrigin.cache;

        return right((epsStats, finalOrigin));
      });
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }
}
