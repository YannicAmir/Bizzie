import 'package:dio/dio.dart';

import 'package:bizzie/features/company_profile/data/dtos/historical_price_eod_dto.dart';

import 'package:injectable/injectable.dart';
import 'package:bizzie/features/company_profile/data/dtos/profile_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/financial_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/ratios_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/ratios_ttm_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/governance_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/market_dtos.dart';
import 'package:bizzie/features/company_profile/data/dtos/fmp_sec_filing_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/balance_sheet_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/key_metrics_dto.dart';
import 'package:bizzie/services/config_service.dart';

abstract class CompanyRemoteDataSource {
  Future<List<ProfileDto>> getProfile(String ticker);
  Future<List<QuoteDto>> getQuote(String ticker);
  Future<List<RatiosDto>> getRatios(String ticker);
  Future<List<RatiosTtmDto>> getRatiosTtm(String ticker);
  Future<List<KeyMetricsDto>> getKeyMetrics(String ticker);
  Future<List<LegacyIncomeStatementDto>> getLegacyIncomeStatements(
    String ticker, {
    String period = 'annual',
  });
  Future<List<IncomeStatementDto>> getIncomeStatements(
    String ticker, {
    String period = 'annual',
  });
  Future<List<CashFlowStatementDto>> getCashFlowStatements(
    String ticker, {
    String period = 'annual',
  });
  Future<List<BalanceSheetDto>> getBalanceSheets(
    String ticker, {
    String period = 'annual',
  });
  Future<List<FinancialStatementDto>> getCashFlows(
    String ticker, {
    String period = 'annual',
  });
  Future<List<GovernanceDto>> getGovernance(String ticker);
  Future<List<ExecutiveDto>> getExecutives(String ticker);
  Future<List<DividendDto>> getDividends(String ticker);
  Future<List<NewsDto>> getStockNews(String ticker);
  Future<List<HistoricalPriceDto>> getHistoricalPrice(String ticker);
  Future<List<HistoricalPriceEodDto>> getHistoricalEodPrices(String ticker);
  Future<List<FmpSecFilingDto>> getSecFilings(String ticker, {String? type});
  Future<double?> getExchangeRate(String pair);
}

@LazySingleton(as: CompanyRemoteDataSource)
class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  static const int _defaultLimit = 1000;
  static const int _legacyLimit = 1000;
  static const int _newsLimit = 100;

  final Dio _dio;
  final ConfigService _configService;

  CompanyRemoteDataSourceImpl(@Named('FmpDio') this._dio, this._configService);

  String _sanitize(String ticker) => ticker.replaceAll('.', '-');

  String _formatDate(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);

  String get _v3Url => _removeTrailingSlash(_configService.fmpConfig.v3Url);

  @override
  Future<List<ProfileDto>> getProfile(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/profile',
      queryParameters: {'symbol': _sanitize(ticker)},
    );
    return (response.data as List).map((e) => ProfileDto.fromJson(e)).toList();
  }

  @override
  Future<List<QuoteDto>> getQuote(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/quote',
      queryParameters: {'symbol': _sanitize(ticker)},
    );
    return (response.data as List).map((e) => QuoteDto.fromJson(e)).toList();
  }

  @override
  Future<List<RatiosDto>> getRatios(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/ratios',
      queryParameters: {'symbol': _sanitize(ticker), 'limit': _defaultLimit},
    );
    return (response.data as List).map((e) => RatiosDto.fromJson(e)).toList();
  }

  @override
  Future<List<KeyMetricsDto>> getKeyMetrics(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/key-metrics',
      queryParameters: {'symbol': _sanitize(ticker), 'limit': _defaultLimit},
    );
    return (response.data as List)
        .map((e) => KeyMetricsDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<RatiosTtmDto>> getRatiosTtm(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/ratios-ttm',
      queryParameters: {'symbol': _sanitize(ticker)},
    );

    return (response.data as List)
        .map((e) => RatiosTtmDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<LegacyIncomeStatementDto>> getLegacyIncomeStatements(
    String ticker, {
    String period = 'annual',
  }) async {
    final response = await _dio.get(
      '$_v3Url/income-statement/${_sanitize(ticker)}',
      queryParameters: {'period': period, 'limit': _legacyLimit},
    );
    return (response.data as List)
        .map((e) => LegacyIncomeStatementDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<IncomeStatementDto>> getIncomeStatements(
    String ticker, {
    String period = 'annual',
  }) async {
    final response = await _dio.get(
      '$_baseUrl/income-statement',
      queryParameters: {
        'symbol': _sanitize(ticker),
        'period': period,
        'limit': _defaultLimit,
      },
    );
    return (response.data as List)
        .map((e) => IncomeStatementDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<CashFlowStatementDto>> getCashFlowStatements(
    String ticker, {
    String period = 'annual',
  }) async {
    final response = await _dio.get(
      '$_baseUrl/cash-flow-statement',
      queryParameters: {
        'symbol': _sanitize(ticker),
        'period': period,
        'limit': _defaultLimit,
      },
    );
    return (response.data as List)
        .map((e) => CashFlowStatementDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<BalanceSheetDto>> getBalanceSheets(
    String ticker, {
    String period = 'annual',
  }) async {
    final response = await _dio.get(
      '$_baseUrl/balance-sheet-statement',
      queryParameters: {
        'symbol': _sanitize(ticker),
        'period': period,
        'limit': _defaultLimit,
      },
    );
    return (response.data as List)
        .map((e) => BalanceSheetDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<FinancialStatementDto>> getCashFlows(
    String ticker, {
    String period = 'annual',
  }) async {
    final response = await _dio.get(
      '$_v3Url/cash-flow-statement/${_sanitize(ticker)}',
      queryParameters: {'period': period, 'limit': _defaultLimit},
    );
    return (response.data as List)
        .map((e) => FinancialStatementDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<GovernanceDto>> getGovernance(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/governance-executive-compensation',
      queryParameters: {'symbol': _sanitize(ticker)},
    );
    return (response.data as List)
        .map((e) => GovernanceDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<ExecutiveDto>> getExecutives(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/key-executives/${_sanitize(ticker)}',
    );
    return (response.data as List)
        .map((e) => ExecutiveDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<DividendDto>> getDividends(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/dividends',
      queryParameters: {'symbol': _sanitize(ticker)},
    );
    if (response.data is Map && response.data['historical'] != null) {
      return (response.data['historical'] as List)
          .map((e) => DividendDto.fromJson(e))
          .toList();
    }
    return (response.data as List).map((e) => DividendDto.fromJson(e)).toList();
  }

  @override
  Future<List<NewsDto>> getStockNews(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/news/stock',
      queryParameters: {'symbols': _sanitize(ticker), 'limit': _newsLimit},
    );
    return (response.data as List).map((e) => NewsDto.fromJson(e)).toList();
  }

  @override
  Future<List<HistoricalPriceDto>> getHistoricalPrice(String ticker) async {
    final now = DateTime.now();
    final oneYearAgo = now.subtract(const Duration(days: 365));

    final response = await _dio.get(
      '$_v3Url/historical-price-full/${_sanitize(ticker)}',
      queryParameters: {
        'from': _formatDate(oneYearAgo),
        'to': _formatDate(now),
      },
    );
    final history = response.data['historical'] as List?;
    if (history == null) return [];
    return history.map((e) => HistoricalPriceDto.fromJson(e)).toList();
  }

  @override
  Future<List<FmpSecFilingDto>> getSecFilings(
    String ticker, {
    String? type,
  }) async {
    final now = DateTime.now();
    final oneYearAgo = now.subtract(const Duration(days: 365));

    final response = await _dio.get(
      '$_baseUrl/sec-filings-search/symbol',
      queryParameters: {
        'symbol': _sanitize(ticker),
        'from': _formatDate(oneYearAgo),
        'to': _formatDate(now),
        'page': 0,
        'limit': _defaultLimit,
      },
    );
    return (response.data as List)
        .map((e) => FmpSecFilingDto.fromJson(e))
        .toList();
  }

  @override
  Future<double?> getExchangeRate(String pair) async {
    final response = await _dio.get(
      '$_baseUrl/quote',
      queryParameters: {'symbol': pair},
    );
    final list = response.data as List;
    if (list.isNotEmpty) {
      return list.first['price'] as double?;
    }
    return null;
  }

  @override
  Future<List<HistoricalPriceEodDto>> getHistoricalEodPrices(
    String ticker,
  ) async {
    final response = await _dio.get(
      '$_baseUrl/historical-price-eod/light',
      queryParameters: {'symbol': _sanitize(ticker)},
    );
    return (response.data as List)
        .map((e) => HistoricalPriceEodDto.fromJson(e))
        .toList();
  }
}
