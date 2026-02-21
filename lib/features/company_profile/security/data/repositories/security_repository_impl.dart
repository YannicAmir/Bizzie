import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/datasources/security_remote_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/ratios_remote_data_source.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/earnings_report_dto.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_security_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

const _kUpcomingEarningsWindowDays = 7;

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
  Future<Either<Failure, (SecurityDetails, CompanyProfileDataOrigin)>>
  getSecurityDetails(String ticker) async {
    try {
      final profileResult = await _companyRepository.getProfile(ticker);
      final quoteResult = await _companyRepository.getQuote(ticker);

      if (profileResult.isLeft()) {
        return left(Failure.server('Failed to fetch profile'));
      }
      if (quoteResult.isLeft()) {
        return left(Failure.server('Failed to fetch quote'));
      }

      final profile = profileResult.getOrElse(() => throw Exception());
      final quote = quoteResult.getOrElse(() => throw Exception());

      double? peRatioTTM;
      double? pfcfTTM;

      try {
        final ttmRatios = await _ratiosRemoteDataSource.getRatiosTtm(ticker);
        final ratio = ttmRatios.firstOrNull;
        peRatioTTM = ratio?.priceToEarningsRatioTTM;
        pfcfTTM = ratio?.priceToFreeCashFlowRatioTTM;
      } catch (_) {}

      return right((
        SecurityDetails.fromProfileAndQuote(
          profile: profile,
          quote: quote,
          peRatioTTM: peRatioTTM,
          pfcfTTM: pfcfTTM,
        ),
        CompanyProfileDataOrigin.api,
      ));
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, (DateTime?, CompanyProfileDataOrigin)>>
  getUpcomingEarningsDate(String ticker) async {
    try {
      List<EarningsReportDto>? earnings = await _securityLocalDataSource
          .getCachedEarningsReports(ticker);
      CompanyProfileDataOrigin origin = CompanyProfileDataOrigin.cache;

      if (earnings == null) {
        earnings = await _securityRemoteDataSource.getEarningsReports(ticker);
        await _securityLocalDataSource.cacheEarningsReports(ticker, earnings);
        origin = CompanyProfileDataOrigin.api;
      }

      final now = DateTime.now();
      final oneDayAgo = now.subtract(const Duration(days: 1));
      final windowEnd = now.add(
        const Duration(days: _kUpcomingEarningsWindowDays),
      );

      final upcoming = earnings.where((e) {
        final date = e.toDateTime();
        if (date == null) return false;
        return date.isAfter(oneDayAgo) && date.isBefore(windowEnd);
      }).toList();

      if (upcoming.isEmpty) return right((null, origin));

      upcoming.sort((a, b) {
        final dateA = a.toDateTime();
        final dateB = b.toDateTime();
        if (dateA == null || dateB == null) return 0;
        return dateA.compareTo(dateB);
      });

      return right((upcoming.first.toDateTime(), origin));
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }
}
