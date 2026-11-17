import 'package:material_ui/material_ui.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key, this.text = 'or'});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(text, style: theme.textTheme.labelSmall),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
