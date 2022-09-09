import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
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
    // ignore: no_leading_underscores_for_local_identifiers
    final _numberController = TextEditingController();
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
                    // invalid cantique
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
                                onPressed: () {},
                                child: const Text("Fulfulde"),
                              ),
                            CupertinoActionSheetAction(
                              onPressed: () {},
                              child: const Text("Francais"),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {},
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
