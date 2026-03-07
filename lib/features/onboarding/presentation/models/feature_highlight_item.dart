enum FeatureHighlightType {
  historicalData,
  financialReportAlerts,
  summaryIllustration,
  visualFinancials,
  brandSearch,
  easyToUnderstand,
}

class FeatureHighlightItem {
  final String title;
  final String description;
  final FeatureHighlightType type;

  const FeatureHighlightItem({
    required this.title,
    required this.description,
    required this.type,
  });
}
