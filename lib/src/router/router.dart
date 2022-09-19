import 'package:auto_route/auto_route.dart';
import 'package:hymnes_adventistes/src/screens/cantique_view.dart';
import 'package:hymnes_adventistes/src/screens/hymn_overview.dart';
import 'package:hymnes_adventistes/src/screens/index.dart';

@AdaptiveAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: Home, path: '/home', initial: true),
  AutoRoute(page: CantiqueView, path: '/cantique', initial: false),
  AutoRoute(page: HymnOverview, path: '/hymn-overview', initial: false),
])
class $AppRouter {}
