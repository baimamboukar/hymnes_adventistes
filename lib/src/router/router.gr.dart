// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:hymnes_adventistes/src/models/cantique.dart' as _i6;
import 'package:hymnes_adventistes/src/screens/cantique_view.dart' as _i2;
import 'package:hymnes_adventistes/src/screens/hymn_overview.dart' as _i3;
import 'package:hymnes_adventistes/src/screens/index.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    Home.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.Home());
    },
    CantiqueView.name: (routeData) {
      final args = routeData.argsAs<CantiqueViewArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.CantiqueView(
              key: args.key, cantique: args.cantique, lang: args.lang));
    },
    HymnOverview.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.HymnOverview());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i4.RouteConfig(Home.name, path: '/home'),
        _i4.RouteConfig(CantiqueView.name, path: '/cantique'),
        _i4.RouteConfig(HymnOverview.name, path: '/hymn-overview')
      ];
}

/// generated route for
/// [_i1.Home]
class Home extends _i4.PageRouteInfo<void> {
  const Home() : super(Home.name, path: '/home');

  static const String name = 'Home';
}

/// generated route for
/// [_i2.CantiqueView]
class CantiqueView extends _i4.PageRouteInfo<CantiqueViewArgs> {
  CantiqueView(
      {_i5.Key? key, required _i6.CantiqueModel cantique, required String lang})
      : super(CantiqueView.name,
            path: '/cantique',
            args: CantiqueViewArgs(key: key, cantique: cantique, lang: lang));

  static const String name = 'CantiqueView';
}

class CantiqueViewArgs {
  const CantiqueViewArgs(
      {this.key, required this.cantique, required this.lang});

  final _i5.Key? key;

  final _i6.CantiqueModel cantique;

  final String lang;

  @override
  String toString() {
    return 'CantiqueViewArgs{key: $key, cantique: $cantique, lang: $lang}';
  }
}

/// generated route for
/// [_i3.HymnOverview]
class HymnOverview extends _i4.PageRouteInfo<void> {
  const HymnOverview() : super(HymnOverview.name, path: '/hymn-overview');

  static const String name = 'HymnOverview';
}
