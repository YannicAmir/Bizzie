import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MarketHoursFreshnessService {
  static const Duration marketOpenTtl = Duration(minutes: 15);

  final ITimeProvider _timeProvider;

  MarketHoursFreshnessService(this._timeProvider);

  bool isStale(DateTime? lastUpdated) {
    if (lastUpdated == null) return true;

    final nowEt = _timeProvider.nowEt;
    final lastUpdatedEt = _timeProvider.toEt(lastUpdated);

    if (_timeProvider.isMarketOpen(nowEt)) {
      return nowEt.difference(lastUpdatedEt) >= marketOpenTtl;
    }

    return _effectiveTradingDay(lastUpdatedEt) != _effectiveTradingDay(nowEt);
  }

  DateTime _effectiveTradingDay(DateTime et) {
    final isBeforeOpen = et.hour < 9 || (et.hour == 9 && et.minute < 30);
    var day = DateTime(et.year, et.month, et.day - (isBeforeOpen ? 1 : 0));

    while (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
      day = DateTime(day.year, day.month, day.day - 1);
    }

    return day;
  }
}
