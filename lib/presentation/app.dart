import 'package:flutter/material.dart';

import '../domain/utils/router/base_route_generator.dart';
import '../domain/utils/router/route_generator.dart';

class App extends StatelessWidget {
  final RouteGenerator routeGenerator;

  const App({
    super.key,
    this.routeGenerator = const BaseRouteGenerator(),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cats app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: routeGenerator.generateRoute,
      onGenerateInitialRoutes: routeGenerator.generateInitialRoute,
    );
  }
}
