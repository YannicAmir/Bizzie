import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/interfaces/i_sector_service.dart';
import 'package:bizzie/core/utils/sector_normalizer.dart';
import 'package:bizzie/shared/constants/sector_constants.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ISectorService)
class SectorService implements ISectorService {
  final IConfigService _configService;

  SectorService(this._configService);

  @override
  List<String> get stockMarketSectors => _configService.stockMarketSectors;

  @override
  String getSectorApiName(String sectorName) {
    final normalized = normalizeSectorKey(sectorName);
    return SectorConstants.sectorApiAliases[normalized] ?? sectorName;
  }

  @override
  String getSectorDescription(String sectorName) {
    final match = _getSectorMetaData(sectorName);
    return match?.value ?? "";
  }

  @override
  String getSectorDisplayName(String sectorName) {
    final match = _getSectorMetaData(sectorName);
    if (match != null) {
      return match.key;
    }

    return sectorName
        .split('_')
        .map((word) {
          if (word.isEmpty) return '';
          return '${word[0].toUpperCase()}${word.substring(1)}';
        })
        .join(' ');
  }

  ({String key, String value})? _getSectorMetaData(String sectorName) {
    final descriptionsMap = _configService.sectorDescriptions;

    if (descriptionsMap.containsKey(sectorName)) {
      return (key: sectorName, value: descriptionsMap[sectorName].toString());
    }

    final normalizedInput = normalizeSectorKey(sectorName);
    for (final entry in descriptionsMap.entries) {
      if (normalizeSectorKey(entry.key) == normalizedInput) {
        return (key: entry.key, value: entry.value.toString());
      }
    }

    return null;
  }
}
