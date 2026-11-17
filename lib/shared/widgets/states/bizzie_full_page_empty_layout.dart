import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:material_ui/material_ui.dart';

class BizzieFullPageEmptyLayout extends StatelessWidget {
  final Widget content;
  final Widget action;
  final EdgeInsets padding;

  const BizzieFullPageEmptyLayout({
    super.key,
    required this.content,
    required this.action,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: _EmptyLayoutBody(
                content: content,
                action: action,
                padding: padding,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmptyLayoutBody extends StatelessWidget {
  final Widget content;
  final Widget action;
  final EdgeInsets padding;

  const _EmptyLayoutBody({
    required this.content,
    required this.action,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          Expanded(child: content),
          SizedBox(width: double.infinity, child: action),
          AppConstants.emptyWatchlistBottomSpacing,
        ],
      ),
    );
  }
}
