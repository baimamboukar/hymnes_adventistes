import 'package:flutter/material.dart';
import 'package:hymnes_adventistes/src/extensions/extensions.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';

import '../utils/decorations.dart';

class Box extends StatelessWidget {
  const Box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape:
          RoundedRectangleBorder(borderRadius: Decorations.circularRadius(22)),
      child: Container(
        height: context.screenHeight / 2,
        decoration: Decorations.decorateBox(
          radius: 22,
          color: Palette.primary,
          // gradient: const LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.topRight,
          //   colors: [Palette.primary, Palette.light, Palette.tertiary],
          // ),
        ),
        child: const Center(
          child: Text("Defterre Gimmi be Fulfulde"),
        ),
      ),
    );
  }
}
