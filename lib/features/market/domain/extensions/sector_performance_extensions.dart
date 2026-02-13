import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/utils/sector_normalizer.dart';
import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:collection/collection.dart';

final _logger = BizzieLogger('SectorPerformanceExtensions');

extension SectorPerformanceListX on List<SectorPerformance> {
  double? getAverageChangeForSector(String sectorApiName) {
    final targetNormalized = normalizeSectorKey(sectorApiName);

    final item = firstWhereOrNull(
      (e) => normalizeSectorKey(e.sector) == targetNormalized,
    );

    if (item == null) {
      final available = map((e) => e.sector).toList();
      _logger.warning(
        'Performance not found for sector: $sectorApiName (normalized: $targetNormalized). Available: $available',
      );
      return null;
    }
    return item.averageChange;
  }

  String? getDateForSector(String sectorApiName) {
    final targetNormalized = normalizeSectorKey(sectorApiName);

    final item = firstWhereOrNull(
      (e) => normalizeSectorKey(e.sector) == targetNormalized,
    );

    return item?.date;
  }
}
