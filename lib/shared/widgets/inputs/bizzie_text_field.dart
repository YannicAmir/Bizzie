import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BizzieTextField extends StatelessWidget {
  const BizzieTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.autovalidateMode,
    this.enabled,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode? autovalidateMode;
  final bool? enabled;
  final TextCapitalization textCapitalization;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      autovalidateMode: autovalidateMode,
      textCapitalization: textCapitalization,
      autofocus: autofocus,
      style: theme.textTheme.bodyLarge,
      inputFormatters: [
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
        FilteringTextInputFormatter.deny(
          RegExp(r'[\u0000-\u001F\u007F-\u009F\u200B]'),
        ),
        ...?inputFormatters,
      ],
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.inputDecorationTheme.hintStyle,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }
}
