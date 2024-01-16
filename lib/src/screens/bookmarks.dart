import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/extensions/theme.dart';

import '../utils/data.dart';

class BookMarks extends ConsumerStatefulWidget {
  const BookMarks({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookMarksState();
}

class _BookMarksState extends ConsumerState<BookMarks> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: context.colorScheme.primaryContainer,
        appBar: AppBar(
          backgroundColor: context.colorScheme.primaryContainer,
          leading: null,
          // excludeHeaderSemantics: true,
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Fulfulde",
              ),
              Tab(
                text: "Francais",
              ),
              Tab(
                text: "English",
              ),
            ],
          ),
        ),
        body: _buildFulfuldeView(),
      ),
    );
  }

  _buildFulfuldeView() {
    ValueNotifier<String> listenable = ValueNotifier<String>('');
    List<String> gallery = listenable.value == ''
        ? titlesFul
        : titlesFul
            .where((cantique) => cantique.toLowerCase() == listenable.value)
            .toList();
    return Column(
      children: [
        TextFormField(
          onChanged: (data) {
            listenable.value = data;
          },
          onSaved: (data) {
            listenable.value = data!;
          },
        ),
        ValueListenableBuilder(
          valueListenable: listenable,
          builder: (context, widget, child) => Expanded(
            child: ListView.separated(
              itemCount: gallery.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                final cantique = gallery[index];
                return ListTile(title: Text(cantique));
              },
            ),
          ),
        ),
      ],
    );
  }
}
