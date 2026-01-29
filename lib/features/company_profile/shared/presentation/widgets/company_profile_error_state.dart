import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyProfileErrorState extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;

  const CompanyProfileErrorState({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.maybeMap(
        loaded: (u) => AppAssets.getMascotForSector(u.user.favoriteSector),
        orElse: () => AppAssets.defaultMascot,
      ),
      builder: (context, mascot) {
        return BizzieError(
          title: title ?? 'Something went wrong',
          message: message,
          mascotAssetPath: mascot,
          onRetry: onRetry,
        );
      },
    );
  }
}
