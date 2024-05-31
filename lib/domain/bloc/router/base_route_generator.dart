import 'package:commons/commons.dart';
import 'package:commons_ui/commons_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge_gryffindor_fase_1/presentation/screens/cat_details_screen.dart';
import 'package:flutter_challenge_gryffindor_fase_1/presentation/screens/cats_favorites_screen.dart';
import 'package:modular_router/modular_router.dart';

import '../../../presentation/screens/base_screen.dart';
import '../../../presentation/screens/cat_modify_screen.dart';
import '../../../presentation/screens/splash_screen.dart';

final class BaseRouteGenerator implements ExtendedRouteGenerator {
  const BaseRouteGenerator();

  Route get _errorRoute {
    return MaterialPageRoute(
      builder: (context) => const GenericErrorScreen(),
    );
  }

  @override
  Route? generateRoute(RouteSettings settings) {
    final route = CommonRoutes.init(value: settings.name ?? "");

    switch (route) {
      case CommonRoutes.error:
        return _errorRoute;
      case CommonRoutes.splash:
        return _generateSplashRoute();
      case CommonRoutes.favoriteCatsPackages:
        return _generateCatFavoritesRoute();
      case CommonRoutes.catDetailsPackage:
        return _generateCatDetailsRoute(settings);
      case CommonRoutes.catModifyPackage:
        return _generateCatModifyRoute(settings);
    }
  }

  Route? _generateSplashRoute() {
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }

  Route? _generateCatFavoritesRoute() {
    return MaterialPageRoute(
      builder: (context) => CatsFavoritesScreen(),
    );
  }

  Route? _generateCatDetailsRoute(RouteSettings settings) {
    final data = CommonUtils().safeCast<Cat>(data: settings.arguments);

    if (data == null) {
      return _errorRoute;
    }

    return MaterialPageRoute(
      builder: (context) => CatDetailsScreen(cat: data),
    );
  }

  Route? _generateCatModifyRoute(RouteSettings settings) {
    final data = CommonUtils().safeCast<Cat>(data: settings.arguments);

    return MaterialPageRoute(
      builder: (context) => CatModifyScreen(cat: data),
    );
  }

  @override
  List<Route<dynamic>> generateInitialRoute(String initialRoute) {
    return [
      MaterialPageRoute(
        settings: RouteSettings(name: CommonRoutes.root),
        builder: (context) => const BaseScreen(),
      ),
    ];
  }
}
