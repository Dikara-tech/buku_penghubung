import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BracketFormatter extends TextInputFormatter {
  /// required all params
  BracketFormatter(this.context);

  /// context to show snack bar
  final BuildContext context;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final match = RegExp(r'[<>{}()\[\]]').hasMatch(newValue.text);
    if (match) {
      return oldValue;
    }
    return newValue;
  }
}

/// To limit user insert number only with specific length
class NumberOnlyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final match = RegExp(r'^\d+$').hasMatch(newValue.text);
    if (match) {
      return newValue;
    }
    return oldValue;
  }
}

/// To limit user insert non new line character
class NewLineFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final match = RegExp(r'\n').hasMatch(newValue.text);
    if (match) {
      return oldValue;
    }
    return newValue;
  }
}
