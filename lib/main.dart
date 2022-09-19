import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hymnes_adventistes/src/router/router.gr.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';

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
    return ValueListenableBuilder(
      valueListenable: Hive.box<dynamic>('settings').listenable(),
      builder: (context, Box box, widget) => MaterialApp.router(
        builder: EasyLoading.init(),
        restorationScopeId: 'app',
        locale: const Locale('fr'),
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Hymnes Adventistes',
        themeMode: box.get('theme') ?? false ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            typography: Typography.material2021(),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.poppinsTextTheme(const TextTheme())),
        theme: ThemeData(
          useMaterial3: true,
          typography: Typography.material2021(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme(
            const TextTheme()
                .apply(bodyColor: Palette.light, displayColor: Palette.light),
          ),
          primaryColor: Palette.tertiary,
          primarySwatch: MaterialColor(
            box.get('color') ?? 0xFF007681,
            {
              100: Color(box.get('color') ?? 0xFF007681),
              700: const Color(0xFFEEC36D),
              600: const Color(0xFF337669),
              200: const Color(0xFFEEC36D),
              500: const Color(0xFF337669),
              400: const Color(0xFFEEC36D),
              50: const Color(0xFF337669),
              300: const Color(0xFFEEC36D),
            },
          ),
          iconTheme: const IconThemeData(color: Palette.light, size: 22.0),
        ),
      ),
    );
  }
}
