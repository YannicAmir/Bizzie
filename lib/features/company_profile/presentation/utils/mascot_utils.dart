import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';

class MascotUtils {
  static String getMascotAsset(UserState userState) {
    return userState.maybeMap(
      loaded: (u) => AppAssets.getMascotForSector(u.user.favoriteSector),
      orElse: () => AppAssets.defaultMascot,
    );
  }
}
