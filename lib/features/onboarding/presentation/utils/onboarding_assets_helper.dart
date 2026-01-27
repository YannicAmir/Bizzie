import '../../../../app/themes/app_assets.dart';
import 'package:bizzie/core/domain/models/sector.dart';

class OnboardingAssetsHelper {
  static String getMascotForSector(Sector sector) {
    switch (sector) {
      case Sector.informationTechnology:
        return AppAssets.bizzieMascotIT;
      case Sector.financials:
        return AppAssets.bizzieMascotFinancials;
      case Sector.communicationServices:
        return AppAssets.bizzieMascotCommunicationServices;
      case Sector.consumerDiscretionary:
        return AppAssets.bizzieMascotConsumerDiscretionary;
      case Sector.consumerStaples:
        return AppAssets.bizzieMascotConsumerStaples;
      case Sector.energy:
        return AppAssets.bizzieMascotEnergy;
      case Sector.healthCare:
        return AppAssets.bizzieMascotHealthcare;
      case Sector.industrials:
        return AppAssets.bizzieMascotIndustrials;
      case Sector.materials:
        return AppAssets.bizzieMascotMaterials;
      case Sector.realEstate:
        return AppAssets.bizzieMascotRealEstate;
      case Sector.utilities:
        return AppAssets.bizzieMascotUtilities;
    }
  }
}
