import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/services/data/cantiques_services.dart';

final dataServicesRiverpod =
    Provider.autoDispose<CantiqueServices>((ref) => CantiqueServices(ref.read));

final cantiqueRiverpod = FutureProvider.family<CantiqueModel, List<dynamic>>(
  (ref, data) async {
    return await ref
        .read(dataServicesRiverpod)
        .getCantiqueById(number: data[0], lang: data[1]);
  },
);
