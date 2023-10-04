import 'package:buku_penghubung/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoTypography extends TextStyle {
  const GoTypography._({
    Color? color,
    required String typeface,
    required FontWeight fontWeight,
    required double fontSize,
    required double letterSpacing,
    double? lineHeight,
  }) : super(
          color: color,
          fontFamily: typeface,
          fontWeight: fontWeight,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          height: lineHeight,
        );

  factory GoTypography.header({Color? color}) => GoTypography._(
        color: color,
        typeface: FontFamily.roboto,
        fontWeight: FontWeight.w900,
        fontSize: 37.sp,
        letterSpacing: 0.25,
      );

  factory GoTypography.title({Color? color}) => GoTypography._(
        color: color,
        typeface: FontFamily.roboto,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
        letterSpacing: 0.15,
      );

  factory GoTypography.text({
    Color? color,
    GoFontWeight fontWeight = GoFontWeight.regular,
  }) =>
      GoTypography._(
        color: color,
        typeface: FontFamily.roboto,
        fontWeight: _fontWeight(fontWeight),
        fontSize: 17.sp,
        letterSpacing: 0.15,
      );

  factory GoTypography.paragraph({
    Color? color,
    GoFontWeight fontWeight = GoFontWeight.regular,
  }) =>
      GoTypography._(
        color: color,
        typeface: FontFamily.roboto,
        fontWeight: _fontWeight(fontWeight),
        fontSize: 17.sp,
        letterSpacing: 0.15,
        lineHeight: 1.5,
      );

  factory GoTypography.caption({
    Color? color,
    GoFontWeight fontWeight = GoFontWeight.regular,
  }) =>
      GoTypography._(
        color: color,
        typeface: FontFamily.roboto,
        fontWeight: _fontWeight(fontWeight),
        fontSize: 15.sp,
        letterSpacing: 0.1,
      );

  factory GoTypography.small({
    Color? color,
    GoFontWeight fontWeight = GoFontWeight.regular,
  }) =>
      GoTypography._(
        color: color,
        typeface: FontFamily.roboto,
        fontWeight: _fontWeight(fontWeight),
        fontSize: 13.sp,
        letterSpacing: 0.1,
      );
}

FontWeight _fontWeight(GoFontWeight type) {
  switch (type) {
    case GoFontWeight.bold:
      return FontWeight.w700;
    case GoFontWeight.semiBold:
      return FontWeight.w600;
    case GoFontWeight.regular:
      return FontWeight.w400;
  }
}

enum GoFontWeight {
  bold,
  regular,
  semiBold,
}
