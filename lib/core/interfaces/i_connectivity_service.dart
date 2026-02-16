abstract class IConnectivityService {
  Stream<bool> get onConnectivityChanged;
  Future<bool> get hasInternetConnection;
}
