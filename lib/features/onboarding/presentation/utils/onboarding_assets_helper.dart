import 'dart:ui';

import 'package:bizzie/core/domain/models/sector.dart';

import '../../../../app/themes/app_assets.dart';

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

  static Offset getMascotOffsetForSector(Sector sector) {
    switch (sector) {
      case Sector.financials:
        return const Offset(-7, 0);
      case Sector.communicationServices:
        return const Offset(6, 0);
      case Sector.consumerStaples:
        return const Offset(20, 0);
      case Sector.energy:
        return const Offset(-22, 0);
      case Sector.utilities:
        return const Offset(7, 0);
      case Sector.informationTechnology:
      case Sector.consumerDiscretionary:
      case Sector.healthCare:
      case Sector.industrials:
      case Sector.materials:
      case Sector.realEstate:
        return Offset.zero;
    }
  }
}
