import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:bizzie/features/reports/data/dtos/financial_report_dto.dart';
import 'package:bizzie/features/reports/data/dtos/sec_filing_dto.dart';
import 'package:bizzie/features/reports/data/dtos/upcoming_earnings_dto.dart';
import 'package:bizzie/features/reports/data/dtos/weekly_report_dto.dart';
import 'package:bizzie/features/reports/data/interfaces/i_reports_remote_datasource.dart';
import 'package:bizzie/features/user/data/dtos/user_activity_dto.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('ReportsRemoteDataSource');

@Injectable(as: IReportsRemoteDataSource)
class ReportsRemoteDataSource implements IReportsRemoteDataSource {
  final FirestoreService _firestoreService;

  ReportsRemoteDataSource(this._firestoreService);

  @override
  Stream<List<FinancialReportDto>> getFinancialReportsStream(
    List<String> tickers,
  ) {
    _logger.info('Requesting FinancialReports stream for tickers: $tickers');
    return _firestoreService
        .getCollectionStreamChunked<FinancialReportDto>(
          path: FirestoreConstants.financialReports,
          whereInField: FirestoreConstants.ticker,
          values: tickers,
          fromJson: FinancialReportDto.fromJson,
          toJson: (dto) => dto.toJson(),
        )
        .handleError((e, s) {
          if (e is FirebaseException && e.code == 'permission-denied') {
            _logger.warning(
              'FinancialReport stream permission denied (expected on logout)',
            );
          } else {
            _logger.severe('Error in FinancialReport stream', e, s);
          }
        });
  }

  @override
  Stream<List<SecFilingDto>> getSecFilingsStream(List<String> tickers) {
    _logger.info('Requesting SecFilings stream for tickers: $tickers');
    return _firestoreService
        .getCollectionStreamChunked<SecFilingDto>(
          path: FirestoreConstants.secFilings,
          whereInField: FirestoreConstants.symbol,
          values: tickers,
          fromJson: SecFilingDto.fromJson,
          toJson: (dto) => dto.toJson(),
          chunkSize: 30,
        )
        .handleError((e, s) {
          if (e is FirebaseException && e.code == 'permission-denied') {
            _logger.warning(
              'SecFilings stream permission denied (expected on logout)',
            );
          } else {
            _logger.severe('Error in SecFilings stream', e, s);
          }
        });
  }

  @override
  Stream<List<UpcomingEarningsDto>> getUpcomingEarningsStream(
    List<String> tickers,
  ) {
    _logger.info('Requesting UpcomingEarnings stream for tickers: $tickers');
    return _firestoreService
        .getCollectionStreamChunked<UpcomingEarningsDto>(
          path: FirestoreConstants.upcomingEarnings,
          whereInField: FirestoreConstants.symbol,
          values: tickers,
          fromJson: UpcomingEarningsDto.fromJson,
          toJson: (dto) => dto.toJson(),
          chunkSize: 30,
        )
        .handleError((e, s) {
          if (e is FirebaseException && e.code == 'permission-denied') {
            _logger.warning(
              'UpcomingEarnings stream permission denied (expected on logout)',
            );
          } else {
            _logger.severe('Error in UpcomingEarnings stream', e, s);
          }
        });
  }

  @override
  Stream<List<WeeklyReportDto>> getWeeklyReportsStream(List<String> tickers) {
    _logger.info('Requesting WeeklyReports stream for tickers: $tickers');
    return _firestoreService
        .getMergedSubcollectionStreams<WeeklyReportDto>(
          rootCollection: FirestoreConstants.weeklyRecap,
          documentIds: tickers,
          subcollectionId: FirestoreConstants.weeks,
          fromJson: WeeklyReportDto.fromJson,
          injectDocumentIdAs: FirestoreConstants.ticker,
        )
        .map((reports) {
          _logger.info(
            'WeeklyReports stream emitted ${reports.length} report(s)',
          );
          return reports;
        })
        .handleError((e, s) {
          if (e is FirebaseException && e.code == 'permission-denied') {
            _logger.warning(
              'WeeklyReports stream permission denied (expected on logout)',
            );
          } else {
            _logger.severe('Error in WeeklyReports stream', e, s);
          }
        });
  }

  @override
  Stream<UserActivityDto> getUserActivityStream(String uid) {
    _logger.info('Requesting UserActivity stream for UID: $uid');

    return _firestoreService
        .getDocumentStream<UserActivityDto>(
          path: '${FirestoreConstants.users}/$uid/${FirestoreConstants.activities}/${FirestoreConstants.reportsActivity}',
          fromJson: UserActivityDto.fromJson,
          toJson: (dto) => dto.toJson(),
        )
        .map((dto) => dto ?? const UserActivityDto())
        .handleError((e, s) {
          if (e is FirebaseException && e.code == 'permission-denied') {
            _logger.warning(
              'UserActivity stream permission denied (expected on logout) for UID: $uid',
            );
          } else {
            _logger.severe('Error in UserActivity stream for UID: $uid', e, s);
          }
        });
  }

  @override
  Future<void> updateUserActivity(String uid, UserActivityDto activity) async {
    _logger.info('Updating UserActivity for UID: $uid');
    try {
      await _firestoreService.setDocument<UserActivityDto>(
        path: '${FirestoreConstants.users}/$uid/${FirestoreConstants.activities}/${FirestoreConstants.reportsActivity}',
        value: activity,
        toJson: (dto) => dto.toJson(),
      );
      _logger.info('Successfully updated user activity');
    } catch (e, s) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        _logger.warning('Failed to update user activity (permission-denied)');
      } else {
        _logger.severe('Failed to update user activity', e, s);
      }
      rethrow;
    }
  }
}
