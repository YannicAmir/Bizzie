import 'package:bizzie/features/company_profile/domain/models/dividend_event.dart';

extension DividendEventListExtensions on List<DividendEvent> {
  List<DividendEvent> get sortedByDateDesc =>
      List<DividendEvent>.from(this)..sort((a, b) => b.date.compareTo(a.date));

  double get totalDividends => fold(0.0, (sum, e) => sum + e.dividend);

  double get averageDividend => isEmpty ? 0.0 : totalDividends / length;
}
