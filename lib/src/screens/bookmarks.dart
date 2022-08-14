import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/extensions/extensions.dart';
import 'package:hymnes_adventistes/src/riverpods/cantique_services.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/router/router.gr.dart' as routes;
import '../utils/text_styles.dart';

class Bookmarks extends ConsumerWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cantiques = ref.watch(cantiquesRiverpod);
    return Scaffold(
      body: cantiques.when(
        data: (cantiques) {
          return CupertinoScrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cantiques.length,
              itemBuilder: (context, index) {
                final cantique = cantiques[index];
                return ListTile(
                  onTap: () {
                    context.autorouter
                        .push(routes.CantiqueView(cantique: cantique));
                  },
                  leading: CircleAvatar(
                    backgroundColor: Palette.primary,
                    child: Center(
                        child: Text(cantique.number.toString(),
                            style: TextStyles.designText(
                                bold: false, size: 12, color: Palette.light))),
                  ),
                  title: Text(
                    cantique.title,
                    style: TextStyles.designText(bold: false, size: 12),
                  ),
                  subtitle: Text(
                    cantique.language.lang,
                    style: TextStyles.designText(
                        bold: false, size: 9, color: Palette.dark),
                  ),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () {
                  //     ref.read(cantiquesRiverpod).removeCantique(cantique);
                  //   },
                  // ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CupertinoActivityIndicator()),
        error: (err, trace) => const Center(child: Text('Erreur')),
      ),
    );
  }
}
