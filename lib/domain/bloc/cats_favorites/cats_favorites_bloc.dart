import '../../use_cases/get_favorites_cat_list_use_case.dart';
import '../../use_cases/impl/get_favorites_cat_list_use_case_impl.dart';
import '../bloc.dart';
import 'cats_favorites_states.dart';

final class CatsFavoritesBloc extends Bloc<CatsFavoritesState> {
  final GetFavoritesCatListUseCase _getFavoritesCatListUseCase;

  CatsFavoritesBloc({
    GetFavoritesCatListUseCase getFavoritesCatListUseCase = const GetFavoritesCatListUseCaseImpl(),
  })  : _getFavoritesCatListUseCase = getFavoritesCatListUseCase,
        super(initialState: const CatsFavoritesInitialState()) {
    loadCatsFavorites();
  }

  /// To load all cats in storage.
  ///
  /// Searches in storage to get all cats data and emits a state change to [CatsFavoritesLoadedState].
  /// When there's no cats in storage emit a state change to [CatsFavoritesLoadedState] with empty results.
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
