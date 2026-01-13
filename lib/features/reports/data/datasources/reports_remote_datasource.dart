import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/features/reports/data/dtos/financial_report_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bizzie/features/reports/data/dtos/sec_filing_dto.dart';
import 'package:bizzie/features/reports/data/dtos/upcoming_earnings_dto.dart';
import 'package:bizzie/features/user/data/dtos/user_activity_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

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
    if (tickers.isEmpty) return Stream.value([]);

    final chunks = _chunkList(tickers, 10);
    final List<Stream<List<FinancialReportDto>>> streams = [];

    for (final chunk in chunks) {
      final stream = _firestoreService.instance
          .collection(FirestoreConstants.financialReports)
          .where(FirestoreConstants.ticker, whereIn: chunk)
          .snapshots()
          .map((snapshot) {
            _logger.info(
              'FinancialReport Snapshot emitted: ${snapshot.docs.length} docs for chunk: $chunk',
            );
            return snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;

              if (data[FirestoreConstants.ticker] == null) {}
              return FinancialReportDto.fromJson(data);
            }).toList();
          })
          .handleError((e, s) {
            _logger.severe('Error in FinancialReport stream', e, s);
            throw ServerException(
              message: 'Failed to fetch financial reports: $e',
            );
          });
      streams.add(stream);
    }

    return Rx.combineLatest(streams, (List<List<FinancialReportDto>> values) {
      return values.expand((x) => x).toList();
    });
  }

  @override
  Stream<List<SecFilingDto>> getSecFilingsStream(List<String> tickers) {
    if (tickers.isEmpty) return Stream.value([]);

    final chunks = _chunkList(tickers, 30);
    final List<Stream<List<SecFilingDto>>> streams = [];

    for (final chunk in chunks) {
      final stream = _firestoreService.instance
          .collection(FirestoreConstants.secFilings)
          .where(FirestoreConstants.symbol, whereIn: chunk)
          .snapshots()
          .map((snapshot) {
            _logger.info("SecFilings Snapshot: ${snapshot.docs.length} docs");
            return snapshot.docs.map((doc) {
              final data = doc.data();
              return SecFilingDto.fromJson(data).copyWith(id: doc.id);
            }).toList();
          })
          .handleError((e) {
            throw ServerException(message: 'Failed to fetch SEC filings: $e');
          });
      streams.add(stream);
    }

    return Rx.combineLatest(streams, (List<List<SecFilingDto>> values) {
      return values.expand((x) => x).toList();
    });
  }

  @override
  Stream<List<UpcomingEarningsDto>> getUpcomingEarningsStream(
    List<String> tickers,
  ) {
    if (tickers.isEmpty) return Stream.value([]);

    final chunks = _chunkList(tickers, 30);
    final List<Stream<List<UpcomingEarningsDto>>> streams = [];

    for (final chunk in chunks) {
      final stream = _firestoreService.instance
          .collection(FirestoreConstants.upcomingEarnings)
          .where(FirestoreConstants.symbol, whereIn: chunk)
          .snapshots()
          .map((snapshot) {
            _logger.info(
              'UpcomingEarnings Snapshot emitted: ${snapshot.docs.length} docs for chunk: $chunk',
            );
            return snapshot.docs.map((doc) {
              final data = doc.data();
              _logger.info('Found Upcoming Earning: ${data['symbol']}');
              return UpcomingEarningsDto.fromJson(data).copyWith(id: doc.id);
            }).toList();
          })
          .handleError((e, s) {
            _logger.severe('Error in UpcomingEarnings stream', e, s);
            throw ServerException(
              message: 'Failed to fetch upcoming earnings: $e',
            );
          });
      streams.add(stream);
    }

    return Rx.combineLatest(streams, (List<List<UpcomingEarningsDto>> values) {
      return values.expand((x) => x).toList();
    });
  }

  List<List<T>> _chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(
          i,
          i + chunkSize > list.length ? list.length : i + chunkSize,
        ),
      );
    }
    return chunks;
  }

  @override
  Stream<UserActivityDto> getUserActivityStream(String uid) {
    return _firestoreService.instance
        .collection(FirestoreConstants.users)
        .doc(uid)
        .collection(FirestoreConstants.activities)
        .doc(FirestoreConstants.userState)
        .snapshots()
        .map((snapshot) {
          try {
            if (!snapshot.exists || snapshot.data() == null) {
              return const UserActivityDto();
            }
            final dto = UserActivityDto.fromJson(snapshot.data()!);
            _logger.info('Parsed UserActivityDto: ${dto.lastViewedReports}');
            return dto;
          } catch (e, s) {
            _logger.severe('Failed to parse UserActivityDto', e, s);
            return const UserActivityDto();
          }
        });
  }

  @override
  Future<void> updateUserActivity(String uid, UserActivityDto activity) async {
    try {
      _logger.info(
        'Attempting to update UserActivity for $uid: ${activity.toJson()}',
      );
      await _firestoreService.instance
          .collection(FirestoreConstants.users)
          .doc(uid)
          .collection(FirestoreConstants.activities)
          .doc(FirestoreConstants.userState)
          .set(activity.toJson(), SetOptions(merge: true));
      _logger.info('Successfully updated UserActivity');
    } catch (e, s) {
      _logger.severe('Failed to update UserActivity', e, s);
      rethrow;
    }
  }
}
