import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_profile_tour_request.freezed.dart';

@freezed
abstract class CompanyProfileTourRequest with _$CompanyProfileTourRequest {
  const factory CompanyProfileTourRequest({
    required bool shouldPromptNotifications,
    required void Function() onPromptNotifications,
    void Function()? onTourSkipped,
  }) = _CompanyProfileTourRequest;
}
