import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_brands_event.freezed.dart';

@freezed
abstract class SelectBrandsEvent with _$SelectBrandsEvent {
  const factory SelectBrandsEvent.started() = Started;

  const factory SelectBrandsEvent.updated({
    required List<Brand> selectedBrands,
  }) = Updated;

  const factory SelectBrandsEvent.toggleBrand(Brand brand) = ToggleBrand;
}
