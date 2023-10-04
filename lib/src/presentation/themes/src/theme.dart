import 'package:buku_penghubung/src/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoTheme {
  const GoTheme._();

  static ThemeData lightTheme() => ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: GoColor.hydro,
          onPrimary: GoColor.albin,
          secondary: GoColor.aqua,
          onSecondary: GoColor.albin,
          error: GoColor.hemoglobin,
          onError: GoColor.albin,
          background: GoColor.albin,
          onBackground: GoColor.analgesic,
          surface: Colors.transparent,
          onSurface: GoColor.analgesic,
        ),
        brightness: Brightness.light,
        scaffoldBackgroundColor: GoColor.albin,
        primaryColor: GoColor.hydro,
        unselectedWidgetColor: GoColor.iron,
        disabledColor: GoColor.iron,
        dialogBackgroundColor: GoColor.albin,
        appBarTheme: AppBarTheme(
          backgroundColor: GoColor.albin,
          foregroundColor: GoColor.analgesic,
          elevation: 0.5,
          centerTitle: true,
          toolbarHeight: 56.h,
          titleTextStyle: GoTypography.title(
            color: GoColor.analgesic,
          ),
        ),
        cardTheme: const CardTheme(
          color: GoColor.albin,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        dividerTheme: const DividerThemeData(
          color: GoColor.iron,
          thickness: 0.5,
        ),
      );
}
