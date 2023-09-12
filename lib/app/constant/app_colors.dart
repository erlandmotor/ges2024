import 'package:flutter/material.dart';

import 'dart:math';

class AppColor {
  static const Color primaryColor = Color(0xFF5265af);
  static const Color primaryShadeColor = Color(0xFF4783c4);
  static const Color primaryDark = Color(0xFF12204B);
  static const Color shade = Color(0xFFF7F7FB);
  static const Color bodyTextColor = Color(0xFF888AA0);
  static const Color lineShapeColor = Color(0xFFEBEDF9);
  static const Color tertiaryColor = Color(0xFF4BCBF9);
  static const Color successColor = Color(0xFF5EB75D);
  static const Color warningColor = Color(0xFFEFAF4C);
  static const Color alertColor = Color(0xFFDA534F);
  static final MaterialColor primaryMaterialColor =
      generateMaterialColor(primaryColor);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: _generateTintColor(color, 0.9),
    100: _generateTintColor(color, 0.8),
    200: _generateTintColor(color, 0.6),
    300: _generateTintColor(color, 0.4),
    400: _generateTintColor(color, 0.2),
    500: color,
    600: _generateShadeColor(color, 0.1),
    700: _generateShadeColor(color, 0.2),
    800: _generateShadeColor(color, 0.3),
    900: _generateShadeColor(color, 0.4),
  });
}

int _generateTintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color _generateTintColor(Color color, double factor) => Color.fromRGBO(
    _generateTintValue(color.red, factor),
    _generateTintValue(color.green, factor),
    _generateTintValue(color.blue, factor),
    1);

int _generateShadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color _generateShadeColor(Color color, double factor) => Color.fromRGBO(
    _generateShadeValue(color.red, factor),
    _generateShadeValue(color.green, factor),
    _generateShadeValue(color.blue, factor),
    1);
