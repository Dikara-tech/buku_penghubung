import 'package:buku_penghubung/src/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShadowCard extends StatelessWidget {
  const ShadowCard({
    Key? key,
    required this.child,
    this.color,
    this.boxShadow = const [
      BoxShadow(
        color: GoColor.shadow,
        blurRadius: 3,
        offset: Offset.zero,
      ),
    ],
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  /// Passing parent child to the card
  final Widget child;

  /// Give color to the card
  final Color? color;

  /// Control card shadow
  final List<BoxShadow>? boxShadow;

  /// Control card padding
  final EdgeInsetsGeometry? padding;

  /// Control card margin
  final EdgeInsetsGeometry? margin;

  /// Width of the card
  final double? width;

  /// Height of the card
  final double? height;

  /// Card border radius (rounded)
  final BorderRadiusGeometry? borderRadius;

  /// IMPORTANT NOTE
  /// If using [ShadowCard] inside [InkWell]
  /// Must set ===boxShadow: const [],===
  /// If no, the [ShadowCard] background color will be grayed because of shadows
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? GoColor.albin,
        boxShadow: boxShadow,
        borderRadius: borderRadius,
      ),
      padding: padding ?? const EdgeInsets.all(16).r,
      margin: margin ?? EdgeInsets.zero,
      width: width,
      height: height,
      child: child,
    );
  }
}
