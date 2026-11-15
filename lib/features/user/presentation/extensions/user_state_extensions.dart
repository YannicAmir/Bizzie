import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';

const _fallbackDisplayName = 'Friend';

extension UserStateX on UserState {
  bool get isSubscribed =>
      maybeMap(loaded: (s) => s.user.isSubscribed, orElse: () => false);

  bool get canViewFullHistory => isSubscribed;

  String? get uidOrNull => mapOrNull(loaded: (s) => s.user.uid);

  String get displayName {
    final name = mapOrNull(loaded: (s) => s.user.name);
    return name == null || name.isEmpty ? _fallbackDisplayName : name;
  }

  String get favoriteSectorDisplayName =>
      mapOrNull(
        loaded: (s) => Sector.fromString(s.user.favoriteSector)?.displayName,
      ) ??
      '';

  String get mascotAsset {
    return map(
      initial: (_) => AppAssets.defaultMascot,
      loading: (s) => s.cachedSector != null
          ? AppAssets.getMascotForSector(s.cachedSector!)
          : AppAssets.defaultMascot,
      loaded: (s) => AppAssets.getMascotForSector(s.user.favoriteSector),
      needsProfile: (_) => AppAssets.defaultMascot,
      failure: (s) => s.cachedSector != null
          ? AppAssets.getMascotForSector(s.cachedSector!)
          : AppAssets.defaultMascot,
    );
  }
}
