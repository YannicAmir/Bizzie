import 'package:bizzie/features/onboarding/domain/enums/onboarding_value_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'initial_company_selection.freezed.dart';

@freezed
abstract class InitialCompanySelection with _$InitialCompanySelection {
  const factory InitialCompanySelection({
    required String ticker,
    required OnboardingValueSource source,
  }) = _InitialCompanySelection;
}
