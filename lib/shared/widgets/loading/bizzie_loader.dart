import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:flutter/material.dart';

class BizzieLoader extends StatelessWidget {
  final String message;
  final String mascotAssetPath;

  const BizzieLoader({
    super.key,
    required this.message,
    this.mascotAssetPath = AppAssets.defaultMascot,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(
                height: 90,
                child: Image.asset(mascotAssetPath, fit: BoxFit.contain),
              ),
            ],
          ),
          const SizedBox(height: 64),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.loaderMessage,
          ),
        ],
      ),
    );
  }
}
