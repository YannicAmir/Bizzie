import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:material_ui/material_ui.dart';

const _nextLabel = 'Next';
const _previousLabel = 'Previous';
const _mascotSize = 48.0;

class CompanyProfileTourTooltip extends StatelessWidget {
  final String description;
  final String mascotAsset;
  final double width;
  final VoidCallback? onTooltipTap;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const CompanyProfileTourTooltip({
    super.key,
    required this.description,
    required this.mascotAsset,
    required this.width,
    this.onTooltipTap,
    this.onNext,
    this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final onNext = this.onNext;
    final onPrevious = this.onPrevious;
    final hasActions = onNext != null || onPrevious != null;

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TourDialog(
            description: description,
            mascotAsset: mascotAsset,
            onTap: onTooltipTap,
          ),
          if (hasActions) ...[
            AppConstants.subSectionSpacing,
            _TourActions(onNext: onNext, onPrevious: onPrevious),
          ],
        ],
      ),
    );
  }
}

class _TourDialog extends StatelessWidget {
  final String description;
  final String mascotAsset;
  final VoidCallback? onTap;

  const _TourDialog({
    required this.description,
    required this.mascotAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.mainSectionContainerPadding),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(
            AppConstants.mainSectionBorderRadius,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExcludeSemantics(
              child: Image.asset(
                mascotAsset,
                width: _mascotSize,
                height: _mascotSize,
              ),
            ),
            AppConstants.subSectionHorizontalSpacing,
            Expanded(
              child: Text(
                description,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TourActions extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  const _TourActions({required this.onNext, required this.onPrevious});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onNext = this.onNext;
    final onPrevious = this.onPrevious;

    return Row(
      mainAxisAlignment: onPrevious == null
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceBetween,
      children: [
        if (onPrevious != null)
          TextButton(
            onPressed: onPrevious,
            style: TextButton.styleFrom(
              minimumSize: AppConstants.minTouchTargetSize,
            ),
            child: Text(
              _previousLabel,
              style: AppTextStyles.bodyMediumBold.copyWith(
                color: colorScheme.surface,
              ),
            ),
          ),
        if (onNext != null)
          FilledButton(
            onPressed: onNext,
            style: FilledButton.styleFrom(
              minimumSize: AppConstants.minTouchTargetSize,
            ),
            child: Text(
              _nextLabel,
              style: AppTextStyles.bodyMediumBold.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
      ],
    );
  }
}
