import 'package:flutter/material.dart';

import '../../../presentation/screens/cat_details_screen.dart';
import '../../../presentation/screens/cat_modify_screen.dart';
import '../../../presentation/screens/cats_favorites_screen.dart';
import '../../../presentation/screens/generic_error_screen.dart';
import '../../../presentation/screens/splash_screen.dart';
import '../../models/cats.dart';
import '../routes.dart';
import '../utils.dart';
import 'route_generator.dart';

final class BaseRouteGenerator implements RouteGenerator {
  const BaseRouteGenerator();

  Route get _errorRoute {
    return MaterialPageRoute(
      builder: (context) => const GenericErrorScreen(),
    );
  }

  @override
  List<Route<dynamic>> generateInitialRoute(String initialRoute) {
    return [
      MaterialPageRoute(
        settings: RouteSettings(name: Routes.root),
        builder: (context) => SplashScreen(),
      ),
    ];
  }

  @override
  Route? generateRoute(RouteSettings settings) {
    final route = Routes.init(value: settings.name ?? "");

    switch (route) {
      case Routes.error:
        return _errorRoute;
      case Routes.favorites:
        return _generateCatFavoritesRoute();
      case Routes.catDetails:
        return _generateCatDetailsRoute(settings);
      case Routes.catModify:
        return _generateCatModifyRoute(settings);
    }
  }

  Route? _generateCatFavoritesRoute() {
    return MaterialPageRoute(
      builder: (context) => CatsFavoritesScreen(),
    );
  }

  Route? _generateCatDetailsRoute(RouteSettings settings) {
    final data = Utils().safeCast<Cat>(data: settings.arguments);

    if (data == null) {
      return _errorRoute;
    }

    return MaterialPageRoute(
      builder: (context) => CatDetailsScreen(cat: data),
    );
  }

  Route? _generateCatModifyRoute(RouteSettings settings) {
    final data = Utils().safeCast<Cat>(data: settings.arguments);

    return MaterialPageRoute(
      builder: (context) => CatModifyScreen(cat: data),
    );
  }
}
