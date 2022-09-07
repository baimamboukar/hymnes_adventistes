import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';

class CantiqueServices {
  // ignore: unused_field

  final Reader _read;
  CantiqueServices(this._read);
  Future<List<dynamic>> loadJsonData() async {
    final data = await rootBundle.loadString("assets/data/hymns.json");
    return jsonDecode(data);
  }

  Future<List<CantiqueModel>> getAllCantiques() async {
    final data = await loadJsonData();
    return (data).map((cantique) {
      return CantiqueModel.fromMap(cantique as Map<String, dynamic>);
    }).toList();
  }
}
