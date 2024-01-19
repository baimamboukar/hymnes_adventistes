import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hymnes_adventistes/src/extensions/texttheme.dart';
import 'package:hymnes_adventistes/src/extensions/theme.dart';
import 'package:hymnes_adventistes/src/screens/index.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart';
import 'package:line_icons/line_icons.dart';

final activeIndexRiverpod = StateProvider<int>((ref) {
  return 0;
});

@RoutePage()
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
        backgroundColor: context.colorScheme.primaryContainer,
        body: Row(
          children: [
            NavigationRail(
              //minWidth: 80,
              onDestinationSelected: (index) {
                activeIndex.state = index;
              },
              extended: false,
              groupAlignment: .75,
              trailing: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: SizedBox(
                        //height: 200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "Hymnes Adventistes",
                                style: context.texttheme.bodyLarge!.copyWith(
                                  fontSize: 22,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                              Text("v1.0.0",
                                  style: context.texttheme.bodyMedium),
                              const Divider(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 70,
                  height: 55,
                ),
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
                  IconThemeData(color: context.colorScheme.primary),
              unselectedIconTheme:
                  IconThemeData(color: Palette.light.withOpacity(.8)),
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: const Icon(Hicons.musicnote),
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
                  icon: const Icon(Hicons.setting),
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
                      BookMarks(),
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
