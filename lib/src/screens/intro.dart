import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show WidgetRef, ConsumerWidget;
import 'package:hymnes_adventistes/src/extensions/index.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart' show TextStyles;
import 'package:hymnes_adventistes/src/widgets/widgets.dart';

class Intro extends ConsumerWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Hymnes Adventistes", style: TextStyles.title),
        const SizedBox(height: 18),
        Container(
            height: 50.0,
            width: (context.screenWidth - 50) * .8,
            decoration: BoxDecoration(
              color: Palette.light,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: context.loc.adventist,
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.library_music,
                    color: Palette.tertiary,
                  ),
                ),
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        const Box(),
        const CardTile(
          title: "Fulfulde",
          subtitle: "Defterre Gimmi be fulfulde",
        ),
        const CardTile(
          title: "Francais",
          subtitle: "Hymnes & Louanges",
        ),
        const CardTile(
          title: "English",
          subtitle: "SDA Hymnals",
        ),
      ],
    );
  }
}
