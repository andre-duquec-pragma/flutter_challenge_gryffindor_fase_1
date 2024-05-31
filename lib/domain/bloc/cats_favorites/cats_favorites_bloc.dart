import 'dart:async';

import 'package:get_it/get_it.dart';

import '../../use_cases/get_favorites_cat_list_use_case.dart';
import 'cats_favorites_states.dart';

final class CatsFavoritesBloc {
  final GetFavoritesCatListUseCase _getFavoritesCatListUseCase;

  final StreamController<CatsFavoritesState> stream = StreamController();

  CatsFavoritesBloc() : _getFavoritesCatListUseCase = GetIt.I.get() {
    stream.add(const CatsFavoritesInitialState());
    loadCatsFavorites();
  }

  Future loadCatsFavorites() async {
    stream.add(const CatsFavoritesLoadingState());

    try {
      final result = await _getFavoritesCatListUseCase.invoke();

      stream.add(CatsFavoritesLoadedState(data: result));
    } catch (_) {
      stream.add(const CatsFavoritesFailureState());
    }
  }
}
