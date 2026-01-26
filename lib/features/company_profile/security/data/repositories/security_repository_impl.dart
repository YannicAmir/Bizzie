import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/data/dtos/earnings_report_dto.dart';
import 'package:bizzie/features/company_profile/data/dtos/profile_dtos.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_security_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class _Consts {
  static const String usd = 'USD';
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
          isFund: profile.isFund ?? false,
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
  Future<Either<Failure, DateTime?>> getUpcomingEarningsDate(
    String ticker,
  ) async {
    try {
      List<EarningsReportDto>? earnings = await _localDataSource
          .getCachedEarningsReports(ticker);

      if (earnings == null) {
        earnings = await _remoteDataSource.getEarningsReports(ticker);
        await _localDataSource.cacheEarningsReports(ticker, earnings);
      }

      final now = DateTime.now();
      final oneDayAgo = now.subtract(const Duration(days: 1));
      final sevenDaysFromNow = now.add(const Duration(days: 7));

      final upcoming = earnings.where((e) {
        final date = DateTime.tryParse(e.date);
        if (date == null) return false;
        return date.isAfter(oneDayAgo) && date.isBefore(sevenDaysFromNow);
      }).toList();

      if (upcoming.isEmpty) return right(null);

      upcoming.sort((a, b) {
        final dateA = DateTime.parse(a.date);
        final dateB = DateTime.parse(b.date);
        return dateA.compareTo(dateB);
      });

      return right(DateTime.parse(upcoming.first.date));
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
