enum SegmentPeriod {
  annual('annual'),
  quarter('quarter');

  const SegmentPeriod(this.apiValue);

  final String apiValue;
}
