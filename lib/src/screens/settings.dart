import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hymnes_adventistes/src/extensions/extensions.dart';
import 'package:hymnes_adventistes/src/models/advent_color.dart';
import 'package:hymnes_adventistes/src/utils/decorations.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart';

class Settings extends ConsumerWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 18),
          Card(
            //color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.light_mode),
              title: Text(
                "Theme",
                style: TextStyles.designText(bold: false, size: 14),
              ),
              subtitle: Text(
                "mode sombre",
                style: TextStyles.designText(
                    bold: false, color: Palette.dark, size: 8),
              ),
              trailing: ValueListenableBuilder(
                valueListenable: Hive.box('settings').listenable(),
                builder: (BuildContext context, Box box, Widget? widget) {
                  return CupertinoSwitch(
                    activeColor: Palette.primary,
                    value: box.get('theme') ?? false,
                    onChanged: (value) {
                      box.put('theme', value);
                    },
                  );
                },
              ),
            ),
          ),
          Card(
            //color: Colors.white,
            child: ListTile(
              leading: Text(
                "Aa",
                style: TextStyles.designText(
                    size: 20, bold: true, color: Palette.dark),
              ),
              title: Text(
                "Police",
                style: TextStyles.designText(bold: false, size: 14),
              ),
              subtitle: Text(
                "taille de police",
                style: TextStyles.designText(
                    bold: false, color: Palette.dark, size: 8),
              ),
              trailing: ValueListenableBuilder(
                valueListenable: Hive.box('settings').listenable(),
                builder: (BuildContext context, Box box, Widget? widget) {
                  return Text(
                    "18",
                    style: TextStyles.designText(
                        size: 20, bold: true, color: Palette.dark),
                  );
                },
              ),
            ),
          ),
          Card(
            //color: Colors.white,
            child: ValueListenableBuilder(
              valueListenable: Hive.box('settings').listenable(),
              builder: (BuildContext context, Box box, Widget? child) =>
                  ListTile(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => Container(
                            decoration: Decorations.decorateBox(
                                radius: 22, color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 75,
                                      decoration: Decorations.decorateBox(
                                          radius: 24, color: Palette.primary),
                                    ),
                                    const SizedBox(height: 22),
                                    Text(
                                      "Veuillez choisir la couleur principale",
                                      style: TextStyles.designText(
                                          bold: false, size: 14),
                                    ),
                                    ...adventColors.map((color) {
                                      return ListTile(
                                        onTap: () {
                                          box.put('color', color.value);
                                          context.autorouter.pop();
                                        },
                                        horizontalTitleGap: 0,
                                        title: Text(
                                          color.name,
                                          style: TextStyles.designText(
                                              bold: false, size: 14),
                                        ),
                                        subtitle: Text(
                                          color.desc,
                                          style: TextStyles.designText(
                                              bold: false,
                                              color: Palette.dark,
                                              size: 8),
                                        ),
                                        leading: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: Decorations.decorateBox(
                                            radius: 30,
                                            color: Color(color.value),
                                          ),
                                        ),
                                        trailing:
                                            box.get('color') == color.value
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: Color(color.value),
                                                  )
                                                : null,
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
                leading: const Icon(Icons.color_lens),
                title: Text(
                  "Couleur",
                  style: TextStyles.designText(bold: false, size: 14),
                ),
                subtitle: Text(
                  "changer de couleur",
                  style: TextStyles.designText(
                      bold: false, color: Palette.dark, size: 8),
                ),
                trailing: Container(
                  height: 30,
                  width: 30,
                  decoration: Decorations.decorateBox(
                      radius: 30,
                      color: Color(
                          Hive.box('settings').get('color') ?? 0xFF007681)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
