import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hymnes_adventistes/src/extensions/extensions.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/screens/index.dart';
import 'package:hymnes_adventistes/src/screens/intro.dart';
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
    var model = {
      "1": [
        "Miséricorde insondable!",
        "Dieu peut-il tout pardonné?",
        "Absoudre un si grand coupable,",
        "Et mes péchés oublier?"
      ],
      "2": [
        "Longtemps j'ai loin de sa face,",
        "Provoqué son saint courroux,",
        "Fermé mon coeur à sa grâce,",
        "Blessé le sien devant tous."
      ],
      "3": [
        "Ô Jésus, à toi je cède,",
        "Je veux être libéré;",
        "De tout péché qui m'obsède",
        "Être à jamais délivré."
      ],
      "4": [
        "Alléluia!  Plus de doute,",
        "Mon fardeau m'est enlevé;",
        "Pour le ciel je suis en route,",
        "Heureux pour l'éternité."
      ],
      "title": "Miséricorde insondable",
      "number": 271,
      "refrain": [
        "Jésus, je viens, je viens à toi.",
        "Tel que je suis, je viens à toi.",
        "Jésus, je viens, je viens à toi.",
        "Tel que je suis, prends-moi."
      ],
      "slides": [
        "1",
        "refrain",
        "2",
        "refrain",
        "3",
        "refrain",
        "4",
        "refrain"
      ],
      "parts": ["1", "refrain", "2", "3", "4"]
    };
    final data = CantiqueModel.fromMap(model);
    debugPrint(data.toString());
    final activeIndex = ref.watch(activeIndexRiverpod.state);
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (BuildContext context, Box box, Widget? widget) => SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(LineIcons.music),
          ),
          body: Row(
            children: [
              NavigationRail(
                //minWidth: 80,
                onDestinationSelected: (index) {
                  activeIndex.state = index;
                },
                extended: false,
                groupAlignment: -.75,
                leading: const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
                //trailing: const Icon(LineIcons.music),
                elevation: 10.0,
                useIndicator: true,
                selectedLabelTextStyle: TextStyles.body,
                labelType: NavigationRailLabelType.selected,
                selectedIndex: activeIndex.state,
                indicatorColor: Palette.tertiary,
                backgroundColor: Color(box.get('color')),
                selectedIconTheme: const IconThemeData(color: Palette.light),
                unselectedIconTheme:
                    IconThemeData(color: Palette.light.withOpacity(.8)),
                destinations: const <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: Icon(LineIcons.music),
                    label: Text("Hyms"),
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                  NavigationRailDestination(
                    icon: Icon(LineIcons.bookmark),
                    label: Text("Favoris"),
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.book),
                    label: Text("Params"),
                    padding: EdgeInsets.only(bottom: 30),
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
                        Settings(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
