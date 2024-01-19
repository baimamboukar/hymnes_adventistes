// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:hymnes_adventistes/src/models/cantique.dart' as _i6;
import 'package:hymnes_adventistes/src/screens/cantique_view.dart' as _i1;
import 'package:hymnes_adventistes/src/screens/home.dart' as _i2;
import 'package:hymnes_adventistes/src/screens/hymn_overview.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    CantiqueView.name: (routeData) {
      final args = routeData.argsAs<CantiqueViewArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CantiqueView(
          key: args.key,
          cantique: args.cantique,
          lang: args.lang,
        ),
      );
    },
    Home.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.Home(),
      );
    },
    HymnOverview.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HymnOverview(),
      );
    },
  };
}

/// generated route for
/// [_i1.CantiqueView]
class CantiqueView extends _i4.PageRouteInfo<CantiqueViewArgs> {
  CantiqueView({
    _i5.Key? key,
    required _i6.CantiqueModel cantique,
    required String lang,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          CantiqueView.name,
          args: CantiqueViewArgs(
            key: key,
            cantique: cantique,
            lang: lang,
          ),
          initialChildren: children,
        );

  static const String name = 'CantiqueView';

  static const _i4.PageInfo<CantiqueViewArgs> page =
      _i4.PageInfo<CantiqueViewArgs>(name);
}

class CantiqueViewArgs {
  const CantiqueViewArgs({
    this.key,
    required this.cantique,
    required this.lang,
  });

  final _i5.Key? key;

  final _i6.CantiqueModel cantique;

  final String lang;

  @override
  String toString() {
    return 'CantiqueViewArgs{key: $key, cantique: $cantique, lang: $lang}';
  }
}

/// generated route for
/// [_i2.Home]
class Home extends _i4.PageRouteInfo<void> {
  const Home({List<_i4.PageRouteInfo>? children})
      : super(
          Home.name,
          initialChildren: children,
        );

  static const String name = 'Home';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HymnOverview]
class HymnOverview extends _i4.PageRouteInfo<void> {
  const HymnOverview({List<_i4.PageRouteInfo>? children})
      : super(
          HymnOverview.name,
          initialChildren: children,
        );

  static const String name = 'HymnOverview';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
