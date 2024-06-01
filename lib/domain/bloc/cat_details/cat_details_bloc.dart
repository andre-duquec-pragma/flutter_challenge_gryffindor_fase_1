import 'dart:async';

import '../../models/cats.dart';
import '../../use_cases/delete_favorite_cat_use_case.dart';
import '../../use_cases/get_favorite_cat_use_case.dart';
import '../bloc.dart';
import 'cat_details_state.dart';
import 'package:get_it/get_it.dart';

class CatDetailsBloc extends Bloc<CatDetailsState> {
  final GetFavoritesCatUseCase _getFavoritesCatUseCase;
  final DeleteFavoriteCatUseCase _deleteFavoriteCatUseCase;

  CatDetailsBloc({required Cat cat})
      : _getFavoritesCatUseCase = GetIt.I.get(),
        _deleteFavoriteCatUseCase = GetIt.I.get(),
        super(initialState: CatDetailsStarted(data: cat));

  Future delete(Cat data) async {
    await _deleteFavoriteCatUseCase.invoke(id: data.id);

    final newState = CatDeletedState(data: data);
    emit(newState);
  }

  Future reload() async {
    final cat = await _getFavoritesCatUseCase.invoke(id: state.data.id);

    if (cat == null) {
      emit(CatDeletedState(data: state.data));
      return;
    }

    final newState = CatLoadedState(data: cat);
    emit(newState);
  }
}
