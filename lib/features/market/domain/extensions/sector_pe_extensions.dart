import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/utils/sector_normalizer.dart';
import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:collection/collection.dart';

final _logger = BizzieLogger('SectorPeExtensions');

extension SectorPeListX on List<SectorPe> {
  double? getPeForSector(String sectorApiName) {
    final targetNormalized = normalizeSectorKey(sectorApiName);

    final item = firstWhereOrNull(
      (e) => normalizeSectorKey(e.sector) == targetNormalized,
    );

    if (item == null) {
      final available = map((e) => e.sector).toList();
      _logger.warning(
        'PE not found for sector: $sectorApiName (normalized: $targetNormalized). Available: $available',
      );
      return null;
    }
    return item.pe;
  }

  String? getDateForSector(String sectorApiName) {
    final targetNormalized = normalizeSectorKey(sectorApiName);

    final item = firstWhereOrNull(
      (e) => normalizeSectorKey(e.sector) == targetNormalized,
    );

    return item?.date;
  }
}
