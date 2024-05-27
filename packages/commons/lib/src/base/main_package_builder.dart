import 'package:get_it/get_it.dart';

import '../repositories/cats_favorites_repository.dart';
import '../repositories/impl/cats_favorites_repository_impl.dart';
import '../use_cases/favorites/add_favorite_cat_use_case.dart';
import '../use_cases/favorites/impl/add_favorite_cat_use_case_impl.dart';
import 'base_package_builder.dart';

final class MainPackageBuilder implements BasePackageBuilder {
  @override
  Future<void> setUp() async {
    final injector = GetIt.I;

    // Repositories
    injector.registerFactory<CatsFavoritesRepository>(() => CatsFavoritesRepositoryImpl());

    // Use Cases
    injector.registerFactory<AddFavoriteCatUseCase>(() => AddFavoriteCatUseCaseImpl());
  }
}
