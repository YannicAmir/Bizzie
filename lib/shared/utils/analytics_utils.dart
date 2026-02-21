import 'package:flutter/widgets.dart';

class AnalyticsUtils {
  /// Extracts and normalizes the page name from [RouteSettings].
  ///
  /// Collapses specific variations (like Company Profile tabs) into unified tracker names.
  static String? extractPageName(RouteSettings settings) {
    final name = settings.name;
    if (name == null || name.isEmpty) return null;

    // Unify Company Profile variations
    if (name.contains('companyProfile') || name.startsWith('cp_')) {
      return 'company_profile';
    }

    /// Return the name as is for others (router will explicitly name root 'home_screen')
    return name;
  }

  /// Ensures labels/values adhere to the strict 24-character limit
  static String truncate(String val) {
    if (val.length <= 24) return val;
    return val.substring(0, 24);
  }
}
