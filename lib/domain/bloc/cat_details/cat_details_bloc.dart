import 'dart:async';

import '../../models/cat_detail.dart';
import 'cat_details_state.dart';
import 'package:commons/commons.dart';
import 'package:get_it/get_it.dart';

class CatDetailsBloc {
  final GetFavoritesCatUseCase _getFavoritesCatUseCase;
  final DeleteFavoriteCatUseCase _deleteFavoriteCatUseCase;

  StreamController<CatDetailsState> stream = StreamController();

  CatDetailsBloc({required Cat cat})
      : _getFavoritesCatUseCase = GetIt.I.get(),
        _deleteFavoriteCatUseCase = GetIt.I.get() {
    stream.add(CatDetailsStarted(details: CatDetail(details: cat)));

    loadCatDetails(cat);
  }

  Future loadCatDetails(Cat cat) async {
    try {
      final isFavorite = await _getFavoritesCatUseCase.invoke(id: cat.id) != null;

      final details = CatDetail(
        details: cat,
        isFavorite: isFavorite,
      );

      stream.add(CatLoadedState(details: details));
    } catch (_) {
      stream.add(CatDetailErrorState(details: CatDetail(details: cat)));
    }
  }

  Future delete(CatDetail data) async {
    await _deleteFavoriteCatUseCase.invoke(id: data.details.id);
    final newDetails = data.copyWith(isFavorite: false);

    final state = CatDeletedState(details: newDetails);
    stream.add(state);
  }

  Future reload() async {
    final state = await stream.stream.last;
    final cat = await _getFavoritesCatUseCase.invoke(id: state.details.details.id);

    final newDetails = state.details.copyWith(details: cat);
    final newState = state.copyWith(details: newDetails);

    stream.add(newState);
  }
}
