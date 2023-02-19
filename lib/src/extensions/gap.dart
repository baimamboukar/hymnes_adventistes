import 'package:flutter/material.dart';

// Gap extension on num to simplify sizedbox
extension Gap on num {
  SizedBox get hGap => SizedBox(width: toDouble());
  SizedBox get vGap => SizedBox(height: toDouble());
}
