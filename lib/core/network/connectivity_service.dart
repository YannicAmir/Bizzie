import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bizzie/core/interfaces/i_connectivity_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('ConnectivityService');

@Singleton(as: IConnectivityService)
class ConnectivityService implements IConnectivityService {
  final _internetConnection = InternetConnection();

  ConnectivityService();

  @override
  Stream<bool> get onConnectivityChanged {
    return _internetConnection.onStatusChange
        .map((status) {
          final hasInternet = status == InternetStatus.connected;
          _logger.info('Connectivity Stream: $hasInternet ($status)');
          return hasInternet;
        })
        .startWith(true)
        .distinct();
  }

  @override
  Future<bool> get hasInternetConnection =>
      _internetConnection.hasInternetAccess;
}
