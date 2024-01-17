import 'package:flutter/material.dart';
import 'package:hymnes_adventistes/src/app/app.dart';

Future<void> main() async {
  await bootstrap(
    runner: () => runApp(
      const SabbathSongs(),
    ),
  );
}
