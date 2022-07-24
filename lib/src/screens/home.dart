import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:line_icons/line_icons.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(LineIcons.music),
      ),
      body: Row(
        children: [
          NavigationRail(
            //minWidth: 80,
            // leading: const Text("Cantiques"),
            // trailing: const Text("Cantiques"),
            //elevation: 1.0,
            useIndicator: false,
            labelType: NavigationRailLabelType.selected,
            selectedIndex: 0,
            backgroundColor: Palette.primary,
            selectedIconTheme: const IconThemeData(color: Palette.light),
            unselectedIconTheme: const IconThemeData(color: Palette.dark),
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(LineIcons.home),
                label: Text("Cantiques"),
              ),
              NavigationRailDestination(
                icon: Icon(LineIcons.bookmark),
                label: Text("Favoris"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book),
                label: Text("Paramètres"),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1),
          Expanded(
            child: Column(
              children: const [
                Text("Hymnes Adventistes"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
