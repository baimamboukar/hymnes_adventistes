import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hymnes_adventistes/src/app/app_runner.dart';
import 'package:hymnes_adventistes/src/app/blocs.dart';
import 'package:hymnes_adventistes/src/router/router.gr.dart';
import 'package:hymnes_adventistes/src/utils/theme/theme.dart';

Future<void> bootstrap({required VoidCallback runner}) async {
  await AppRunner.preRunAction();
  runZonedGuarded(
    runner,
    (object, trace) async {
      /// Save to Firebase CrashLytics ///
      /// Save to Sentry ///
    },
  );
  await AppRunner.postRunAction();
}

class SabbathSongs extends StatefulWidget {
  const SabbathSongs({super.key});

  @override
  State<SabbathSongs> createState() => _SabbathSongsState();
}

class _SabbathSongsState extends State<SabbathSongs> {
  late AppRouter appRouter;
  @override
  void initState() {
    appRouter = AppRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SabbathSongBlocs(
      child: MaterialApp.router(
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        title: "context.loc.adventist",
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        theme: SabbathSongsTheme.light,
        darkTheme: SabbathSongsTheme.dark,
        themeMode: ThemeMode.light,
        //supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
