import 'package:flutter/material.dart';

abstract class RouteGenerator {
  List<Route<dynamic>> generateInitialRoute(String initialRoute);

  Route? generateRoute(RouteSettings settings);
}
