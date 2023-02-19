import 'package:flutter/material.dart';

extension Textheme on BuildContext {
  TextStyle get bodytext => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get coloredBodytext => Theme.of(this).textTheme.bodyLarge!.copyWith(
        color: Theme.of(this).colorScheme.primary,
      );
  TextStyle get bodylarge => Theme.of(this).textTheme.bodyLarge!;

  TextStyle get titletext => Theme.of(this).textTheme.displayMedium!;
  TextTheme get texttheme => Theme.of(this).textTheme;
}
