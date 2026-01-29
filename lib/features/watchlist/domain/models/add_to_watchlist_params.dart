import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_to_watchlist_params.freezed.dart';

@freezed
abstract class AddToWatchlistParams with _$AddToWatchlistParams {
  const factory AddToWatchlistParams({
    required Company company,
    required String uid,
  }) = _AddToWatchlistParams;
}
