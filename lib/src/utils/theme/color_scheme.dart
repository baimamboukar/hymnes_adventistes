import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

class SabbathSongsColorschemes {
  // static get light => _getTheme(Brightness.light);
}

ColorScheme _getColorscheme(int primary) {
  return SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    primary: Color(primary),
    primaryKey: Color(primary),
    secondary: const Color(0xFF626262),
    tertiary: const Color(0xFF1B2121),
    background: const Color(0xFFFF96A7),
    tones: FlexTones.vivid(Brightness.light),
  );
}
