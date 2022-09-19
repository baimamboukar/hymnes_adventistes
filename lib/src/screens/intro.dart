import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show WidgetRef, ConsumerWidget;
import 'package:hymnes_adventistes/src/extensions/index.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/riverpods/cantique_services.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart' show TextStyles;
import 'package:hymnes_adventistes/src/widgets/widgets.dart';
import 'package:hymnes_adventistes/src/router/router.gr.dart' as routes;

final _numberController = TextEditingController();

class Intro extends ConsumerWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: no_leading_underscores_for_local_identifiers

    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Hymnes Adventistes", style: TextStyles.title),
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                height: 60.0,
                width: (context.screenWidth - 50) * .6,
                decoration: BoxDecoration(
                  color: Palette.light,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Center(
                  child: TextFormField(
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Numero cantique",
                      hintStyle: TextStyles.designText(
                          bold: false, size: 12, color: Palette.dark),
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.library_music,
                        color: Palette.dark,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: () {
                  if (int.parse(_numberController.value.text) > 695) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Cantique inexistant"),
                        backgroundColor: Colors.red,
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                  }
                  if (int.parse(_numberController.value.text) > 654) {
                    // go to cantique view with english
                  }

                  if (_numberController.text.isNotEmpty &&
                      int.parse(_numberController.value.text) > 0 &&
                      int.parse(_numberController.value.text) <= 695) {
                    // choose language
                    if (int.parse(_numberController.value.text) < 655) {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          title: const Text("Choisir la langue"),
                          actions: [
                            if (int.parse(_numberController.value.text) <= 107)
                              CupertinoActionSheetAction(
                                isDefaultAction: true,
                                onPressed: () async {
                                  // ignore: no_leading_underscores_for_local_identifiers
                                  CantiqueModel _cantique = ref
                                      .read(dataServicesRiverpod)
                                      .getCantiqueById(
                                          number: int.parse(
                                              _numberController.value.text),
                                          lang: 'full');
                                  context.router.push(routes.CantiqueView(
                                      cantique: _cantique, lang: 'full'));
                                },
                                child: const Text("Fulfulde"),
                              ),
                            CupertinoActionSheetAction(
                              onPressed: () async {
                                // ignore: no_leading_underscores_for_local_identifiers
                                CantiqueModel _cantique = ref
                                    .read(dataServicesRiverpod)
                                    .getCantiqueById(
                                        number: int.parse(
                                            _numberController.value.text),
                                        lang: 'fr');
                                context.router.push(routes.CantiqueView(
                                    cantique: _cantique, lang: 'fr'));
                              },
                              child: const Text("Francais"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () async {
                                // ignore: no_leading_underscores_for_local_identifiers
                                CantiqueModel _cantique = ref
                                    .read(dataServicesRiverpod)
                                    .getCantiqueById(
                                        number: int.parse(
                                            _numberController.value.text),
                                        lang: 'en');
                                context.router.push(routes.CantiqueView(
                                    cantique: _cantique, lang: 'en'));
                              },
                              child: const Text("English"),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Annuler"),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: const Center(child: Text("Go")),
              )
            ],
          ),
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
      ),
    );
  }
}
