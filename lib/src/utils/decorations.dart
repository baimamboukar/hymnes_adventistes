import 'package:flutter/cupertino.dart';

class Decorations {
  static BorderRadius circularRadius(double radius) =>
      BorderRadius.circular(radius);
  static BoxDecoration decorateBox(
          {Color? color, required double radius, Gradient? gradient}) =>
      BoxDecoration(
          color: color ?? CupertinoColors.white,
          borderRadius: circularRadius(radius),
          gradient: gradient);
}
