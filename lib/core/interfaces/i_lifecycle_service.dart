import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';

abstract class ILifecycleService {
  Stream<BizzieLifecycleState> get onLifecycleChanged;
  bool get isForeground;
  void dispose();
}
