import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/extensions/extensions.dart';
import 'package:hymnes_adventistes/src/riverpods/cantique_services.dart';
import 'package:hymnes_adventistes/src/utils/data.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/router/router.gr.dart' as routes;
import '../utils/text_styles.dart';

final keyProvider = StateProvider<String>((ref) => "");

class Bookmarks extends ConsumerWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ref.watch(keyProvider.state).state;
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60.0,
          width: (context.screenWidth - 50),
          decoration: BoxDecoration(
            color: Palette.light,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Center(
            child: TextFormField(
              onChanged: (value) {
                ref.read(keyProvider.state).update((value) {
                  if (value.length >= 2) {
                    return value;
                  }
                  return "";
                });
              },
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
        Expanded(
          child: CupertinoScrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              shrinkWrap: true,
              restorationId: 'bookmarklist',
              itemCount: key.isEmpty
                  ? titlesFr.length
                  : titlesFr
                      .where((cantique) =>
                          cantique.toLowerCase().contains(key.toLowerCase()) ||
                          titlesFr.indexOf(cantique).toString().contains(key))
                      .length,
              itemBuilder: (context, index) {
                final cantique = titlesFr[index];
                return ListTile(
                  onTap: () {
                    // context.autorouter
                    //     .push(routes.CantiqueView(cantique: cantique));
                  },
                  leading: CircleAvatar(
                    backgroundColor: Palette.primary,
                    child: Center(
                        child: Text("${index + 1}",
                            style: TextStyles.designText(
                                bold: false, size: 12, color: Palette.light))),
                  ),
                  title: Text(
                    cantique,
                    style: TextStyles.designText(bold: false, size: 12),
                  ),
                  // subtitle: Text(
                  //   cantique.language.lang,
                  //   style: TextStyles.designText(
                  //       bold: false, size: 9, color: Palette.dark),
                  // ),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
