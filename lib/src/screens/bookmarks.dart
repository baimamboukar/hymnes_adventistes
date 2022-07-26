import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/extensions/extensions.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/riverpods/cantique_services.dart';
import 'package:hymnes_adventistes/src/utils/data.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/router/router.gr.dart' as routes;
import '../utils/text_styles.dart';

final keyProvider = StateProvider<String>((ref) => "");
final langIndexProvider = StateProvider<int>((ref) => 0);
final bookNameRiverpod = StateProvider<String>((ref) {
  final index = ref.watch(langIndexProvider.state).state;
  index == 0
      ? cantiquesgallery = titlesFul
      : index == 1
          ? cantiquesgallery = titlesFr
          : cantiquesgallery = titlesEn;
  return index == 0
      ? "Defterre Gimmi be Fulfulde"
      : index == 1
          ? "Hymnes & Louanges"
          : "SDA Hymnals";
});
List cantiquesgallery = titlesFul;

class Bookmarks extends ConsumerWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ref.watch(keyProvider.state).state;
    final langIndex = ref.watch(langIndexProvider.state).state;
    final bookName = ref.watch(bookNameRiverpod.state).state;
    // ignore: no_leading_underscores_for_local_identifiers
    //final _scrollController = ScrollController(initialScrollOffset: 15);
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => ref.read(langIndexProvider.state).state = 0,
              child: Column(
                children: [
                  Text(
                    "Fulfulde",
                    style: TextStyles.designText(bold: true, size: 14),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Visibility(
                    visible: langIndex == 0,
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Palette.primary.value,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => ref.read(langIndexProvider.state).state = 1,
              child: Column(
                children: [
                  Text(
                    "Français",
                    style: TextStyles.designText(bold: true, size: 14),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Visibility(
                    visible: langIndex == 1,
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Palette.primary.value,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => ref.read(langIndexProvider.state).state = 2,
              child: Column(
                children: [
                  Text(
                    "English",
                    style: TextStyles.designText(bold: true, size: 14),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Visibility(
                    visible: langIndex == 2,
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Palette.primary.value,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        Text(bookName, style: TextStyles.designText(bold: true, size: 18)),
        const SizedBox(
          height: 14,
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
              onChanged: (value) async {
                ref.read(keyProvider.state).state = value;
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
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Scrollbar(
            //thumbVisibility: false,
            trackVisibility: true,
            interactive: true,
            //controller: _scrollController,
            child: ListView.separated(
              shrinkWrap: true,
              cacheExtent: 50,
              separatorBuilder: (context, index) => const Divider(),
              restorationId: 'bookmarklist',
              itemCount: key.isEmpty
                  ? cantiquesgallery.length
                  : cantiquesgallery
                      .where((cantique) =>
                          cantique.toLowerCase().contains(key.toLowerCase()) ||
                          titlesFr.indexOf(cantique).toString().contains(key))
                      .length,
              itemBuilder: (context, index) {
                final cantique = cantiquesgallery[index];
                return ListTile(
                  onTap: () {
                    // ignore: no_leading_underscores_for_local_identifiers
                    CantiqueModel _cantique = ref
                        .read(dataServicesRiverpod)
                        .getCantiqueById(number: index + 1, lang: 'fr');
                    context.router.push(
                        routes.CantiqueView(cantique: _cantique, lang: 'fr'));
                  },
                  leading: CircleAvatar(
                    backgroundColor: Palette.primary.value,
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
