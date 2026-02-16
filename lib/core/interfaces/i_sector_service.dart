abstract class ISectorService {
  List<String> get stockMarketSectors;
  String getSectorApiName(String sectorName);
  String getSectorDescription(String sectorName);
  String getSectorDisplayName(String sectorName);
}
