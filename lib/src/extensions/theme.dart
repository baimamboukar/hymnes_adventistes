import 'package:flutter/material.dart';

extension ThemeDataExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ColorSchemeExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
