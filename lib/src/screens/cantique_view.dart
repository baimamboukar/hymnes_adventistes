// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hymnes_adventistes/src/extensions/extensions.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/riverpods/cantique_services.dart';
import 'package:hymnes_adventistes/src/utils/decorations.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart';
import 'package:hymnes_adventistes/src/widgets/widgets.dart';
import 'package:line_icons/line_icons.dart';
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
    OverlayEntry? entry;
    // post frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (entry == null) {
      //   showOverlay(context, entry);
      // }
    });
    return DefaultTabController(
      initialIndex: langs.indexOf(lang),
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const _BottomSheet(),
                );
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
          backgroundColor: Palette.primary.value,
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
                bold: true, color: Palette.light, size: 14),
          ),
          bottom: TabBar(
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: Colors.white),
              insets: EdgeInsets.symmetric(horizontal: 16.0),
            ),
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
        // bottomSheet: SizedBox(
        //   height: 70,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8) +
        //         const EdgeInsets.only(bottom: 8, top: 4),
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           Lottie.asset("assets/animations/play.json",
        //               height: 55, width: 55),
        //           Lottie.asset("assets/animations/waves.json", height: 55),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget buildCantiqueBody({CantiqueModel? cantique, required String lang}) {
    if (cantique == null) {
      return const NoReferenceCantique();
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
                    Text(
                      strophe.number.toString(),
                      style: TextStyles.designText(
                          bold: true, color: Palette.primary.value, size: 20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ...strophe.vers.map(
                      (vers) {
                        return Text(
                          vers.content,
                          textAlign: TextAlign.center,
                          style: TextStyles.designText(
                                  bold: false,
                                  size: 16,
                                  color: cantique.refrain &&
                                          strophe.number == "refrain"
                                      ? Palette.primary.value
                                      : Palette.dark)
                              .copyWith(
                            textBaseline: TextBaseline.alphabetic,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
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

void showOverlay(BuildContext context, OverlayEntry? entry) {
  if (entry != null) {
    entry.remove();
  }
  // audio track widget
  final content = Container(
    height: 50,
    decoration: BoxDecoration(
      color: Palette.primary.value,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Text("0:00"),
            Expanded(
              child: Slider(
                onChanged: (value) {},
                value: 2.5,
                max: 6,
              ),
            ),
            const Text("02:34")
          ],
        )
      ],
    ),
  );
  entry = OverlayEntry(
    builder: ((context) => Positioned(bottom: 50.0, child: content)),
  );

  final overlay = Overlay.of(context)!;
  overlay.insert(entry);
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
                    ? Palette.primary.value
                    : Palette.light)
            .copyWith(
                // border: Border.all(color: Palette.primary.value, width: 2),
                ),
        child: Center(
            child: Text(
          language,
          style: TextStyles.designText(
              bold: false,
              size: 14,
              color: activeLanguage.state == position
                  ? Palette.light
                  : Palette.primary.value),
        )),
      ),
    );
  }
}

class _BottomSheet extends ConsumerWidget {
  const _BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Palette.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: Palette.primary.value,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Palette.primary.value,
              child: const Icon(
                Icons.screenshot,
                color: Palette.light,
              ),
            ),
            title: Text(
              "Capture d'ecran",
              style: TextStyles.designText(bold: false, size: 18),
            ),
            subtitle: Text(
              "faites une capture personalisee",
              style: TextStyles.designText(bold: false, size: 12),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Palette.primary.value,
              child: const Icon(
                LineIcons.share,
                color: Palette.light,
              ),
            ),
            title: Text(
              "Partager",
              style: TextStyles.designText(bold: false, size: 18),
            ),
            subtitle: Text(
              "partagez avec vos proches",
              style: TextStyles.designText(bold: false, size: 12),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
