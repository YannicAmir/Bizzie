import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_metric_labels.freezed.dart';

@freezed
abstract class CurrencyMetricLabels with _$CurrencyMetricLabels {
  const factory CurrencyMetricLabels({
    required String metricLabel,
    String? modalMetricLabel,
    required String ttmTitle,
    required String chartKeyPrefix,
  }) = _CurrencyMetricLabels;
}
