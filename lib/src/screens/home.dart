import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hymnes_adventistes/src/extensions/theme.dart';
import 'package:hymnes_adventistes/src/screens/index.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart';
import 'package:line_icons/line_icons.dart';

final activeIndexRiverpod = StateProvider<int>((ref) {
  return 0;
});

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(activeIndexRiverpod.state);
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (BuildContext context, Box box, Widget? widget) => Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(LineIcons.music),
        // ),
        body: Row(
          children: [
            NavigationRail(
              //minWidth: 80,
              onDestinationSelected: (index) {
                activeIndex.state = index;
              },
              extended: false,
              groupAlignment: .75,
              trailing: Image.asset(
                "assets/images/logo.png",
                width: 70,
                height: 55,
              ),
              //trailing: const Icon(LineIcons.music),
              elevation: 10.0,
              useIndicator: true,
              selectedLabelTextStyle: TextStyles.body,
              labelType: NavigationRailLabelType.selected,
              selectedIndex: activeIndex.state,
              indicatorColor: Palette.light.withOpacity(.55),
              backgroundColor: context.colorScheme.primary,
              selectedIconTheme:
                  IconThemeData(color: Color(box.get('color') ?? 0xFF007681)),
              unselectedIconTheme:
                  IconThemeData(color: Palette.light.withOpacity(.8)),
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: const Icon(LineIcons.music),
                  label: Text(
                    "Hymns",
                    style: TextStyles.designText(
                        bold: false, size: 12, color: Palette.light),
                  ),
                  padding: const EdgeInsets.only(bottom: 30),
                ),
                NavigationRailDestination(
                  icon: const Icon(
                    LineIcons.heart,
                  ),
                  label: Text(
                    "Favoris",
                    style: TextStyles.designText(
                        bold: false, size: 12, color: Palette.light),
                  ),
                  padding: const EdgeInsets.only(bottom: 30),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.layers),
                  label: Text(
                    "Themes",
                    style: TextStyles.designText(
                        bold: false, size: 12, color: Palette.light),
                  ),
                  padding: const EdgeInsets.only(bottom: 30),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings),
                  label: Text(
                    "Parametres",
                    style: TextStyles.designText(
                        bold: false, size: 12, color: Palette.light),
                  ),
                  padding: const EdgeInsets.only(bottom: 30),
                ),
              ],
            ),
            // const VerticalDivider(thickness: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12) +
                    const EdgeInsets.only(top: 18),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 550),
                  transitionBuilder: (widget, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: widget,
                    );
                  },
                  child: IndexedStack(
                    index: activeIndex.state,
                    children: const [
                      Intro(),
                      Bookmarks(),
                      Text("Themes"),
                      Settings(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
