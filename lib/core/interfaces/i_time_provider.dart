abstract interface class ITimeProvider {
  /// Returns the current time and date in the Eastern Time (ET) zone.
  DateTime get nowEt;

  /// Returns the current time and date in UTC.
  DateTime get nowUtc;

  /// Returns the local time equivalent.
  DateTime get nowLocal;

  /// Checks if the market is currently open based on the provided [dateTime] (assumed to be ET).
  bool isMarketOpen(DateTime dateTime);
}
