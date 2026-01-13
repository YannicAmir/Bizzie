import 'package:bizzie/features/reports/domain/models/financial_report.dart';
import 'package:bizzie/features/reports/domain/models/sec_filing.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filing_view_model.freezed.dart';

@freezed
abstract class FilingViewModel with _$FilingViewModel {
  const factory FilingViewModel({
    required SecFiling filing,
    FinancialReport? report,
  }) = _FilingViewModel;
}
