import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:bizzie/shared/widgets/cards/filing_card_header.dart';
import 'package:material_ui/material_ui.dart';

const EdgeInsets _kOuterPadding = EdgeInsets.only(
  left: FilingCardHeader.contentInset,
  right: FilingCardHeader.trailingInset,
);
const EdgeInsets _kInnerPadding = EdgeInsets.all(16);
const double _kBadgeSpacing = 8;

class FilingCardContent extends StatelessWidget {
  final String formType;
  final AppBadgeStyle badgeStyle;
  final String? topic;
  final List<Widget> body;
  final Widget actions;

  const FilingCardContent({
    super.key,
    required this.formType,
    this.badgeStyle = AppBadgeStyle.neutral,
    this.topic,
    required this.body,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _kOuterPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: _kBadgeSpacing,
            runSpacing: _kBadgeSpacing,
            children: [
              AppBadge(text: formType, style: badgeStyle, isLarge: true),
              if (topic case final filingTopic?)
                AppBadge(
                  text: filingTopic,
                  style: AppBadgeStyle.muted,
                  isLarge: true,
                  isTruncated: true,
                ),
            ],
          ),
          AppConstants.secondarySectionSpacing,
          _FilingCardBody(children: body),
          actions,
        ],
      ),
    );
  }
}

class _FilingCardBody extends StatelessWidget {
  final List<Widget> children;

  const _FilingCardBody({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
        border: Border.all(
          color: theme.dividerColor,
          width:
              theme.dividerTheme.thickness ?? AppConstants.defaultBorderWidth,
        ),
      ),
      child: Padding(
        padding: _kInnerPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
