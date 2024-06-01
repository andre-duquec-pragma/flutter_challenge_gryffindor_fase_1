import 'dart:async';

import 'package:get_it/get_it.dart';

import '../../use_cases/get_favorites_cat_list_use_case.dart';
import '../bloc.dart';
import 'cats_favorites_states.dart';

final class CatsFavoritesBloc extends Bloc<CatsFavoritesState> {
  final GetFavoritesCatListUseCase _getFavoritesCatListUseCase;

  CatsFavoritesBloc()
      : _getFavoritesCatListUseCase = GetIt.I.get(),
        super(initialState: const CatsFavoritesInitialState()) {
    loadCatsFavorites();
  }

  Future loadCatsFavorites() async {
    emit(const CatsFavoritesLoadingState());

    try {
      final result = await _getFavoritesCatListUseCase.invoke();

      emit(CatsFavoritesLoadedState(data: result));
    } catch (_) {
      emit(const CatsFavoritesFailureState());
    }
  }
}
