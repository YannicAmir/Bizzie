import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('CompanyProfileLoadGuardMixin');

mixin CompanyProfileLoadGuardMixin {
  String get featureName;

  String? get loadedTicker;

  bool shouldSkipLoad(String ticker, {required bool forceRefresh}) {
    if (forceRefresh || loadedTicker != ticker) return false;
    _logger.info(
      '$featureName already loaded for $ticker and is the correct ticker. '
      'Skipping load (Silent Refresh).',
    );
    return true;
  }
}
