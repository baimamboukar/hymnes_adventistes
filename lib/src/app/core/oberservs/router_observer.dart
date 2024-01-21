import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hymnes_adventistes/src/extensions/index.dart';

class SabbathSongsRouterObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    ('didPush ${route.settings.name}').log;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    ('didPop ${route.settings.name}').log;
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    ('didRemove ${route.settings.name}').log;
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    ('didReplace ${newRoute!.settings.name}').log;
  }
}
