import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';

class BrandDisplayHelper {
  static List<Brand> getDailyPicksDisplayBrands(List<Brand> selectedBrands) {
    final List<Brand> displayBrands = [];
    if (selectedBrands.isNotEmpty) {
      displayBrands.addAll(selectedBrands.take(2));
    }
    if (displayBrands.isEmpty) {
      displayBrands.add(
        const Brand(
          name: 'Apple Inc.',
          company: 'Apple Inc.',
          ticker: 'AAPL',
          description: '',
        ),
      );
      displayBrands.add(
        const Brand(
          name: 'Microsoft',
          company: 'Microsoft',
          ticker: 'MSFT',
          description: '',
        ),
      );
    } else if (displayBrands.length == 1) {
      displayBrands.add(
        const Brand(
          name: 'Microsoft',
          company: 'Microsoft',
          ticker: 'MSFT',
          description: '',
        ),
      );
    }
    return displayBrands;
  }
}
