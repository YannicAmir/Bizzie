import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';

extension UserStateX on UserState {
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
