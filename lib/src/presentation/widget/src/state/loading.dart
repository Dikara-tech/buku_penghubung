import 'dart:ui';

import 'package:buku_penghubung/src/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoLoadingWidget extends StatefulWidget {
  const GoLoadingWidget({
    Key? key,
    this.isBlur = true,
    this.text,
    this.size,
  }) : super(key: key);

  final bool isBlur;
  final String? text;
  final double? size;

  @override
  State<GoLoadingWidget> createState() => _GoLoadingWidgetState();
}

class _GoLoadingWidgetState extends State<GoLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    final child = Center(
      child: SizedBox(
        width: widget.size?.sp ?? 100.sp,
        height: widget.size?.sp ?? 100.sp,
        child: const CircularProgressIndicator(
          color: GoColor.hydro,
        ),
      ),
    );

    if (widget.isBlur) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
        child: child,
      );
    } else {
      return child;
    }
  }
}
