import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/repositories/cats_favorites_repository.dart';
import '../domain/use_cases/add_favorite_cat_use_case.dart';
import '../domain/use_cases/impl/add_favorite_cat_use_case_impl.dart';
import '../infrastructure/repository/cats_favorites_repository_impl.dart';
import '../domain/use_cases/delete_favorite_cat_use_case.dart';
import '../domain/use_cases/get_favorite_cat_use_case.dart';
import '../domain/use_cases/get_favorites_cat_list_use_case.dart';
import '../domain/use_cases/impl/delete_favorite_cat_use_case_impl.dart';
import '../domain/use_cases/impl/get_favorite_cat_use_case_impl.dart';
import '../domain/use_cases/impl/get_favorites_cat_list_use_case_impl.dart';
import 'environment/environment_values.dart';
import 'environment/environment_values_provider.dart';
import 'environment/impl/environment_values_provider_impl.dart';

class MainDependenciesBuilder {
  MainDependenciesBuilder();

  start() async {
    final injector = GetIt.I;

    final String confidentContent = await rootBundle.loadString("assets/config/main.json");

    Map configData = jsonDecode(confidentContent);

    EnvironmentValues environment = EnvironmentValues(data: configData);
    injector.registerSingleton<EnvironmentValuesProvider>(EnvironmentValuesProviderImpl(environment: environment));

    // Repositories
    injector.registerFactory<CatsFavoritesRepository>(() => CatsFavoritesRepositoryImpl());

    // Use Cases
    injector.registerFactory<AddFavoriteCatUseCase>(() => AddFavoriteCatUseCaseImpl());
    injector.registerFactory<GetFavoritesCatUseCase>(() => GetFavoritesCatsUseCaseImpl());
    injector.registerFactory<DeleteFavoriteCatUseCase>(() => DeleteFavoriteCatUseCaseImpl());
    injector.registerFactory<GetFavoritesCatListUseCase>(() => GetFavoritesCatListUseCaseImpl());

    await Hive.initFlutter();
  }
}
