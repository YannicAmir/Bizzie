import 'package:bizzie/features/app_status/domain/models/app_status.dart';

abstract class IAppStatusRepository {
  Stream<AppStatus> watchStatus();
  Future<AppStatus> checkStatus({String source = 'default'});
}
