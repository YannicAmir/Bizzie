import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/market/domain/entities/sector_pe.dart';
import 'package:bizzie/features/market/domain/entities/sector_performance.dart';
import 'package:collection/collection.dart';

final _logger = BizzieLogger('MarketDataExtensions');

final _sectorAliases = {
  'informationtechnology': 'Technology',
  'consumerdiscretionary': 'Consumer Cyclical',
  'consumerstaples': 'Consumer Defensive',
  'telecommunicationservices': 'Communication Services',
  'healthcare': 'Healthcare',
};

String _normalize(String input) {
  return input.toLowerCase().replaceAll(' ', '').replaceAll('_', '').trim();
}

extension SectorPeListX on List<SectorPe> {
  double getPeForSector(String sector) {
    final targetNormalized = _normalize(
      _sectorAliases[_normalize(sector)] ?? sector,
    );

    final item = firstWhereOrNull(
      (e) => _normalize(e.sector) == targetNormalized,
    );

    if (item == null) {
      final available = map((e) => e.sector).toList();
      _logger.warning(
        'PE not found for sector: $sector (resolved: $targetNormalized). Available: $available',
      );
      return 0.0;
    }
    return item.pe;
  }

  String? getDateForSector(String sector) {
    final targetNormalized = _normalize(
      _sectorAliases[_normalize(sector)] ?? sector,
    );

    final item = firstWhereOrNull(
      (e) => _normalize(e.sector) == targetNormalized,
    );

    return item?.date;
  }
}

extension SectorPerformanceListX on List<SectorPerformance> {
  double getAverageChangeForSector(String sector) {
    final targetNormalized = _normalize(
      _sectorAliases[_normalize(sector)] ?? sector,
    );

    final item = firstWhereOrNull(
      (e) => _normalize(e.sector) == targetNormalized,
    );

    if (item == null) {
      final available = map((e) => e.sector).toList();
      _logger.warning(
        'Performance not found for sector: $sector (resolved: $targetNormalized). Available: $available',
      );
      return 0.0;
    }
    return item.averageChange;
  }

  String? getDateForSector(String sector) {
    final targetNormalized = _normalize(
      _sectorAliases[_normalize(sector)] ?? sector,
    );

    final item = firstWhereOrNull(
      (e) => _normalize(e.sector) == targetNormalized,
    );

    return item?.date;
  }
}
