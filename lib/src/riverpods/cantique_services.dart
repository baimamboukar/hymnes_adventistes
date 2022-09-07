import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hymnes_adventistes/src/models/cantique.dart';
import 'package:hymnes_adventistes/src/services/data/cantiques_services.dart';

final dataServicesRiverpod =
    Provider.autoDispose<CantiqueServices>((ref) => CantiqueServices(ref.read));

final cantiquesRiverpod = FutureProvider<List<CantiqueModel>>(
  (ref) async => await ref.read(dataServicesRiverpod).getAllCantiques(),
);
