import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hymnes_adventistes/src/screens/index.dart';
import 'package:hymnes_adventistes/src/utils/index.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<dynamic>('settings');
  await Hive.openBox('user');
  Hive.box('settings').isEmpty
      ? {
          Hive.box('settings').put('language', 'en'),
          Hive.box('settings').put('theme', false),
        }
      : null;
  runApp(const HymnesAdventistes());
}

class HymnesAdventistes extends ConsumerWidget {
  const HymnesAdventistes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<dynamic>('settings').listenable(),
      builder: (context, Box box, widget) => MaterialApp(
          builder: EasyLoading.init(),
          restorationScopeId: 'app',
          locale: const Locale('en-US'),
          debugShowCheckedModeBanner: false,
          title: 'Alora',
          themeMode: box.get('theme') ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          theme: ThemeData(
            useMaterial3: true,
            typography: Typography.material2021(),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.poppinsTextTheme(
              const TextTheme()
                  .apply(bodyColor: Palette.light, displayColor: Palette.light),
            ),
            primarySwatch: const MaterialColor(0xFF337669, {
              100: Color(0xFF337669),
              700: Color(0xFFEEC36D),
              600: Color(0xFF337669),
              200: Color(0xFFEEC36D),
              500: Color(0xFF337669),
              400: Color(0xFFEEC36D),
              50: Color(0xFF337669),
              300: Color(0xFFEEC36D),
            }),
            iconTheme: const IconThemeData(color: Palette.primary, size: 22.0),
          ),
          home: const Home()),
    );
  }
}
