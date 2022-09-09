import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/utils/data.dart';

class CantiqueServices {
  // ignore: unused_field

  final Reader _read;
  CantiqueServices(this._read);
  Future<List<dynamic>> loadJsonData() async {
    final data = await rootBundle.loadString("assets/data/hymns_fr.json");
    return jsonDecode(data);
  }

  Future<List<CantiqueModel>> getAllCantiques() async {
    final data = await loadJsonData();
    return (data).map((cantique) {
      return CantiqueModel.fromMap(cantique as Map<String, dynamic>);
    }).toList();
  }

  CantiqueModel getCantiqueById({required int number, required String lang}) {
    List<Map<String, dynamic>> cantiques = [];
    if (lang == 'fr') cantiques = frenchHymns;
    if (lang == 'en') cantiques = englishHyms;
    if (lang == 'full') cantiques = fulfuldeHymns;
    final data =
        cantiques.firstWhere((cantique) => cantique['number'] == number);
    return CantiqueModel.fromMap(data);
  }
}
