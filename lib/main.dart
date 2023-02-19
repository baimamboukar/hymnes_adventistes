import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:hymnes_adventistes/src/router/router.gr.dart';
import 'package:hymnes_adventistes/src/utils/theme/theme.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<dynamic>('settings');
  await Hive.openBox('user');
  //Hive.box('settings').put('color', 0xFF007681);
  Hive.box('settings').isEmpty
      ? {
          Hive.box('settings').put('language', 'en'),
          Hive.box('settings').put('theme', false),
          Hive.box('setings').put('color', 0xFF007681)
        }
      : null;
  runApp(ProviderScope(
    child: HymnesAdventistes(),
  ));
}

// ignore: must_be_immutable
class HymnesAdventistes extends ConsumerWidget {
  HymnesAdventistes({Key? key}) : super(key: key);
  AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HiveListener(
      box: Hive.box('settings'),
      builder: (Box box) {
        final theme = SabbathSongsTheme(
          primaryColor: Color(box.get('color') ?? 0xFF007681),
        );
        return MaterialApp.router(
          builder: EasyLoading.init(),
          restorationScopeId: 'advent_hymnals',
          locale: const Locale('en'),
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          title: 'Hymnes Adventistes',
          themeMode:
              box.get('theme') ?? false ? ThemeMode.dark : ThemeMode.light,
          theme: theme.toThemeData(),
          darkTheme: theme.toThemeData(),
        );
      },
    );
  }
}
