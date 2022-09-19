import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hymnes_adventistes/src/extensions/extensions.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/riverpods/cantique_services.dart';
import 'package:hymnes_adventistes/src/utils/data.dart';
import 'package:hymnes_adventistes/src/utils/palette.dart';
import 'package:hymnes_adventistes/src/utils/text_styles.dart';
import 'package:hymnes_adventistes/src/widgets/box.dart';
import 'package:line_icons/line_icons.dart';

import 'package:hymnes_adventistes/src/router/router.gr.dart' as routes;

final keyProvider = StateProvider<String>((ref) {
  return "";
});

class HymnOverview extends ConsumerStatefulWidget {
  const HymnOverview({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HymnOverviewState();
}

class _HymnOverviewState extends ConsumerState<HymnOverview> {
  @override
  Widget build(BuildContext context) {
    final key = ref.watch(keyProvider.state).state;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Palette.primary,
            title: Text(
              "Hymnes & Louanges",
              style: TextStyles.designText(
                  bold: false, size: 14, color: Palette.light),
            ),
            bottom: TabBar(
              unselectedLabelStyle: TextStyles.designText(
                  bold: false, size: 14, color: Palette.light),
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.white),
                insets: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              labelStyle: TextStyles.designText(
                  bold: true, size: 14, color: Palette.light),
              indicatorColor: Palette.light,
              indicatorWeight: 2,
              indicatorPadding:
                  const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              tabs: const [
                Tab(
                  text: "Index",
                ),
                Tab(
                  text: "Alphabetique",
                ),
                Tab(
                  text: "Thematique",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [IndexView(), AlphabeticView(), ThematicView()],
          )),
    );
  }
}

class ThematicView extends ConsumerWidget {
  const ThematicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 14),
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                ...[
                  {
                    'title': 'Adoration',
                    'cantiques': [
                      1,
                      2,
                      3,
                      4,
                      5,
                      6,
                      7,
                      8,
                      9,
                      10,
                      11,
                      12,
                      13,
                      14,
                      15,
                      16
                    ],
                    'icon': LineIcons.heart,
                  },
                  {
                    'title': 'Pardon',
                    'cantiques': [17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27],
                    'icon': LineIcons.handshake,
                  },
                  {
                    'title': 'Amour',
                    'cantiques': [28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38],
                    'icon': LineIcons.cross,
                  }
                ].map((category) => Box.tiny(
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Icon(
                            category['icon'] as IconData,
                            size: 48,
                            color: Palette.light,
                          ),
                          Text(
                            category['title'] as String,
                            style: TextStyles.designText(
                                bold: false, size: 14, color: Palette.light),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IndexView extends ConsumerWidget {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Expanded(
        child: CupertinoScrollbar(
          thumbVisibility: false,

          //controller: _scrollController,
          child: ListView.builder(
            shrinkWrap: true,
            restorationId: 'index_view',
            itemCount: titlesFr.length,
            itemBuilder: (context, index) {
              final cantique = titlesFr[index];
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
              );
            },
          ),
        ),
      ),
    );
  }
}

class AlphabeticView extends ConsumerWidget {
  const AlphabeticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GroupedListView(
        elements: titlesFr,
        shrinkWrap: true,
        groupBy: (String element) => element[0],
        separator: const Divider(
          height: 2,
          thickness: .5,
        ),
        groupHeaderBuilder: (String element) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Index alphabetique ${element[0]}",
            style: TextStyles.designText(bold: true, size: 14),
          ),
        ),
        groupSeparatorBuilder: (String groupByValue) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Palette.primary,
            child: Center(
                child: Text(groupByValue,
                    style: TextStyles.designText(
                        bold: true, size: 18, color: Palette.light))),
          ),
        ),
        itemBuilder: (context, String cantique) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Palette.primary,
            child: Center(
                child: Text("${titlesFr.indexOf(cantique) + 1}",
                    style: TextStyles.designText(
                        bold: false, size: 12, color: Palette.light))),
          ),
          title: Text(
            cantique,
            style: TextStyles.designText(bold: false, size: 12),
          ),
        ),
        itemComparator: (String cantiqueAlpha, String cantiqueBeta) =>
            cantiqueAlpha.compareTo(cantiqueBeta), // optional
        useStickyGroupSeparators: true, // optional
        floatingHeader: false, // optional
        order: GroupedListOrder.ASC,
      ),
    );
  }
}
