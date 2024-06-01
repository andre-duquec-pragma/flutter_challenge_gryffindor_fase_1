import '../../models/cats.dart';
import '../../use_cases/delete_favorite_cat_use_case.dart';
import '../../use_cases/get_favorite_cat_use_case.dart';
import '../../use_cases/impl/delete_favorite_cat_use_case_impl.dart';
import '../../use_cases/impl/get_favorite_cat_use_case_impl.dart';
import '../bloc.dart';
import 'cat_details_state.dart';

class CatDetailsBloc extends Bloc<CatDetailsState> {
  final GetFavoritesCatUseCase _getFavoritesCatUseCase;
  final DeleteFavoriteCatUseCase _deleteFavoriteCatUseCase;

  CatDetailsBloc({
    GetFavoritesCatUseCase getFavoritesCatUseCase = const GetFavoritesCatsUseCaseImpl(),
    DeleteFavoriteCatUseCase deleteFavoriteCatUseCase = const DeleteFavoriteCatUseCaseImpl(),
    required Cat cat,
  })  : _getFavoritesCatUseCase = getFavoritesCatUseCase,
        _deleteFavoriteCatUseCase = deleteFavoriteCatUseCase,
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
