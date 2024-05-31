import 'dart:async';

import 'package:get_it/get_it.dart';

import '../../use_cases/get_favorites_cat_list_use_case.dart';
import 'cats_favorites_states.dart';

final class CatsFavoritesBloc {
  final GetFavoritesCatListUseCase _getFavoritesCatListUseCase;

  final StreamController<CatsFavoritesState> stream = StreamController();

  CatsFavoritesBloc() : _getFavoritesCatListUseCase = GetIt.I.get() {
    stream.sink.add(const CatsFavoritesInitialState());
    loadCatsFavorites();
  }

  Future loadCatsFavorites() async {
    stream.sink.add(const CatsFavoritesLoadingState());

    try {
      final result = await _getFavoritesCatListUseCase.invoke();

      stream.sink.add(CatsFavoritesLoadedState(data: result));
    } catch (_) {
      stream.sink.add(const CatsFavoritesFailureState());
    }
  }
}
