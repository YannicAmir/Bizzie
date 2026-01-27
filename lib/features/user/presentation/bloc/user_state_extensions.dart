import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/presentation/extensions/sector_extensions.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';

extension UserStateX on UserState {
  String get mascotAsset {
    return maybeMap(
      loaded: (state) {
        final sector = Sector.fromString(state.user.favoriteSector);
        return sector?.mascotAsset ?? AppAssets.defaultMascot;
      },
      orElse: () => AppAssets.defaultMascot,
    );
  }
}
