import 'package:bizzie/app/l10n/bizzie_localizations.dart';

extension ProfileLocalizations on BizzieLocalizations {
  String get bizziePlus => getString(en: 'Bizzie Plus');

  String get profileSettings => getString(en: 'Settings');

  String get profileSectorDescriptionFallback =>
      getString(en: 'Description unavailable.');

  String profileJoined(String date) {
    return getString(en: 'Joined $date');
  }

  String get upgradeToBizziePlus => getString(en: 'Upgrade to Bizzie Plus');

  String get subscribeToUnlock =>
      getString(en: 'Subscribe to unlock all of Bizzie\'s features');

  String get seeMoreDetails => getString(en: 'See More Details');
}
