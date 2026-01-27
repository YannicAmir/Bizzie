import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_daily_brands_params.freezed.dart';

@freezed
abstract class GetDailyBrandsParams with _$GetDailyBrandsParams {
  const factory GetDailyBrandsParams({Sector? sector}) = _GetDailyBrandsParams;
}
