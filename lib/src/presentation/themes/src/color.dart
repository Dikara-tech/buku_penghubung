import 'package:flutter/material.dart';

class GoColor {
  const GoColor._();

  static Color fromHex(String hex) =>
      Color(int.parse(hex.replaceAll('#', '0xFF')));

  /// General named color
  static const albin = Color(0xFFFFFFFF); // Base Color
  static const hydro = Color(0xFF005CB9); // Primary Color
  static const aqua = Color(0xFFECF5FF); // Background Color Label
  static const analgesic = Color(0xFF000000); // Text / Paragraph Color
  static const anaesthesia = Color(0xFF757575); // Sub Text Color
  static const iron = Color(0xFFDADADA); // Disable Action / Border
  static const calcium = Color(0xFFEEEEEE); // Background / Border
  static const leuko = Color(0xFFF5F5F5); // Background Color Input Form
  static const hemoglobin = Color(0xFFDD2323); // Alert Color
  static const flav = Color(0xFFFFF1D0); // Background Color Label
  static const dextro = Color(0xFFE4F8CC); // Background Color Label
  static const chloro = Color(0xFF2C7C0E); // Success or Good Information
  static const carbonic = Color(0xFFFF9015);

  /// Developer named color
  static const shadow = Color(0x33575757); // shadow 20%
  static const splash = Color(0x260179ff); // splash effect color 38%
}
