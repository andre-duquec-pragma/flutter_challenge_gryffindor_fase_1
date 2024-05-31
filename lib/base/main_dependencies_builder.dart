import 'dart:convert';

import 'package:cat_details/cat_details.dart';
import 'package:cats_modify/cats_modify.dart';

import 'package:commons/commons.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modular_router/modular_router.dart';

import '../domain/use_cases/get_favorites_cat_list_use_case.dart';
import '../domain/use_cases/impl/delete_favorite_cat_use_case_impl.dart';
import '../domain/use_cases/impl/get_favorite_cat_use_case_impl.dart';
import '../domain/use_cases/impl/get_favorites_cat_list_use_case_impl.dart';
import 'main_global_config.dart';

class MainDependenciesBuilder {
  MainDependenciesBuilder();

  start() async {
    final injector = GetIt.I;

    final String confidentContent = await rootBundle.loadString("assets/config/main.json");

    Map configData = jsonDecode(confidentContent);

    EnvironmentValues environment = EnvironmentValues(data: configData);
    injector.registerSingleton<EnvironmentValuesProvider>(EnvironmentValuesProviderImpl(environment: environment));

    // Repositories
    injector.registerFactory<GetFavoritesCatListUseCase>(() => GetFavoritesCatListUseCaseImpl());

    // Use Cases
    injector.registerFactory<GetFavoritesCatUseCase>(() => GetFavoritesCatsUseCaseImpl());
    injector.registerFactory<DeleteFavoriteCatUseCase>(() => DeleteFavoriteCatUseCaseImpl());

    await Hive.initFlutter();

    Iterable<BasePackageBuilder> builders = [
      MainPackageBuilder(),
      CatDetailsPackageBuilder(),
      CatModifyPackageBuilder(),
    ];

    await Future.forEach(builders, (element) async {
      await element.setUp();
    });

    ModularRouterGlobalConfigProvider().set(MainGlobalConfig());
  }
}
