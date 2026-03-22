import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_device_locale_service.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/i_exchange_rate_remote_data_source.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_exchange_rate_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

final _logger = BizzieLogger('ExchangeRateRepository');

@LazySingleton(as: IExchangeRateRepository)
class ExchangeRateRepositoryImpl implements IExchangeRateRepository {
  final IDeviceLocaleService _localeService;
  final ITimeProvider _timeProvider;
  final IExchangeRateRemoteDataSource _remoteDataSource;
  final FinancialStatementsFirestoreDataSource _localDataSource;

  ExchangeRateRepositoryImpl(
    this._localeService,
    this._timeProvider,
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<
    Either<
      Failure,
      (({double multiplier, String targetCurrency}), CompanyProfileDataOrigin)
    >
  >
  getMultiplier({
    required String? reportedCurrency,
    required String ticker,
  }) async {
    final targetCurrency = _localeService.preferredCurrency;

    if (reportedCurrency == null || reportedCurrency == targetCurrency) {
      return right((
        (multiplier: 1.0, targetCurrency: targetCurrency),
        CompanyProfileDataOrigin.cache,
      ));
    }

    try {
      final pair = '$reportedCurrency$targetCurrency';
      final requestDate = DateFormat('yyyy-MM-dd').format(_timeProvider.nowEt);

      _logger.info(
        'Fetching exchange rate for $pair on $requestDate (Base: $targetCurrency)',
      );

      final res = await _localDataSource.syncExchangeRate(
        pair,
        remoteFetcher: () async {
          final response = await _remoteDataSource.getExchangeRate(
            base: targetCurrency,
            target: reportedCurrency,
            date: requestDate,
          );

          final rate = response.rates[reportedCurrency];
          if (rate == null || rate == 0) {
            throw Exception('Rate for $reportedCurrency not found in response');
          }
          return 1.0 / rate;
        },
      );

      return res.map(
        success: (s) => right((
          (multiplier: s.data, targetCurrency: targetCurrency),
          s.origin,
        )),
        failure: (f) {
          _logger.warning(
            'Failed to fetch exchange rate for $pair, failing back to 1.0',
            f.failure,
          );
          return right((
            (multiplier: 1.0, targetCurrency: reportedCurrency),
            CompanyProfileDataOrigin.cache,
          ));
        },
        notFound: (_) {
          _logger.warning(
            'Exchange rate not found for $pair, failing back to 1.0',
          );
          return right((
            (multiplier: 1.0, targetCurrency: reportedCurrency),
            CompanyProfileDataOrigin.cache,
          ));
        },
      );
    } catch (e) {
      _logger.severe(
        'Unexpected error in ExchangeRateRepository for $ticker',
        e,
      );
      return right((
        (multiplier: 1.0, targetCurrency: reportedCurrency),
        CompanyProfileDataOrigin.cache,
      ));
    }
  }
}
