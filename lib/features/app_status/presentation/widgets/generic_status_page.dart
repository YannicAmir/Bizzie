import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GenericStatusPage extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool isLargeImage;
  final bool isLoading;

  const GenericStatusPage({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
    this.buttonText,
    this.onButtonPressed,
    this.isLargeImage = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasButton = buttonText != null && onButtonPressed != null;

    return PopScope(
      canPop: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: SizedBox.expand(
            child: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: AppConstants.pagePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 104),
                        SizedBox(
                          height: isLargeImage ? 320 : 250,
                          width: isLargeImage ? 320 : 250,
                          child: Image.asset(imageAsset, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 32),
                        Text(title, style: theme.textTheme.displayLarge),
                        const SizedBox(height: 16),
                        Text(description, style: theme.textTheme.bodyLarge),
                        if (hasButton)
                          const SizedBox(height: 100)
                        else
                          const Spacer(flex: 2),
                      ],
                    ),
                  ),
                  if (hasButton)
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 32,
                      child: Row(
                        children: [
                          Expanded(
                            child: BizziePrimaryButton(
                              title: buttonText!,
                              onPressed: onButtonPressed,
                              isLoading: isLoading,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
