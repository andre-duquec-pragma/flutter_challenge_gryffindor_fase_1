import 'package:flutter/material.dart';

abstract class RouteGenerator {
  /// To create the initial route to use in a navigator
  ///
  /// [initialRoute] A string to identify the initial route.
  List<Route<dynamic>> generateInitialRoute(String initialRoute);

  /// To create the next route to push in navigator.
  ///
  /// [settings] A data model which contains all important data about new route.
  Route? generateRoute(RouteSettings settings);
}
