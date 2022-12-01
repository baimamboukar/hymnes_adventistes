import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Palette {
  static ValueNotifier<Color> primary =
      ValueNotifier<Color>((Hive.box('settings').get('color') ?? 0xFF007681));
  static const Color secondary = Color(0xFF007681);
  static const Color tertiary = Color(0xFF7D2248);
  static const Color light = Color(0xFFEAEAEA);
  static const Color dark = Color(0xFF797D7A);
  static ValueNotifier<Color> backgroundDark =
      ValueNotifier(const Color(0xFF16213E));
}
