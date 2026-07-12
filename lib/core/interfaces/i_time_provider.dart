abstract interface class ITimeProvider {
  /// Returns the current time and date in the Eastern Time (ET) zone.
  DateTime get nowEt;

  /// Returns the current time and date in UTC.
  DateTime get nowUtc;

  /// Returns the local time equivalent.
  DateTime get nowLocal;

  /// Converts [dateTime] to the Eastern Time (ET) zone.
  DateTime toEt(DateTime dateTime);

  /// Checks if the US stock market is open at the instant represented by
  /// [dateTime]. The value is converted to Eastern Time internally, so it may
  /// be provided in any time zone.
  bool isMarketOpen(DateTime dateTime);
}
