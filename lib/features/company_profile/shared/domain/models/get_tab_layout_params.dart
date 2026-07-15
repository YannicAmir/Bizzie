import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_tab_layout_params.freezed.dart';

@freezed
abstract class GetTabLayoutParams with _$GetTabLayoutParams {
  const factory GetTabLayoutParams({required bool isSubscribed}) =
      _GetTabLayoutParams;
}
