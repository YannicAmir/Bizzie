import 'package:bizzie/features/company_profile/dividends/domain/models/dividend_event.dart';
import 'package:bizzie/shared/constants/app_constants.dart';

extension DividendHistoryPresentationX on List<DividendEvent> {
  String get totalPaidLabel {
    return length < AppConstants.dividendTableRowCount
        ? 'Total'
        : 'Total (Last 8 Quarters)';
  }
}
