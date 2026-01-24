import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/legacy_income_statement_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/profile_dtos.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_security_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/domain/models/company_executive.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/sec_filing.dart';
import 'package:bizzie/features/company_profile/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/domain/models/share_stats.dart';

abstract class _Consts {
  static const String annual = 'annual';
  static const String quarter = 'quarter';
  static const String usd = 'USD';
  static const String def14a = 'DEF 14A';
}

@LazySingleton(as: ISecurityRepository)
class SecurityRepositoryImpl implements ISecurityRepository {
  final CompanyRemoteDataSource _remoteDataSource;
  final CompanyFirestoreDataSource _localDataSource;

  SecurityRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, SecurityDetails>> getSecurityDetails(
    String ticker,
  ) async {
    try {
      final profile = await _getProfileAndCache(ticker);
      final quote = await _getQuoteAndCache(ticker);

      double? peRatioTTM;
      double? pfcfTTM;

      try {
        final ttmRatios = await _remoteDataSource.getRatiosTtm(ticker);
        if (ttmRatios.isNotEmpty) {
          final ratio = ttmRatios.first;
          peRatioTTM = ratio.priceToEarningsRatioTTM;
          pfcfTTM = ratio.priceToFreeCashFlowRatioTTM;
        }
      } catch (_) {}

      final derivedExchange = _deriveExchange(profile);

      return right(
        SecurityDetails(
          ticker: profile.symbol ?? ticker,
          name: profile.companyName ?? ticker,
          sector: profile.sector ?? 'N/A',
          industry: profile.industry ?? 'N/A',
          description: profile.description ?? '',
          currency: profile.currency ?? _Consts.usd,
          isEtf: profile.isEtf ?? false,
          isActivelyTrading: profile.isActivelyTrading ?? true,
          price: quote.price ?? 0.0,
          changesPercentage: quote.changesPercentage ?? 0.0,
          change: quote.change ?? 0.0,
          marketCap: quote.marketCap ?? 0.0,
          peRatioTTM: peRatioTTM ?? quote.pe,
          priceToFreeCashFlowTTM: pfcfTTM,
          beta: profile.beta,
          image: profile.image ?? '',
          exchangeShortName: derivedExchange,
          country: profile.country ?? '',
          ipoDate: profile.ipoDate ?? '',
          website: profile.website ?? '',
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BusinessProfile>> getBusinessProfile(
    String ticker,
  ) async {
    try {
      final profile = await _getProfileAndCache(ticker);
      final executives = await _getExecutivesAndCache(ticker);
      final def14aUrl = await _getProxyUrlAndCache(ticker);
      final filings = await _getSecFilingsForProfile(ticker);

      return right(
        BusinessProfile(
          symbol: profile.symbol ?? ticker,
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
          executives: executives,
          def14aUrl: def14aUrl,
          annualFilings: filings.annual,
          quarterlyFilings: filings.quarterly,
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ShareStats>> getShareStats(String ticker) async {
    try {
      final quote = await _getQuoteAndCache(ticker);
      final double current = quote.sharesOutstanding ?? 0.0;

      final annual = await _fetchLegacyIncomeStatements(ticker, _Consts.annual);
      final quart = await _fetchLegacyIncomeStatements(ticker, _Consts.quarter);

      List<FinancialDataPoint> mapIncomeDataPoints<T>(
        List<LegacyIncomeStatementDto> data,
        num Function(LegacyIncomeStatementDto) extractor,
      ) {
        return data.where((d) => d.date.isNotEmpty).map((d) {
          return FinancialDataPoint(
            date: d.date,
            period: d.period,
            value: extractor(d).toDouble(),
          );
        }).toList();
      }

      return right(
        ShareStats(
          currentSharesOutstanding: current,
          annualWeightedAverageShares: mapIncomeDataPoints(
            annual,
            (d) => d.weightedAverageShsOutDil ?? 0,
          ),
          quarterlyWeightedAverageShares: mapIncomeDataPoints(
            quart,
            (d) => d.weightedAverageShsOutDil ?? 0,
          ),
        ),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Future<ProfileDto> _getProfileAndCache(String ticker) async {
    final local = await _localDataSource.getCachedProfile(ticker);
    if (local != null) return local;

    final remote = await _remoteDataSource.getProfile(ticker);
    if (remote.isEmpty) {
      throw Exception("Profile not found");
    }
    final profile = remote.first;
    await _localDataSource.cacheProfile(ticker, profile);
    return profile;
  }

  Future<QuoteDto> _getQuoteAndCache(String ticker) async {
    final local = await _localDataSource.getCachedQuote(ticker);
    if (local != null) return local;

    final remote = await _remoteDataSource.getQuote(ticker);
    if (remote.isEmpty) {
      throw Exception("Quote not found");
    }
    final quote = remote.first;
    await _localDataSource.cacheQuote(ticker, quote);
    return quote;
  }

  Future<List<CompanyExecutive>> _getExecutivesAndCache(String ticker) async {
    var localGov = await _localDataSource.getCachedGovernance(ticker);
    var localExec = await _localDataSource.getCachedExecutives(ticker);

    if (localGov == null || localExec == null) {
      try {
        final govList = await _remoteDataSource.getGovernance(ticker);
        final execList = await _remoteDataSource.getExecutives(ticker);
        if (govList.isNotEmpty) {
          localGov = govList.first;
          localExec = execList;
          await _localDataSource.cacheGovernance(ticker, localGov, localExec);
        }
      } catch (_) {}
    }

    return localExec
            ?.map(
              (e) => CompanyExecutive(
                name: e.name,
                title: e.title,
                totalPay: e.pay,
                currencyPay: e.currencyPay,
                gender: e.gender,
                yearBorn: e.yearBorn,
              ),
            )
            .toList() ??
        [];
  }

  Future<String?> _getProxyUrlAndCache(String ticker) async {
    String? url = await _localDataSource.getCachedProxyUrl(ticker);
    if (url != null) return url;

    try {
      final filings = await _remoteDataSource.getSecFilings(ticker);
      final proxy = filings
          .where((f) => f.formType == _Consts.def14a)
          .firstOrNull;
      if (proxy != null) {
        url = proxy.finalLink ?? proxy.link;
        if (url != null) {
          await _localDataSource.cacheProxyUrl(ticker, url);
        }
      }
    } catch (_) {}
    return url;
  }

  Future<({List<SecFiling> annual, List<SecFiling> quarterly})>
  _getSecFilingsForProfile(String ticker) async {
    List<SecFiling> annualFilings = [];
    List<SecFiling> quarterlyFilings = [];

    try {
      final annualIncome = await _fetchLegacyIncomeStatements(
        ticker,
        _Consts.annual,
      );
      final quarterIncome = await _fetchLegacyIncomeStatements(
        ticker,
        _Consts.quarter,
      );

      List<SecFiling> map(List<LegacyIncomeStatementDto> list) {
        return list
            .where(
              (e) =>
                  (e.finalLink?.isNotEmpty ?? false) ||
                  (e.link?.isNotEmpty ?? false),
            )
            .map(
              (e) => SecFiling(
                date: e.date,
                year: e.date.substring(0, 4),
                period: e.period,
                link: e.finalLink ?? e.link ?? '',
              ),
            )
            .toList();
      }

      annualFilings = map(annualIncome);
      quarterlyFilings = map(quarterIncome);
    } catch (_) {}
    return (annual: annualFilings, quarterly: quarterlyFilings);
  }

  Future<List<LegacyIncomeStatementDto>> _fetchLegacyIncomeStatements(
    String ticker,
    String period,
  ) async {
    final local = await _localDataSource.getCachedLegacyIncomeStatements(
      ticker,
      period: period,
    );
    if (local != null) return local;

    final remote = await _remoteDataSource.getLegacyIncomeStatements(
      ticker,
      period: period,
    );
    await _localDataSource.cacheLegacyIncomeStatements(
      ticker,
      remote,
      period: period,
    );
    return remote;
  }

  String _deriveExchange(ProfileDto profile) {
    if (profile.exchangeShortName != null &&
        profile.exchangeShortName!.isNotEmpty) {
      return profile.exchangeShortName!;
    }
    if (profile.exchange != null) {
      if (profile.exchange!.contains('Nasdaq')) return 'NASDAQ';
      if (profile.exchange!.contains('New York')) return 'NYSE';
      return profile.exchange!;
    }
    return 'N/A';
  }
}
