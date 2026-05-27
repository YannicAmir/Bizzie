import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/notifications/domain/models/notification_intent.dart';
import 'package:bizzie/features/reports/domain/enums/reports_analytics_enums.dart';
import 'package:injectable/injectable.dart';

@injectable
class ParseNotificationPayload
    implements SynchronousUseCase<NotificationIntent?, Map<String, dynamic>> {
  @override
  NotificationIntent? call(Map<String, dynamic> params) {
    final type = params['type'] as String?;
    final ticker = params['ticker'] as String?;
    final formType = params['formType'] as String?;
    final isEarnings = params['isEarnings']?.toString().toLowerCase() == 'true';

    if (type == 'sec_filing') {
      if (formType == '8-K' && !isEarnings) {
        if (ticker != null && ticker.isNotEmpty) {
          return NotificationIntent.companyProfile(ticker);
        }
      }

      return const NotificationIntent.reports(
        source: ReportsEntrySource.notification,
        notificationType: ReportsNotificationType.secFiling,
      );
    }

    if (type == 'earnings_notification') {
      return const NotificationIntent.reports(
        source: ReportsEntrySource.notification,
        notificationType: ReportsNotificationType.earningsNotification,
      );
    }

    if (type == 'subscription_drip') {
      return const NotificationIntent.paywall(PaywallSource.notification);
    }

    if (type == 'weekly_summary') {
      return const NotificationIntent.reports(
        source: ReportsEntrySource.notification,
        notificationType: ReportsNotificationType.weeklyReport,
      );
    }

    return null;
  }
}
