import 'package:buku_penghubung/src/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoButton extends StatelessWidget {
  const GoButton({
    Key? key,
    required this.text,
    required this.textStyle,
    this.height = 48,
    this.padding = 8,
    this.onPressed,
    this.leadingIcon,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.labelIcon,
  })  : isOutline = false,
        super(key: key);

  const GoButton.outline({
    Key? key,
    required this.text,
    required this.textStyle,
    this.height = 48,
    this.padding = 8,
    this.onPressed,
    this.leadingIcon,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.labelIcon,
  })  : isOutline = true,
        assert(borderColor != null),
        super(key: key);

  /// Text to display in button.
  final String text;

  /// Height of the button.
  final double height;

  /// Padding of the button.
  final double padding;

  /// Text style of the Text button.
  final TextStyle textStyle;

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// Icon to show icon of the button.
  final Widget? leadingIcon;

  /// Icon to show icon of the label.
  final Widget? labelIcon;

  /// Indicates if build outlined button or not.
  final bool isOutline;

  /// The color of background button. if not defined then use [GoColor.blue500]
  final Color? color;

  /// The color of border button. only required if build [Outline Button]
  final Color? borderColor;

  /// The width of border button. only required if build [Outline Button]
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final color = isOutline ? Colors.transparent : this.color ?? GoColor.hydro;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: height.h,
      ),
      child: ButtonTheme(
        height: height.h,
        buttonColor: color,
        minWidth: double.infinity,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: color,
            border: isOutline
                ? Border.fromBorderSide(
                    BorderSide(
                      color: borderColor!,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                  )
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 100),
          child: isOutline
              ? leadingIcon == null
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: padding).r,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        shape: _shapeBorder(context),
                        side: BorderSide(
                          color: borderColor!,
                          width: 1,
                        ),
                      ),
                      onPressed: onPressed,
                      child: _ButtonLabel(
                        text: text,
                        textStyle: textStyle,
                        labelIcon: labelIcon,
                      ),
                    )
                  : OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: padding).r,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        shape: _shapeBorder(context),
                        side: BorderSide(
                          color: borderColor!,
                          width: 1,
                        ),
                      ),
                      icon: leadingIcon!,
                      label: Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                      onPressed: onPressed,
                    )
              : leadingIcon == null
                  ? TextButton(
                      style: TextButton.styleFrom(
                        disabledBackgroundColor: GoColor.iron,
                        padding: EdgeInsets.symmetric(vertical: padding).r,
                        shape: _shapeBorder(context),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: onPressed,
                      child: _ButtonLabel(
                        text: text,
                        textStyle: textStyle,
                        labelIcon: labelIcon,
                      ),
                    )
                  : TextButton.icon(
                      style: TextButton.styleFrom(
                        disabledBackgroundColor: GoColor.iron,
                        padding: EdgeInsets.symmetric(vertical: padding).r,
                        shape: _shapeBorder(context),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      icon: leadingIcon!,
                      label: _ButtonLabel(
                        text: text,
                        textStyle: textStyle,
                        labelIcon: labelIcon,
                      ),
                      onPressed: onPressed,
                    ),
        ),
      ),
    );
  }

  OutlinedBorder _shapeBorder(BuildContext context) => RoundedRectangleBorder(
        side: isOutline
            ? BorderSide(
                color: borderColor!,
                width: 1,
                style: BorderStyle.solid,
              )
            : BorderSide.none,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      );
}

class _ButtonLabel extends StatelessWidget {
  const _ButtonLabel({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.labelIcon,
  }) : super(key: key);
  final String text;
  final TextStyle textStyle;
  final Widget? labelIcon;

  @override
  Widget build(BuildContext context) {
    if (labelIcon != null) {
      return RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: labelIcon!,
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ],
        ),
      );
    }
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: textStyle,
    );
  }
}
