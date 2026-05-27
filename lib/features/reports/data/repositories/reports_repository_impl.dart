import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/reports/data/interfaces/i_reports_remote_datasource.dart';
import 'package:bizzie/features/reports/data/dtos/financial_report_dto.dart';
import 'package:bizzie/features/reports/data/dtos/sec_filing_dto.dart';
import 'package:bizzie/features/reports/data/dtos/upcoming_earnings_dto.dart';
import 'package:bizzie/features/reports/data/dtos/weekly_report_dto.dart';
import 'package:bizzie/features/reports/domain/interfaces/i_reports_repository.dart';
import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/reports/domain/models/sec_filing.dart';
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:bizzie/features/reports/domain/models/weekly_report.dart';
import 'package:bizzie/features/search/domain/interfaces/i_stock_repository.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/user/data/dtos/user_activity_dto.dart';
import 'package:bizzie/features/user/domain/models/user_activity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

final _logger = BizzieLogger('ReportsRepositoryImpl');

@LazySingleton(as: IReportsRepository)
class ReportsRepositoryImpl implements IReportsRepository {
  final IReportsRemoteDataSource _remoteDataSource;
  final IStockRepository _stockRepository;

  List<StockSymbol>? _cachedStocks;

  ReportsRepositoryImpl(this._remoteDataSource, this._stockRepository);

  @override
  Stream<Either<Failure, ReportsFeed>> getReportsFeed(List<String> tickers) {
    _logger.info('Requesting reports feed for ${tickers.length} ticker(s)');

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
      final weeklyStream = _remoteDataSource
          .getWeeklyReportsStream(tickers)
          .startWith([])
          .onErrorReturn([]);

      return Rx.combineLatest4(
            financialStream,
            secStream,
            earningsStream,
            weeklyStream,
            (
              List<FinancialReportDto> financials,
              List<SecFilingDto> filings,
              List<UpcomingEarningsDto> earnings,
              List<WeeklyReportDto> weekly,
            ) => (financials, filings, earnings, weekly),
          )
          .asyncMap<Either<Failure, ReportsFeed>>((data) async {
            await _ensureStockCache();
            final tickerToName = _buildTickerMap();

            final filings = _processSecFilings(data.$2);
            final earnings = _processUpcomingEarnings(data.$3, tickerToName);
            final reports = _processFinancialReports(data.$1);
            final weeklyReports = _processWeeklyReports(data.$4);

            _logger.info(
              'Reports feed emitted — filings: ${filings.length}, '
              'earnings: ${earnings.length}, weekly: ${weeklyReports.length}',
            );
            return right<Failure, ReportsFeed>(
              ReportsFeed(
                currentReports: reports.current,
                pastReports: reports.past,
                filings: filings,
                upcomingEarnings: earnings,
                weeklyReports: weeklyReports,
              ),
            );
          })
          .onErrorReturnWith((error, stackTrace) {
            if (error is ServerException) {
              return Left(Failure.server(error.message));
            }
            _logger.severe(
              'Unexpected error fetching reports',
              error,
              stackTrace,
            );
            return Left(
              Failure.server('Unexpected error fetching reports: $error'),
            );
          });
    } catch (e) {
      _logger.severe('Unexpected error setting up reports stream', e);
      return Stream.value(Left(Failure.server('Unexpected error: $e')));
    }
  }

  @override
  Stream<Either<Failure, UserActivity>> getUserActivityStream(String uid) {
    _logger.info('Subscribing to user activity stream for UID: $uid');
    return _remoteDataSource
        .getUserActivityStream(uid)
        .map<Either<Failure, UserActivity>>((dto) => Right(dto.toDomain()))
        .onErrorReturnWith((error, stackTrace) {
          if (error is ServerException) {
            return Left(Failure.server(error.message));
          }
          _logger.severe(
            'Unexpected error in user activity stream for UID: $uid',
            error,
            stackTrace,
          );
          return Left(Failure.server('Unexpected error: $error'));
        });
  }

  @override
  Future<Either<Failure, Unit>> markReportsViewed(
    String uid,
    DateTime timestamp,
  ) async {
    _logger.info('Marking reports viewed for UID: $uid');
    try {
      final activityDto = UserActivityDto(lastViewedReports: timestamp);
      await _remoteDataSource.updateUserActivity(uid, activityDto);
      _logger.info('Successfully marked reports viewed for UID: $uid');
      return Right(unit);
    } catch (e) {
      _logger.severe('Failed to mark reports viewed for UID: $uid', e);
      return Left(Failure.server(e.toString()));
    }
  }

  Future<void> _ensureStockCache() async {
    if (_cachedStocks == null) {
      _logger.info('Populating stock cache');
      final stocksResult = await _stockRepository.getAllStocks();
      stocksResult.fold(
        (failure) => _logger.warning(
          'Failed to populate stock cache: ${failure.errorMessage}',
        ),
        (stocks) {
          _cachedStocks = stocks;
          _logger.info('Stock cache populated with ${stocks.length} entries');
        },
      );
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

  List<WeeklyReport> _processWeeklyReports(List<WeeklyReportDto> dtos) {
    final reports = dtos.map((e) => e.toDomain()).toList();
    reports.sort(
      (a, b) =>
          (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)),
    );
    return reports;
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
