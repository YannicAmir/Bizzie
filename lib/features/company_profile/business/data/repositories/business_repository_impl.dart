import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/business/data/interfaces/i_business_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/interfaces/i_financial_statements_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/datasources/financial_statements_remote_data_source.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/fmp_sec_filing_dto.dart';
import 'package:bizzie/features/company_profile/financial_statements/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/business/domain/interfaces/i_business_repository.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/business/domain/models/sec_filing.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';

  static const String def14a = 'DEF 14A';
  static const String form20F = '20-F';
  static const String form6K = '6-K';
}

@LazySingleton(as: IBusinessRepository)
class BusinessRepositoryImpl implements IBusinessRepository {
  final ICompanyRepository _companyRepository;
  final IBusinessFirestoreDataSource _localDataSource;
  final FinancialStatementsRemoteDataSource _financialRemoteDataSource;
  final IFinancialStatementsFirestoreDataSource _financialLocalDataSource;

  BusinessRepositoryImpl(
    this._companyRepository,
    this._localDataSource,
    this._financialRemoteDataSource,
    this._financialLocalDataSource,
  );

  @override
  Future<Either<Failure, (BusinessProfile, CompanyProfileDataOrigin)>>
  getBusinessProfile(String ticker) async {
    try {
      final results = await Future.wait([
        _companyRepository.getProfile(ticker),
        _financialRemoteDataSource.getSecFilings(ticker),
        _fetchLegacyIncomeStatements(ticker, _Consts.annual),
        _fetchLegacyIncomeStatements(ticker, _Consts.quarter),
        _localDataSource.getCachedProxyUrl(ticker),
      ]);

      final profileResult =
          results[0]
              as Either<Failure, (CompanyProfile, CompanyProfileDataOrigin)>;
      final secSearchFilings = results[1] as List<FmpSecFilingDto>;
      final annualResult =
          results[2]
              as (List<LegacyIncomeStatementDto>, CompanyProfileDataOrigin);
      final quarterlyResult =
          results[3]
              as (List<LegacyIncomeStatementDto>, CompanyProfileDataOrigin);
      final cachedProxyUrlTuple =
          results[4] as (String?, CompanyProfileDataOrigin)?;
      final cachedProxyUrl = cachedProxyUrlTuple?.$1;

      return profileResult.fold((failure) => left(failure), (profileData) {
        final profile = profileData.$1;
        final profileOrigin = profileData.$2;
        final annualIncome = annualResult.$1;
        final annualOrigin = annualResult.$2;
        final quarterlyIncome = quarterlyResult.$1;
        final quarterlyOrigin = quarterlyResult.$2;

        final isForeign = secSearchFilings.any(
          (f) => f.formType == _Consts.form20F || f.formType == _Consts.form6K,
        );

        final def14aUrlData = _getProxyOrAnnualUrlSync(
          ticker,
          secSearchFilings,
          cachedProxyUrl,
        );

        final annualFilings = _mapIncomeStatementsToFilings(annualIncome);
        final quarterlyFilings = _mapIncomeStatementsToFilings(quarterlyIncome);

        final origins = [profileOrigin, annualOrigin, quarterlyOrigin];

        final finalOrigin = origins.contains(CompanyProfileDataOrigin.api)
            ? CompanyProfileDataOrigin.api
            : origins.contains(CompanyProfileDataOrigin.db)
            ? CompanyProfileDataOrigin.db
            : CompanyProfileDataOrigin.cache;

        return right((
          BusinessProfile(
            symbol: profile.symbol,
            companyName: profile.companyName ?? ticker,
            sector: profile.sector ?? 'N/A',
            industry: profile.industry ?? 'N/A',
            description: profile.description ?? '',
            ceo: profile.ceo ?? 'N/A',
            website: profile.website ?? '',
            address: profile.address ?? '',
            city: profile.city ?? '',
            state: profile.state ?? '',
            zip: profile.zip ?? '',
            phone: profile.phone ?? '',
            fullTimeEmployees: profile.fullTimeEmployees ?? 'N/A',
            def14aUrl: def14aUrlData.url,
            isForeignCompany: isForeign,
            proxyFilingFormType:
                def14aUrlData.formType ?? (isForeign ? '20-F' : 'DEF 14A'),
            annualFilings: annualFilings,
            quarterlyFilings: quarterlyFilings,
          ),
          finalOrigin,
        ));
      });
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }

  ({String? url, String? formType}) _getProxyOrAnnualUrlSync(
    String ticker,
    List<FmpSecFilingDto> filings,
    String? cachedUrl,
  ) {
    if (cachedUrl != null) {
      final found = filings
          .where((f) => (f.finalLink ?? f.link) == cachedUrl)
          .firstOrNull;
      if (found != null) {
        return (url: cachedUrl, formType: found.formType);
      }
    }

    var target = filings.where((f) => f.formType == _Consts.def14a).firstOrNull;
    target ??= filings.where((f) => f.formType == _Consts.form20F).firstOrNull;

    if (target != null) {
      final url = target.finalLink ?? target.link;
      if (url != null) {
        _localDataSource.cacheProxyUrl(ticker, url);
        return (url: url, formType: target.formType);
      }
    }

    return (url: null, formType: null);
  }

  List<SecFiling> _mapIncomeStatementsToFilings(
    List<LegacyIncomeStatementDto> data,
  ) {
    return data
        .where(
          (e) =>
              (e.finalLink?.isNotEmpty ?? false) ||
              (e.link?.isNotEmpty ?? false),
        )
        .map((e) => e.toSecFiling())
        .toList();
  }

  Future<(List<LegacyIncomeStatementDto>, CompanyProfileDataOrigin)>
  _fetchLegacyIncomeStatements(String ticker, String period) async {
    final res = await _financialLocalDataSource.syncLegacyIncomeStatements(
      ticker,
      period: period,
      remoteFetcher: () => _financialRemoteDataSource.getLegacyIncomeStatements(
        ticker,
        period: period,
      ),
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
