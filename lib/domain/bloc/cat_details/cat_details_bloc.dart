import 'dart:async';

import '../../models/cat_detail.dart';
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
        super(initialState: CatDetailsStarted(details: CatDetail(details: cat))) {
    loadCatDetails(cat);
  }

  Future loadCatDetails(Cat cat) async {
    try {
      final isFavorite = await _getFavoritesCatUseCase.invoke(id: cat.id) != null;

      final details = CatDetail(
        details: cat,
        isFavorite: isFavorite,
      );

      emit(CatLoadedState(details: details));
    } catch (_) {
      emit(CatDetailErrorState(details: CatDetail(details: cat)));
    }
  }

  Future delete(CatDetail data) async {
    await _deleteFavoriteCatUseCase.invoke(id: data.details.id);
    final newDetails = data.copyWith(isFavorite: false);

    final state = CatDeletedState(details: newDetails);
    emit(state);
  }

  Future reload() async {
    final cat = await _getFavoritesCatUseCase.invoke(id: state.details.details.id);

    final newDetails = state.details.copyWith(details: cat);
    final newState = state.copyWith(details: newDetails);

    emit(newState);
  }
}
