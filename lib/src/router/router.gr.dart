// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:hymnes_adventistes/src/models/cantique.dart' as _i5;
import 'package:hymnes_adventistes/src/screens/cantique_view.dart' as _i2;
import 'package:hymnes_adventistes/src/screens/index.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    Home.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.Home());
    },
    CantiqueView.name: (routeData) {
      final args = routeData.argsAs<CantiqueViewArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.CantiqueView(key: args.key, cantique: args.cantique));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i3.RouteConfig(Home.name, path: '/home'),
        _i3.RouteConfig(CantiqueView.name, path: '/cantique')
      ];
}

/// generated route for
/// [_i1.Home]
class Home extends _i3.PageRouteInfo<void> {
  const Home() : super(Home.name, path: '/home');

  static const String name = 'Home';
}

/// generated route for
/// [_i2.CantiqueView]
class CantiqueView extends _i3.PageRouteInfo<CantiqueViewArgs> {
  CantiqueView({_i4.Key? key, required _i5.CantiqueModel cantique})
      : super(CantiqueView.name,
            path: '/cantique',
            args: CantiqueViewArgs(key: key, cantique: cantique));

  static const String name = 'CantiqueView';
}

class CantiqueViewArgs {
  const CantiqueViewArgs({this.key, required this.cantique});

  final _i4.Key? key;

  final _i5.CantiqueModel cantique;

  @override
  String toString() {
    return 'CantiqueViewArgs{key: $key, cantique: $cantique}';
  }
}
