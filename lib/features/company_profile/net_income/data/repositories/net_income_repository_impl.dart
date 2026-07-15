import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/interfaces/i_financial_statements_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/net_income/domain/interfaces/i_net_income_repository.dart';
import 'package:bizzie/features/company_profile/net_income/domain/models/net_income_stats.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_exchange_rate_repository.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
}

@LazySingleton(as: INetIncomeRepository)
class NetIncomeRepositoryImpl implements INetIncomeRepository {
  final FinancialStatementsRemoteDataSource _remoteDataSource;
  final IFinancialStatementsFirestoreDataSource _localDataSource;
  final IExchangeRateRepository _exchangeRateRepository;

  NetIncomeRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._exchangeRateRepository,
  );

  @override
  Future<Either<Failure, (NetIncomeStats, CompanyProfileDataOrigin)>>
  getNetIncomeStats(String ticker) async {
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

            final conversionRes = await _exchangeRateRepository.getMultiplier(
              reportedCurrency:
                  annual.firstOrNull?.reportedCurrency ??
                  quart.firstOrNull?.reportedCurrency,
              ticker: ticker,
            );

            return conversionRes.fold((f) => left(f), (convData) {
              final conversion = convData.$1;
              final convOrigin = convData.$2;

              final result = NetIncomeStats(
                reportedCurrency: conversion.targetCurrency,
                annualNetIncome: annual
                    .where((d) => d.date?.isNotEmpty == true)
                    .map(
                      (d) => d.toNetIncomeDataPoint(
                        multiplier: conversion.multiplier,
                      ),
                    )
                    .toList(),
                quarterlyNetIncome: quart
                    .where((d) => d.date?.isNotEmpty == true)
                    .map(
                      (d) => d.toNetIncomeDataPoint(
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
}
