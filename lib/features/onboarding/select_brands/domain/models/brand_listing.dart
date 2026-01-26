import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_listing.freezed.dart';

@freezed
abstract class BrandListing with _$BrandListing {
  const factory BrandListing({
    required List<Brand> globalBrands,
    required List<Brand> sectorBrands,
  }) = _BrandListing;
}
