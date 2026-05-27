import 'package:bizzie/features/reports/data/dtos/financial_report_dto.dart';
import 'package:bizzie/features/reports/data/dtos/sec_filing_dto.dart';
import 'package:bizzie/features/reports/data/dtos/upcoming_earnings_dto.dart';
import 'package:bizzie/features/reports/data/dtos/weekly_report_dto.dart';
import 'package:bizzie/features/user/data/dtos/user_activity_dto.dart';

abstract class IReportsRemoteDataSource {
  Stream<List<FinancialReportDto>> getFinancialReportsStream(
    List<String> tickers,
  );
  Stream<List<SecFilingDto>> getSecFilingsStream(List<String> tickers);
  Stream<List<UpcomingEarningsDto>> getUpcomingEarningsStream(
    List<String> tickers,
  );
  Stream<List<WeeklyReportDto>> getWeeklyReportsStream(List<String> tickers);
  Stream<UserActivityDto> getUserActivityStream(String uid);
  Future<void> updateUserActivity(String uid, UserActivityDto activity);
}
