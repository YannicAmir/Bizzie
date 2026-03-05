import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;

@Singleton(as: ITimeProvider)
class TimeProviderImpl implements ITimeProvider {
  late final tz.Location _eastern;

  TimeProviderImpl() {
    _eastern = tz.getLocation('America/New_York');
  }

  @override
  DateTime get nowEt => tz.TZDateTime.now(_eastern);

  @override
  DateTime get nowUtc => DateTime.now().toUtc();

  @override
  DateTime get nowLocal => DateTime.now();

  @override
  bool isMarketOpen(DateTime dateTime) {
    // Market is open 9:30 AM - 4:00 PM ET, Monday - Friday.
    if (dateTime.weekday == DateTime.saturday ||
        dateTime.weekday == DateTime.sunday) {
      return false;
    }

    final morningOpen = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      9,
      30,
    );
    final eveningClose = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      16,
    );

    return dateTime.isAfter(morningOpen) && dateTime.isBefore(eveningClose);
  }
}
