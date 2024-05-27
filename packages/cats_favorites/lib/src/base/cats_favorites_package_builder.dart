import 'package:commons/commons.dart';
import 'package:get_it/get_it.dart';
import 'package:modular_router/modular_router.dart';

import '../bloc/router/cat_favorites_route_generator.dart';
import '../use_cases/get_favorites_cat_list_use_case.dart';
import '../use_cases/impl/delete_favorite_cat_use_case_impl.dart';
import '../use_cases/impl/get_favorite_cat_use_case_impl.dart';
import '../use_cases/impl/get_favorites_cat_list_use_case_impl.dart';

class CatsFavoritesPackageBuilder implements BasePackageBuilder {
  @override
  Future<void> setUp() async {
    final injector = GetIt.I;

    // Router
    injector.registerFactory<RouteGenerator>(() => CatFavoritesRouteGenerator(),
        instanceName: CatFavoritesRouteGenerator.name);

    // Repositories
    injector.registerFactory<GetFavoritesCatListUseCase>(() => GetFavoritesCatListUseCaseImpl());

    // Use Cases
    injector.registerFactory<GetFavoritesCatUseCase>(() => GetFavoritesCatsUseCaseImpl());
    injector.registerFactory<DeleteFavoriteCatUseCase>(() => DeleteFavoriteCatUseCaseImpl());
  }
}
