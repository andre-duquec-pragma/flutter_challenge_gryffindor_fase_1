import 'package:get_it/get_it.dart';

import '../repositories/cats_favorites_repository.dart';
import '../use_cases/add_favorite_cat_use_case.dart';
import '../use_cases/impl/add_favorite_cat_use_case_impl.dart';
import '../../infrastructure/repository/cats_favorites_repository_impl.dart';
import '../use_cases/delete_favorite_cat_use_case.dart';
import '../use_cases/get_favorite_cat_use_case.dart';
import '../use_cases/get_favorites_cat_list_use_case.dart';
import '../use_cases/impl/delete_favorite_cat_use_case_impl.dart';
import '../use_cases/impl/get_favorite_cat_use_case_impl.dart';
import '../use_cases/impl/get_favorites_cat_list_use_case_impl.dart';

class MainDependenciesBuilder {
  MainDependenciesBuilder();

  start() async {
    final injector = GetIt.I;

    // Repositories
    injector.registerFactory<CatsFavoritesRepository>(() => const CatsFavoritesRepositoryImpl());

    // Use Cases
    injector.registerFactory<AddFavoriteCatUseCase>(() => AddFavoriteCatUseCaseImpl());
    injector.registerFactory<GetFavoritesCatUseCase>(() => GetFavoritesCatsUseCaseImpl());
    injector.registerFactory<DeleteFavoriteCatUseCase>(() => DeleteFavoriteCatUseCaseImpl());
    injector.registerFactory<GetFavoritesCatListUseCase>(() => GetFavoritesCatListUseCaseImpl());
  }
}
