import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyProfileLoadingState extends StatelessWidget {
  final String message;

  const CompanyProfileLoadingState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.maybeMap(
        loaded: (u) => AppAssets.getMascotForSector(u.user.favoriteSector),
        orElse: () => AppAssets.defaultMascot,
      ),
      builder: (context, mascot) {
        return BizzieLoader(message: message, mascotAssetPath: mascot);
      },
    );
  }
}
