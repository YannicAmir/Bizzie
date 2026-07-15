import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/balance_sheet_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/cash_flow_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/financial_dtos.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/income_statement_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';

abstract class IFinancialStatementsFirestoreDataSource {
  Future<result.CacheResult<List<FinancialStatementDto>>> syncFinancials(
    String ticker, {
    required String type,
    required String period,
    required Future<List<FinancialStatementDto>> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<result.CacheResult<List<IncomeStatementDto>>> syncIncomeStatements(
    String ticker, {
    required String period,
    required Future<List<IncomeStatementDto>> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<result.CacheResult<List<LegacyIncomeStatementDto>>>
  syncLegacyIncomeStatements(
    String ticker, {
    required String period,
    required Future<List<LegacyIncomeStatementDto>> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<result.CacheResult<List<CashFlowStatementDto>>> syncCashFlowStatements(
    String ticker, {
    required String period,
    required Future<List<CashFlowStatementDto>> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<result.CacheResult<List<BalanceSheetDto>>> syncBalanceSheets(
    String ticker, {
    required String period,
    required Future<List<BalanceSheetDto>> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<result.CacheResult<double>> syncExchangeRate(
    String pair, {
    required Future<double> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<(List<FinancialStatementDto>, CompanyProfileDataOrigin)?>
  getCachedFinancials(
    String ticker, {
    required String type,
    required String period,
  });
  Future<(List<IncomeStatementDto>, CompanyProfileDataOrigin)?>
  getCachedIncomeStatements(String ticker, {required String period});
  Future<(List<LegacyIncomeStatementDto>, CompanyProfileDataOrigin)?>
  getCachedLegacyIncomeStatements(String ticker, {required String period});
  Future<(List<CashFlowStatementDto>, CompanyProfileDataOrigin)?>
  getCachedCashFlowStatements(String ticker, {required String period});
  Future<(List<BalanceSheetDto>, CompanyProfileDataOrigin)?>
  getCachedBalanceSheets(String ticker, {required String period});
  Future<(double, CompanyProfileDataOrigin)?> getCachedExchangeRate(
    String pair,
  );
}
