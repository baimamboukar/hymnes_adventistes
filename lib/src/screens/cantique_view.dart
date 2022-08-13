// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hymnes_adventistes/src/extensions/extensions.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/utils/decorations.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart';

final activeLanguageProvider = StateProvider<int>((ref) {
  return 0;
});

class CantiqueView extends ConsumerWidget {
  final CantiqueModel cantique;
  const CantiqueView({
    Key? key,
    required this.cantique,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeLanguage = ref.watch(activeLanguageProvider.state);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        title: Text(
          cantique.title,
          style: TextStyles.designText(
              bold: false, color: Palette.light, size: 14),
        ),
        bottom: PreferredSize(
          preferredSize: Size(context.screenWidth, 50),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: context.screenWidth * .9,
              height: 50,
              decoration:
                  Decorations.decorateBox(radius: 32, color: Palette.light)
                      .copyWith(
                border: Border.all(color: Palette.light, width: 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LabelChip(
                    activeLanguage: activeLanguage,
                    language: "Fulfulde",
                    position: 0,
                  ),
                  LabelChip(
                    activeLanguage: activeLanguage,
                    language: "Francais",
                    position: 1,
                  ),
                  LabelChip(
                    activeLanguage: activeLanguage,
                    language: "English",
                    position: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                cantique.title,
                style: TextStyles.designText(bold: false, size: 18),
              ),
              Text(
                "${cantique.number} - Hymnes & Louanges",
                style: TextStyles.designText(
                    bold: false, color: Palette.dark, size: 12),
              ),
              const SizedBox(
                height: 20,
              ),
              for (var strophe in cantique.strophes)
                Column(
                  children: [
                    Text(strophe.number.toString()),
                    const SizedBox(
                      height: 8,
                    ),
                    ...strophe.vers.map(
                      (vers) {
                        return Text(
                          vers.content,
                          textAlign: TextAlign.justify,
                          style: TextStyles.designText(
                                  bold: false,
                                  size: 14,
                                  color: cantique.refrain &&
                                          strophe.number == "refrain"
                                      ? Palette.primary
                                      : Palette.dark)
                              .copyWith(
                                  fontStyle: cantique.refrain &&
                                          strophe.number == "refrain"
                                      ? FontStyle.italic
                                      : FontStyle.normal),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              IconButton(
                icon: const Icon(Icons.my_library_music, size: 68),
                onPressed: () {
                  AudioPlayer player = AudioPlayer();
                  AssetSource src = AssetSource("sounds/101.midi");
                  player.play(src);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabelChip extends StatelessWidget {
  const LabelChip({
    Key? key,
    required this.activeLanguage,
    required this.language,
    required this.position,
  }) : super(key: key);

  final StateController<int> activeLanguage;
  final String language;
  final int position;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => activeLanguage.state = position,
      child: Container(
        width: (context.screenWidth * .3),
        height: 50,
        decoration: Decorations.decorateBox(
                radius: 32,
                color: activeLanguage.state == position
                    ? Palette.primary
                    : Palette.light)
            .copyWith(
                // border: Border.all(color: Palette.primary, width: 2),
                ),
        child: Center(
            child: Text(
          language,
          style: TextStyles.designText(
              bold: false,
              size: 14,
              color: activeLanguage.state == position
                  ? Palette.light
                  : Palette.primary),
        )),
      ),
    );
  }
}
