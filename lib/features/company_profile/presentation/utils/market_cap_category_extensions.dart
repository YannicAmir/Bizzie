import 'package:bizzie/features/company_profile/domain/enums/market_cap_category.dart';

extension MarketCapCategoryX on MarketCapCategory {
  String get label {
    switch (this) {
      case MarketCapCategory.mega:
        return 'Mega-Cap';
      case MarketCapCategory.large:
        return 'Large-Cap';
      case MarketCapCategory.mid:
        return 'Mid-Cap';
      case MarketCapCategory.small:
        return 'Small-Cap';
      case MarketCapCategory.micro:
        return 'Micro-Cap';
      case MarketCapCategory.nano:
        return 'Nano-Cap';
    }
  }
}
