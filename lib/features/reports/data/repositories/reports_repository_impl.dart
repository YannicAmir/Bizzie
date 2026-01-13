import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/data/datasources/reports_remote_datasource.dart';
import 'package:bizzie/features/reports/data/dtos/financial_report_dto.dart';
import 'package:bizzie/features/reports/data/dtos/sec_filing_dto.dart';
import 'package:bizzie/features/reports/data/dtos/upcoming_earnings_dto.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_repository.dart';
import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/domain/models/sec_filing.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/features/search/domain/interfaces/i_stock_repository.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/user/data/dtos/user_activity_dto.dart';
import 'package:bizzie/features/user/domain/models/user_activity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IReportsRepository)
class ReportsRepositoryImpl implements IReportsRepository {
  final IReportsRemoteDataSource _remoteDataSource;
  final IStockRepository _stockRepository;

  List<StockSymbol>? _cachedStocks;

  ReportsRepositoryImpl(this._remoteDataSource, this._stockRepository);

  @override
  Stream<Either<Failure, ReportsFeed>> getReportsFeed(List<String> tickers) {
    if (tickers.isEmpty) {
      return Stream.value(right<Failure, ReportsFeed>(const ReportsFeed()));
    }

    try {
      final financialStream = _remoteDataSource.getFinancialReportsStream(
        tickers,
      );
      final secStream = _remoteDataSource.getSecFilingsStream(tickers);
      final earningsStream = _remoteDataSource.getUpcomingEarningsStream(
        tickers,
      );

      return Rx.combineLatest3(
            financialStream,
            secStream,
            earningsStream,
            (financials, filings, earnings) => (financials, filings, earnings),
          )
          .asyncMap<Either<Failure, ReportsFeed>>((data) async {
            await _ensureStockCache();
            final tickerToName = _buildTickerMap();

            final filings = _processSecFilings(data.$2);
            final earnings = _processUpcomingEarnings(data.$3, tickerToName);
            final reports = _processFinancialReports(data.$1);

            return right<Failure, ReportsFeed>(
              ReportsFeed(
                currentReports: reports.current,
                pastReports: reports.past,
                filings: filings,
                upcomingEarnings: earnings,
              ),
            );
          })
          .onErrorReturnWith((error, stackTrace) {
            if (error is ServerException) {
              return Left(ServerFailure(error.message));
            }
            return Left(
              ServerFailure("Unexpected error fetching reports: $error"),
            );
          });
    } catch (e) {
      return Stream.value(Left(ServerFailure("Unexpected error: $e")));
    }
  }

  @override
  Stream<Either<Failure, UserActivity>> getUserActivityStream(String uid) {
    return _remoteDataSource
        .getUserActivityStream(uid)
        .map<Either<Failure, UserActivity>>((dto) => Right(dto.toDomain()))
        .onErrorReturnWith((error, stackTrace) {
          if (error is ServerException) {
            return Left(ServerFailure(error.message));
          }
          return Left(ServerFailure("Unexpected error: $error"));
        });
  }

  @override
  Future<void> markReportsViewed(String uid, DateTime timestamp) async {
    final activityDto = UserActivityDto(lastViewedReports: timestamp);
    await _remoteDataSource.updateUserActivity(uid, activityDto);
  }

  Future<void> _ensureStockCache() async {
    if (_cachedStocks == null) {
      final stocksResult = await _stockRepository.getAllStocks();
      stocksResult.fold((failure) => null, (stocks) => _cachedStocks = stocks);
    }
  }

  Map<String, String> _buildTickerMap() {
    final Map<String, String> tickerToName = {};
    if (_cachedStocks != null) {
      for (final s in _cachedStocks!) {
        tickerToName[s.symbol] = s.name;
      }
    }
    return tickerToName;
  }

  List<SecFiling> _processSecFilings(List<SecFilingDto> dtos) {
    final filings = dtos.map((e) => e.toDomain()).toList();
    filings.sort(
      (a, b) =>
          (b.filingDate ?? DateTime(0)).compareTo(a.filingDate ?? DateTime(0)),
    );
    return filings;
  }

  List<UpcomingEarnings> _processUpcomingEarnings(
    List<UpcomingEarningsDto> dtos,
    Map<String, String> tickerToName,
  ) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final earnings = dtos
        .map((e) => e.toDomain(companyName: tickerToName[e.symbol]))
        .where((e) {
          if (e.date == null) return true;
          return !e.date!.isBefore(todayStart);
        })
        .toList();

    earnings.sort(
      (a, b) => (a.date ?? DateTime(2100)).compareTo(b.date ?? DateTime(2100)),
    );
    return earnings;
  }

  ({List<FinancialReport> current, List<FinancialReport> past})
  _processFinancialReports(List<FinancialReportDto> dtos) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final domainList = dtos.map((e) => e.toDomain()).toList();

    final currentReports = domainList.where((r) {
      final analyzedCheck = r.dateAnalyzed?.isAfter(todayStart) ?? false;
      final filingCheck = r.filingDate?.isAfter(todayStart) ?? false;
      return analyzedCheck || filingCheck;
    }).toList();

    final pastReports = domainList.where((r) {
      final analyzedCheck = r.dateAnalyzed?.isAfter(todayStart) ?? false;
      final filingCheck = r.filingDate?.isAfter(todayStart) ?? false;
      return !analyzedCheck && !filingCheck;
    }).toList();

    currentReports.sort(
      (a, b) => (b.dateAnalyzed ?? DateTime(0)).compareTo(
        a.dateAnalyzed ?? DateTime(0),
      ),
    );

    pastReports.sort(
      (a, b) => (b.dateAnalyzed ?? DateTime(0)).compareTo(
        a.dateAnalyzed ?? DateTime(0),
      ),
    );

    return (current: currentReports, past: pastReports);
  }
}
