import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bizzie/core/interfaces/i_connectivity_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('ConnectivityService');

@Singleton(as: IConnectivityService)
class ConnectivityService implements IConnectivityService {
  final _internetConnection = InternetConnection.createInstance(
    customCheckOptions: [
      InternetCheckOption(
        uri: Uri.parse('https://clients3.google.com/generate_204'),
        timeout: const Duration(seconds: 10),
      ),
      InternetCheckOption(
        uri: Uri.parse('https://1.1.1.1'),
        timeout: const Duration(seconds: 10),
      ),
    ],
    checkInterval: const Duration(seconds: 30),
  );

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
