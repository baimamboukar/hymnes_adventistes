import 'package:flutter/material.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';

class TextStyles {
  static TextStyle get title => TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: Palette.primary.value);
  static TextStyle get body => const TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.normal, color: Palette.light);
  static TextStyle designText(
          {required bool bold, required double size, Color? color}) =>
      TextStyle(
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color ?? Palette.primary.value);
}
