import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:buku_penghubung/src/presentation/themes/themes.dart';
import 'package:buku_penghubung/src/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';

class GoSimpleDialog extends StatefulWidget {
  final String title;
  final String message;
  final String confirmText;
  final VoidCallback? onConfirm;
  final Widget? image;

  final List<DialogNoteContent>? notes;

  const GoSimpleDialog._({
    required this.title,
    required this.message,
    required this.confirmText,
    this.onConfirm,
    this.image,
    this.notes,
  });

  static void showDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Ok, Got it',
    VoidCallback? onConfirm,
    Widget? image,
    List<DialogNoteContent>? notes,
  }) {
    showModal<void>(
      context: context,
      configuration:
          const FadeScaleTransitionConfiguration(barrierDismissible: false),
      builder: (context) => GoSimpleDialog._(
        title: title,
        message: message,
        onConfirm: onConfirm,
        image: image,
        confirmText: confirmText,
        notes: notes,
      ),
    );
  }

  @override
  State<GoSimpleDialog> createState() => _GoSimpleDialogState();
}

class _GoSimpleDialogState extends State<GoSimpleDialog> {
  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 350.0,
        ),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color:
              isLightMode ? GoColor.albin : GoColor.analgesic.withOpacity(0.85),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (widget.image != null) const SizedBox(height: 16.0),
            if (widget.image != null) widget.image!,
            if (widget.image != null) const SizedBox(height: 30.0),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoTypography.title(
                color: isLightMode ? GoColor.analgesic : GoColor.albin,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: GoTypography.caption(
                color: isLightMode ? GoColor.analgesic : GoColor.albin,
              ),
            ),
            if (widget.notes != null && widget.notes!.isNotEmpty)
              const SizedBox(height: 12.0),
            if (widget.notes != null && widget.notes!.isNotEmpty)
              _BuildNoteContainer(notes: widget.notes!),
            const SizedBox(height: 24.0),
            GoButton(
              padding: 12,
              height: 38,
              textStyle: GoTypography.text(
                  fontWeight: GoFontWeight.bold, color: GoColor.albin),
              text: widget.confirmText,
              onPressed: () {
                widget.onConfirm?.call();
                AutoRouter.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DialogNoteContent {
  final String title;
  final String message;

  DialogNoteContent({required this.title, required this.message});
}

class _BuildNoteContainer extends StatelessWidget {
  final List<DialogNoteContent> notes;

  const _BuildNoteContainer({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    final children = <Widget>[];

    for (final content in notes) {
      children.addAll([
        Text(
          content.title,
          style: GoTypography.caption(
            color: isLightMode ? GoColor.analgesic : GoColor.albin,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          content.message,
          style: GoTypography.caption(
            color: isLightMode ? GoColor.anaesthesia : GoColor.iron,
          ),
        ),
        const SizedBox(height: 8.0),
      ]);
    }

    return Container(
      decoration: BoxDecoration(
        color: GoColor.hemoglobin.withOpacity(isLightMode ? 0.1 : 0.2),
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
