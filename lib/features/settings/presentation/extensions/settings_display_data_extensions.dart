import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/settings/domain/models/settings_display_data.dart';

extension SettingsDisplayDataX on SettingsDisplayData {
  bool get isNotificationsToggleOn =>
      isAppNotificationsEnabled && isSystemNotificationsEnabled;

  Sector? get favoriteSectorOrNull => Sector.fromString(favoriteSector);
}
