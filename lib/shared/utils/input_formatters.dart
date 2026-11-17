import 'package:flutter/services.dart';

class InputFormatters {
  static final denyWhitespace = FilteringTextInputFormatter.deny(RegExp(r'\s'));
}
