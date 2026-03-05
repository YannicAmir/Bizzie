import 'package:bizzie/features/company_profile/pe_ratio/presentation/views/pe_ratio_tab.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/views/pfcf_ratio_tab.dart';
import 'package:bizzie/features/company_profile/roe/presentation/views/roe_tab.dart';
import 'package:flutter/widgets.dart';

class MoreFeature {
  final String label;
  final String analyticsName;
  final Widget Function(String ticker) builder;

  const MoreFeature({
    required this.label,
    required this.analyticsName,
    required this.builder,
  });
}

final List<MoreFeature> defaultMoreFeatures = [
  MoreFeature(
    label: 'ROE',
    analyticsName: 'roe',
    builder: (ticker) => RoeTab(ticker: ticker),
  ),
  MoreFeature(
    label: 'P/E Ratio',
    analyticsName: 'pe',
    builder: (ticker) => PeRatioTab(ticker: ticker),
  ),
  MoreFeature(
    label: 'P/FCF Ratio',
    analyticsName: 'pfcf',
    builder: (ticker) => PfcfRatioTab(ticker: ticker),
  ),
];
