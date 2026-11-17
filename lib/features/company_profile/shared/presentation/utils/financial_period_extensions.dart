import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/financial_table_enums.dart';

extension FinancialPeriodX on FinancialPeriod {
  FinancialDateFormat get tableDateFormat => switch (this) {
    FinancialPeriod.annual => FinancialDateFormat.monthYear,
    FinancialPeriod.quarterly => FinancialDateFormat.quarterShort,
  };

  String get tableHeaderLabel => switch (this) {
    FinancialPeriod.annual => 'Year Ended',
    FinancialPeriod.quarterly => 'Quarter Ended',
  };

  String historyTitle(String subject) => switch (this) {
    FinancialPeriod.annual => 'Yearly $subject',
    FinancialPeriod.quarterly => 'Quarterly $subject',
  };
}
