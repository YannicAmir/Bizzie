import 'package:freezed_annotation/freezed_annotation.dart';

part 'mark_reports_viewed_params.freezed.dart';

@freezed
abstract class MarkReportsViewedParams with _$MarkReportsViewedParams {
  const factory MarkReportsViewedParams({
    required String uid,
    required DateTime timestamp,
  }) = _MarkReportsViewedParams;
}
