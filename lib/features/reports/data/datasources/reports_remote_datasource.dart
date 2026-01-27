import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/features/reports/data/dtos/financial_report_dto.dart';

import 'package:bizzie/features/reports/data/dtos/sec_filing_dto.dart';
import 'package:bizzie/features/reports/data/dtos/upcoming_earnings_dto.dart';
import 'package:bizzie/features/user/data/dtos/user_activity_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';

abstract class IReportsRemoteDataSource {
  Stream<List<FinancialReportDto>> getFinancialReportsStream(
    List<String> tickers,
  );
  Stream<List<SecFilingDto>> getSecFilingsStream(List<String> tickers);
  Stream<List<UpcomingEarningsDto>> getUpcomingEarningsStream(
    List<String> tickers,
  );
  Stream<UserActivityDto> getUserActivityStream(String uid);
  Future<void> updateUserActivity(String uid, UserActivityDto activity);
}

final _logger = BizzieLogger('ReportsRemoteDataSource');

@LazySingleton(as: IReportsRemoteDataSource)
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
          _logger.severe('Error in FinancialReport stream', e, s);
          throw ServerException(
            message: 'Failed to fetch financial reports: $e',
          );
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
          _logger.severe('Error in SecFilings stream', e, s);
          throw ServerException(message: 'Failed to fetch SEC filings: $e');
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
          _logger.severe('Error in UpcomingEarnings stream', e, s);
          throw ServerException(
            message: 'Failed to fetch upcoming earnings: $e',
          );
        });
  }

  @override
  Stream<UserActivityDto> getUserActivityStream(String uid) {
    _logger.info('Requesting UserActivity stream for UID: $uid');
    final path =
        '${FirestoreConstants.users}/$uid/${FirestoreConstants.activities}/${FirestoreConstants.userState}';
    return _firestoreService
        .getDocumentStream<UserActivityDto>(
          path: path,
          fromJson: UserActivityDto.fromJson,
          toJson: (dto) => dto.toJson(),
        )
        .map((dto) => dto ?? const UserActivityDto());
  }

  @override
  Future<void> updateUserActivity(String uid, UserActivityDto activity) async {
    _logger.info('Updating UserActivity for UID: $uid');
    final path =
        '${FirestoreConstants.users}/$uid/${FirestoreConstants.activities}/${FirestoreConstants.userState}';
    try {
      await _firestoreService.setDocument<UserActivityDto>(
        path: path,
        value: activity,
        toJson: (dto) => dto.toJson(),
      );
      _logger.info('Successfully updated UserActivity for UID: $uid');
    } catch (e, s) {
      _logger.severe('Failed to update UserActivity', e, s);
      rethrow;
    }
  }
}
