import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TabContentFreshnessService {
  static const Duration ttl = Duration(hours: 24);

  final ITimeProvider _timeProvider;

  TabContentFreshnessService(this._timeProvider);

  bool isStale(DateTime? lastUpdated) {
    if (lastUpdated == null) return true;
    return _timeProvider.nowLocal.difference(lastUpdated) >= ttl;
  }
}
