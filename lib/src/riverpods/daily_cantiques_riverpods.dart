import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/riverpods/riverpods.dart';

final dailyCantiqueRiverpod = FutureProvider.autoDispose<CantiqueModel>(
  (ref) async {
    int number = Random.secure().nextInt(695);
    return ref
        .read(dataServicesRiverpod)
        .getCantiqueById(number: number, lang: 'fr');
  },
);
