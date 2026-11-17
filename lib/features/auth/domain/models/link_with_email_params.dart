import 'package:freezed_annotation/freezed_annotation.dart';

part 'link_with_email_params.freezed.dart';

@freezed
abstract class LinkWithEmailParams with _$LinkWithEmailParams {
  const factory LinkWithEmailParams({
    required String email,
    required String password,
  }) = _LinkWithEmailParams;
}
