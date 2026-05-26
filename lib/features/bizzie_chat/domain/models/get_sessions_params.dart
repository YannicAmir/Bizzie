import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_sessions_params.freezed.dart';

@freezed
abstract class GetSessionsParams with _$GetSessionsParams {
  const factory GetSessionsParams({
    required String uid,
    required String ticker,
  }) = _GetSessionsParams;
}
