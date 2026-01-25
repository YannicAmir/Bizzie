import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ComingSoonType { etf, fund }

class ComingSoonPlaceholder extends StatelessWidget {
  final ComingSoonType type;

  const ComingSoonPlaceholder({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final title = type == ComingSoonType.etf
        ? 'ETFs coming soon!'
        : 'Funds coming soon!';
    final instrumentName = type == ComingSoonType.etf ? 'ETFs' : 'funds';
    final subtitle =
        'We will notify you when $instrumentName are available in Bizzie!';

    return Padding(
      padding: AppConstants.pagePadding,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocSelector<UserBloc, UserState, String>(
              selector: (state) => state.maybeMap(
                loaded: (u) =>
                    AppAssets.getMascotForSector(u.user.favoriteSector),
                orElse: () => AppAssets.defaultMascot,
              ),
              builder: (context, mascotAsset) {
                return Image.asset(
                  mascotAsset,
                  height: 240,
                  fit: BoxFit.contain,
                );
              },
            ),
            AppConstants.mainSectionSpacing,
            Text(title, style: AppTextStyles.h2, textAlign: TextAlign.center),
            AppConstants.subSectionSpacing,
            Text(
              subtitle,
              style: AppTextStyles.bodyLargeSecondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
