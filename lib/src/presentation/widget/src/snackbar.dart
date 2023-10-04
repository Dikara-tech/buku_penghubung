import 'package:buku_penghubung/src/presentation/themes/themes.dart';
import 'package:flutter/material.dart';

class GoSnackBar extends SnackBar {
  const GoSnackBar._({
    Key? key,
    required this.text,
    required this.color,
    required Widget content,
  }) : super(
          key: key,
          content: content,
          behavior: SnackBarBehavior.floating,
          backgroundColor: color,
        );

  /// Text to display in snackbar.
  final String text;

  /// background color of snackbar.
  final Color color;

  static void showSuccess(
    BuildContext context, {
    required String text,
    Widget? icon,
  }) {
    final snackBar = GoSnackBar._(
      text: text,
      color: GoColor.chloro,
      content: Row(
        children: [
          if (icon != null) icon,
          if (icon != null) const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: GoTypography.caption(color: GoColor.albin),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showFailed(BuildContext context, {String? text, Widget? icon}) {
    final errorText = text ??
        'An Error has been occured, please contact our support center (code: 9000})';

    final snackBar = GoSnackBar._(
      text: errorText,
      color: GoColor.hemoglobin,
      content: Row(
        children: [
          if (icon != null) icon,
          if (icon != null) const SizedBox(width: 14),
          Expanded(
            child: Text(
              errorText,
              style: GoTypography.caption(color: GoColor.albin),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void basic(
    BuildContext context, {
    required String text,
    Widget? icon,
  }) {
    final snackBar = GoSnackBar._(
      text: text,
      color: const Color(0xCD434343),
      content: Row(
        children: [
          if (icon != null) icon,
          if (icon != null) const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: GoTypography.caption(color: GoColor.albin),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
