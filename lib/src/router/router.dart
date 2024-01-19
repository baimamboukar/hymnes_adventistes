import 'package:auto_route/auto_route.dart';
import 'package:hymnes_adventistes/src/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: Home.page, path: '/home', initial: true),
        AutoRoute(page: CantiqueView.page, path: '/cantique', initial: false),
        AutoRoute(
            page: HymnOverview.page, path: '/hymn-overview', initial: false),
      ];
}
