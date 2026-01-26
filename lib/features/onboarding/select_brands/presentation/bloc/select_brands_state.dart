import 'package:bizzie/features/onboarding/select_brands/presentation/models/select_brands_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_brands_state.freezed.dart';

@freezed
abstract class SelectBrandsState with _$SelectBrandsState {
  const SelectBrandsState._();

  const factory SelectBrandsState.initial() = _Initial;
  const factory SelectBrandsState.error(String message) = _Error;
  const factory SelectBrandsState.loaded({
    required List<SelectBrandsViewModel> sectorBrands,
    required List<SelectBrandsViewModel> globalBrands,
    required List<SelectBrandsViewModel> selectedBrands,
    required String sectorName,
  }) = _Loaded;

  bool get isMaxReached => map(
    initial: (_) => false,
    error: (_) => false,
    loaded: (state) => state.selectedBrands.length >= 5,
  );
}
