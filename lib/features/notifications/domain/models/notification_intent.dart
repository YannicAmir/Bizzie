import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_intent.freezed.dart';

@freezed
abstract class NotificationIntent with _$NotificationIntent {
  const factory NotificationIntent.companyProfile(String ticker) =
      _CompanyProfile;
  const factory NotificationIntent.reports({
    required ReportsEntrySource source,
    required ReportsNotificationType notificationType,
  }) = _Reports;
  const factory NotificationIntent.paywall(PaywallSource source) = _Paywall;
}
