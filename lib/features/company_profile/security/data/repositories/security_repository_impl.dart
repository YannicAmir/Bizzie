import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_remote_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_remote_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/earnings_report_dto.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_security_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class _Consts {
  static const String usd = 'USD';
}

@LazySingleton(as: ISecurityRepository)
class SecurityRepositoryImpl implements ISecurityRepository {
  final ICompanyRepository _companyRepository;
  final SecurityRemoteDataSource _securityRemoteDataSource;
  final SecurityFirestoreDataSource _securityLocalDataSource;
  final RatiosRemoteDataSource _ratiosRemoteDataSource;

  SecurityRepositoryImpl(
    this._companyRepository,
    this._securityRemoteDataSource,
    this._securityLocalDataSource,
    this._ratiosRemoteDataSource,
  );

  @override
  Future<Either<Failure, SecurityDetails>> getSecurityDetails(
    String ticker,
  ) async {
    try {
      final profileResult = await _companyRepository.getProfile(ticker);
      final quoteResult = await _companyRepository.getQuote(ticker);

      if (profileResult.isLeft()) {
        return left(ServerFailure('Failed to fetch profile'));
      }
      if (quoteResult.isLeft()) {
        return left(ServerFailure('Failed to fetch quote'));
      }

      final profile = profileResult.getOrElse(() => throw Exception());
      final quote = quoteResult.getOrElse(() => throw Exception());

      double? peRatioTTM;
      double? pfcfTTM;

      try {
        final ttmRatios = await _ratiosRemoteDataSource.getRatiosTtm(ticker);
        if (ttmRatios.isNotEmpty) {
          final ratio = ttmRatios.first;
          peRatioTTM = ratio.priceToEarningsRatioTTM;
          pfcfTTM = ratio.priceToFreeCashFlowRatioTTM;
        }
      } catch (_) {}

      final derivedExchange = _deriveExchange(profile);

      return right(
        SecurityDetails(
          ticker: profile.symbol,
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
      List<EarningsReportDto>? earnings = await _securityLocalDataSource
          .getCachedEarningsReports(ticker);

      if (earnings == null) {
        earnings = await _securityRemoteDataSource.getEarningsReports(ticker);
        await _securityLocalDataSource.cacheEarningsReports(ticker, earnings);
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

  String _deriveExchange(CompanyProfile profile) {
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
