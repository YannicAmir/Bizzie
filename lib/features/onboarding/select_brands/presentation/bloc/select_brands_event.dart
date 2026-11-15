import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_brands_event.freezed.dart';

@freezed
sealed class SelectBrandsEvent with _$SelectBrandsEvent {
  const factory SelectBrandsEvent.started({
    Sector? sector,
    required String sectorName,
    required List<Brand> selectedBrands,
  }) = Started;

  const factory SelectBrandsEvent.updated({
    required List<Brand> selectedBrands,
  }) = Updated;

  const factory SelectBrandsEvent.reset() = Reset;
}
