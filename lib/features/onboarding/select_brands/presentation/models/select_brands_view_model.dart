import 'package:bizzie/features/onboarding/select_brands/domain/models/brand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_brands_view_model.freezed.dart';

@freezed
abstract class SelectBrandsViewModel with _$SelectBrandsViewModel {
  const factory SelectBrandsViewModel({
    required Brand brand,
    @Default(false) bool isSelected,
    @Default(false) bool shouldAnimate,
  }) = _SelectBrandsViewModel;
}
