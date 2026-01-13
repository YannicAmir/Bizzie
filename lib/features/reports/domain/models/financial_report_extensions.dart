import 'package:bizzie/features/reports/domain/models/financial_report.dart';

extension ReportStockActivityX on ReportStockActivity {
  bool get isBuyback => (netStockChangeShares ?? 0) <= 0;
}
