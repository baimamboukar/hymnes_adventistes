// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hymnes_adventistes/src/extensions/extensions.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/riverpods/cantique_services.dart';
import 'package:hymnes_adventistes/src/utils/decorations.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart';
import 'package:lottie/lottie.dart';

final langs = ['full', 'fr', 'en'];
final cantiqueBook = {
  'full': 'Deterre Gimmi be Fulfulde',
  'fr': 'Hymnes & Louanges',
  'en': 'SDA hymnals',
};

class CantiqueView extends ConsumerWidget {
  final CantiqueModel cantique;
  final String lang;
  const CantiqueView({Key? key, required this.cantique, required this.lang})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      initialIndex: langs.indexOf(lang),
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.primary,
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(18),
          //   ),
          // ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Palette.light,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            cantique.title,
            style: TextStyles.designText(
                bold: false, color: Palette.light, size: 14),
          ),
          bottom: TabBar(
            indicatorColor: Palette.light,
            indicatorWeight: 2,
            indicatorPadding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            tabs: [
              Tab(
                child: Text(
                  "Fulfulde",
                  style: TextStyles.designText(
                      bold: false, color: Palette.light, size: 12),
                ),
              ),
              Tab(
                child: Text(
                  "Français",
                  style: TextStyles.designText(
                      bold: false, color: Palette.light, size: 12),
                ),
              ),
              Tab(
                child: Text(
                  "English",
                  style: TextStyles.designText(
                      bold: false, color: Palette.light, size: 12),
                ),
              ),
            ],
          ),
          // bottom: PreferredSize(
          //   preferredSize: Size(context.screenWidth, 50),
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 8.0),
          //     child: Container(
          //       width: context.screenWidth * .9,
          //       height: 50,
          //       decoration:
          //           Decorations.decorateBox(radius: 32, color: Palette.light)
          //               .copyWith(
          //         border: Border.all(color: Palette.light, width: 0),
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           LabelChip(
          //             activeLanguage: activeLanguage,
          //             language: "Fulfulde",
          //             position: 0,
          //           ),
          //           LabelChip(
          //             activeLanguage: activeLanguage,
          //             language: "Francais",
          //             position: 1,
          //           ),
          //           LabelChip(
          //             activeLanguage: activeLanguage,
          //             language: "English",
          //             position: 2,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ),
        body: Builder(builder: (context) {
          final fullRef = cantique.equivalence.fulfulde;
          final frRef = cantique.equivalence.francais;
          final enRef = cantique.equivalence.english;

          return TabBarView(
            children: [
              buildCantiqueBody(
                  lang: 'full',
                  cantique: fullRef != 0
                      ? ref
                          .read(dataServicesRiverpod)
                          .getCantiqueById(number: fullRef, lang: 'full')
                      : null),
              buildCantiqueBody(
                  lang: 'fr',
                  cantique: frRef != 0
                      ? ref
                          .read(dataServicesRiverpod)
                          .getCantiqueById(number: frRef, lang: 'fr')
                      : null),
              buildCantiqueBody(
                  lang: 'en',
                  cantique: enRef != 0
                      ? ref
                          .read(dataServicesRiverpod)
                          .getCantiqueById(number: enRef, lang: 'en')
                      : null),
            ],
          );
        }),
        bottomSheet: SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8) +
                const EdgeInsets.only(bottom: 8, top: 4),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Lottie.asset("assets/animations/play.json",
                      height: 55, width: 55),
                  Lottie.asset("assets/animations/waves.json", height: 55),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCantiqueBody({CantiqueModel? cantique, required String lang}) {
    if (cantique == null) {
      return const Center(
        child: Text("Pas de cantique"),
      );
    }
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
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
                "${cantique.number} - ${cantiqueBook[lang]}",
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
                                  size: 15,
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
              const SizedBox(
                height: 60,
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
