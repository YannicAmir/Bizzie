import 'package:injectable/injectable.dart';

@lazySingleton
class AnalyticsContext {
  bool isPostDeletion = false;
  bool isPostDeletionOnboarding = false;

  /// Resets all temporary flags.
  void reset() {
    isPostDeletion = false;
    isPostDeletionOnboarding = false;
  }
}
