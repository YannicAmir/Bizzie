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

      return profileResult.fold((failure) => left(failure), (
        profileData,
      ) async {
        return quoteResult.fold((failure) => left(failure), (quoteData) async {
          final profile = profileData.$1;
          final quote = quoteData.$1;

          double? peRatioTTM;
          double? pfcfTTM;
          CompanyProfileDataOrigin ratiosOrigin =
              CompanyProfileDataOrigin.cache;

          try {
            final ttmRatios = await _ratiosRemoteDataSource.getRatiosTtm(
              ticker,
            );
            final ratio = ttmRatios.firstOrNull;
            peRatioTTM = ratio?.priceToEarningsRatioTTM;
            pfcfTTM = ratio?.priceToFreeCashFlowRatioTTM;
            if (ttmRatios.isNotEmpty) {
              ratiosOrigin = CompanyProfileDataOrigin.api;
            }
          } catch (_) {}

          final origins = [profileData.$2, quoteData.$2, ratiosOrigin];
          final finalOrigin = origins.contains(CompanyProfileDataOrigin.api)
              ? CompanyProfileDataOrigin.api
              : origins.contains(CompanyProfileDataOrigin.db)
              ? CompanyProfileDataOrigin.db
              : CompanyProfileDataOrigin.cache;

          return right((
            SecurityDetails.fromProfileAndQuote(
              profile: profile,
              quote: quote,
              peRatioTTM: peRatioTTM,
              pfcfTTM: pfcfTTM,
            ),
            finalOrigin,
          ));
        });
      });
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }

  @override
  Future<Either<Failure, (DateTime?, CompanyProfileDataOrigin)>>
  getUpcomingEarningsDate(String ticker) async {
    try {
      final res = await _securityLocalDataSource.syncEarningsReports(
        ticker,
        remoteFetcher: () =>
            _securityRemoteDataSource.getEarningsReports(ticker),
      );

      return res.map(
        success: (s) => right((_processEarnings(s.data), s.origin)),
        failure: (f) => left(f.failure),
        notFound: (_) => right((null, CompanyProfileDataOrigin.cache)),
      );
    } catch (e) {
      return left(Failure.server(e.toString()));
    }
  }

  DateTime? _processEarnings(List<EarningsReportDto> earnings) {
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

    if (upcoming.isEmpty) return null;

    upcoming.sort((a, b) {
      final dateA = a.toDateTime();
      final dateB = b.toDateTime();
      if (dateA == null || dateB == null) return 0;
      return dateA.compareTo(dateB);
    });

    return upcoming.first.toDateTime();
  }
}
