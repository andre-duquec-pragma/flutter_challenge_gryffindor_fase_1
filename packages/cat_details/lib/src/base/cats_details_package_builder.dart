import 'package:commons/commons.dart';
import 'package:get_it/get_it.dart';
import 'package:modular_router/modular_router.dart';

import '../bloc/router/cat_details_route_generator.dart';

final class CatDetailsPackageBuilder implements BasePackageBuilder {
  @override
  Future<void> setUp() async {
    final injector = GetIt.I;

    // Router
    injector.registerFactory<RouteGenerator>(() => CatDetailsRouteGenerator(),
        instanceName: CatDetailsRouteGenerator.name);
  }
}
