enum SubscriptionPeriodType {
  normal,
  intro,
  trial,
  unknown;

  static SubscriptionPeriodType fromString(String? value) {
    if (value == null) return SubscriptionPeriodType.unknown;
    switch (value.toLowerCase()) {
      case 'normal':
        return SubscriptionPeriodType.normal;
      case 'intro':
      case 'introductory':
        return SubscriptionPeriodType.intro;
      case 'trial':
        return SubscriptionPeriodType.trial;
      default:
        return SubscriptionPeriodType.unknown;
    }
  }
}
