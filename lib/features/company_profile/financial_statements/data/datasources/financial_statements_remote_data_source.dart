import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/financial_dtos.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/fmp_sec_filing_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/balance_sheet_dto.dart';

abstract class FinancialStatementsRemoteDataSource {
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
  Future<List<FmpSecFilingDto>> getSecFilings(String ticker, {String? type});
}

@LazySingleton(as: FinancialStatementsRemoteDataSource)
class FinancialStatementsRemoteDataSourceImpl
    implements FinancialStatementsRemoteDataSource {
  static const int _defaultLimit = 1000;
  static const int _legacyLimit = 1000;

  final Dio _dio;
  final IConfigService _configService;

  FinancialStatementsRemoteDataSourceImpl(
    @Named('FmpDio') this._dio,
    this._configService,
  );

  String _sanitize(String ticker) => ticker.replaceAll('.', '-');

  String _formatDate(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);
  String get _v3Url => _removeTrailingSlash(_configService.fmpConfig.v3Url);

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
}
