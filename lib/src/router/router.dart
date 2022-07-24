import 'package:auto_route/auto_route.dart';
import 'package:hymnes_adventistes/src/screens/index.dart';

@AdaptiveAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: Home, path: '/home', initial: false),
])
class $AppRouter {}
