import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;

/// Constructed eagerly during DI configuration — `tz.initializeTimeZones()`
/// must run before `configureDependencies` (see `bootstrap.dart`), otherwise
/// `tz.getLocation` throws a `LocationNotFoundException`.
@Singleton(as: ITimeProvider)
class TimeProviderImpl implements ITimeProvider {
  final tz.Location _eastern = tz.getLocation('America/New_York');

  @override
  DateTime get nowEt => tz.TZDateTime.now(_eastern);

  @override
  DateTime get nowUtc => DateTime.now().toUtc();

  @override
  DateTime get nowLocal => DateTime.now();

  @override
  DateTime toEt(DateTime dateTime) => tz.TZDateTime.from(dateTime, _eastern);

  @override
  bool isMarketOpen(DateTime dateTime) {
    // Market is open 9:30 AM - 4:00 PM ET, Monday - Friday.
    final et = toEt(dateTime);

    if (et.weekday == DateTime.saturday || et.weekday == DateTime.sunday) {
      return false;
    }

    const morningOpenMinutes = 9 * 60 + 30;
    const eveningCloseMinutes = 16 * 60;
    final minutesOfDay = et.hour * 60 + et.minute;

    return minutesOfDay >= morningOpenMinutes &&
        minutesOfDay < eveningCloseMinutes;
  }
}
