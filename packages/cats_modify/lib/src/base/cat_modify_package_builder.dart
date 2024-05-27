import 'package:cats_modify/src/bloc/router/cat_modify_route_generator.dart';
import 'package:commons/commons.dart';
import 'package:get_it/get_it.dart';
import 'package:modular_router/modular_router.dart';

final class CatModifyPackageBuilder implements BasePackageBuilder {
  @override
  Future<void> setUp() async {
    final injector = GetIt.I;

    injector.registerFactory<RouteGenerator>(
      () => CatModifyRouteGenerator(),
      instanceName: CatModifyRouteGenerator.name,
    );
  }
}
