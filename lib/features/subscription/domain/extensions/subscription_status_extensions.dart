import 'package:bizzie/features/subscription/domain/enums/membership_scenario.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';

extension SubscriptionStatusExtensions on SubscriptionStatus {
  bool get isAnnual {
    if (!isSubscribed) return false;
    final planId = activePlanId?.toLowerCase();
    if (planId != null) return planId.contains('annual');
    return activeProductIds.any((id) => id.toLowerCase().contains('annual'));
  }

  bool get isMonthly {
    if (!isSubscribed) return false;
    final planId = activePlanId?.toLowerCase();
    if (planId != null) return planId.contains('monthly');
    return activeProductIds.any((id) => id.toLowerCase().contains('monthly'));
  }

  bool get isFreeTrial {
    if (!isSubscribed) return false;
    return periodType == SubscriptionPeriodType.trial ||
        periodType == SubscriptionPeriodType.intro;
  }

  MembershipScenario get scenario {
    if (!isSubscribed) {
      return MembershipScenario.notSubscribed;
    }

    if (isFreeTrial) {
      return MembershipScenario.freeTrial;
    }

    if (isAnnual) {
      return MembershipScenario.annual;
    }

    if (isMonthly) {
      return MembershipScenario.monthly;
    }

    return MembershipScenario.annual;
  }

  String get planTitle {
    switch (scenario) {
      case MembershipScenario.annual:
        return 'Annual Plan';
      case MembershipScenario.monthly:
        return 'Monthly Plan';
      case MembershipScenario.freeTrial:
        return 'Free Trial';
      case MembershipScenario.notSubscribed:
        return 'Subscription Plan';
    }
  }

  String? get trialRemainingText {
    if (!isFreeTrial || expirationDate == null) return null;

    final diff = expirationDate!.difference(DateTime.now().toUtc());
    if (diff.inDays > 0) {
      return '${diff.inDays} days left in your free trial.';
    } else {
      return 'Your free trial ends today.';
    }
  }
}
