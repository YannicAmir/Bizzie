enum AiReportForm {
  tenK('10-K'),
  tenQ('10-Q'),
  eightK('8-K'),
  recaps('Recaps');

  const AiReportForm(this.formType);

  final String formType;

  static List<AiReportForm> inOrder(List<String> formTypes) => {
    for (final type in formTypes)
      ...AiReportForm.values.where((form) => form.formType == type),
    ...AiReportForm.values,
  }.toList();
}
