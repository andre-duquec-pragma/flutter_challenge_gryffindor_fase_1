import 'package:flutter/material.dart';
import 'package:flutter_challenge_gryffindor_fase_1/presentation/screens/cat_details_screen.dart';
import 'package:flutter_challenge_gryffindor_fase_1/presentation/screens/cats_favorites_screen.dart';

import '../../../presentation/screens/cat_modify_screen.dart';
import '../../../presentation/screens/generic_error_screen.dart';
import '../../../presentation/screens/splash_screen.dart';
import '../../models/cats.dart';
import '../common_routes.dart';
import '../common_utils.dart';

final class BaseRouteGenerator {
  const BaseRouteGenerator();

  Route get _errorRoute {
    return MaterialPageRoute(
      builder: (context) => const GenericErrorScreen(),
    );
  }

  Route? generateRoute(RouteSettings settings) {
    final route = CommonRoutes.init(value: settings.name ?? "");

    switch (route) {
      case CommonRoutes.error:
        return _errorRoute;
      case CommonRoutes.favoriteCatsPackages:
        return _generateCatFavoritesRoute();
      case CommonRoutes.catDetailsPackage:
        return _generateCatDetailsRoute(settings);
      case CommonRoutes.catModifyPackage:
        return _generateCatModifyRoute(settings);
    }
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

  List<Route<dynamic>> generateInitialRoute(String initialRoute) {
    return [
      MaterialPageRoute(
        settings: RouteSettings(name: CommonRoutes.root),
        builder: (context) => SplashScreen(),
      ),
    ];
  }
}
