enum AiReportForm {
  tenK('10-K'),
  tenQ('10-Q'),
  eightK('8-K');

  const AiReportForm(this.formType);

  final String formType;
}
