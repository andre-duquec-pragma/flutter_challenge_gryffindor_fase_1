import 'package:cat_details/cat_details.dart';
import 'package:cats_favorites/cats_favorites.dart';
import 'package:commons/commons.dart';
import 'package:commons_ui/commons_ui.dart';
import 'package:flutter/material.dart';
import 'package:modular_router/modular_router.dart';

import '../../ui/screens/base_screen.dart';
import '../../ui/screens/splash_screen.dart';

final class BaseRouteGenerator implements ExtendedRouteGenerator {
  const BaseRouteGenerator();

  Route get _errorRoute {
    return MaterialPageRoute(
      builder: (context) => const GenericErrorScreen<BaseRouterBloc>(
        routerActionHandlerType: RouterActionHandlerType.self,
      ),
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
        return _errorRoute;
    }
  }

  Route? _generateSplashRoute() {
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }

  Route? _generateCatFavoritesRoute() {
    return MaterialPageRoute(
      builder: (context) => const MainCatFavoritesScreen(),
    );
  }

  Route? _generateCatDetailsRoute(RouteSettings settings) {
    final data = CommonUtils().safeCast<Cat>(data: settings.arguments);

    if (data == null) {
      return _errorRoute;
    }

    return MaterialPageRoute(
      builder: (context) => MainCatDetailsScreen(data: data),
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
