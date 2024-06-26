import '../../entities/cats.dart';

sealed class CatsFavoritesState {
  final List<Cat>? data;

  const CatsFavoritesState({this.data});
}

final class CatsFavoritesInitialState extends CatsFavoritesState {
  const CatsFavoritesInitialState({super.data});
}

final class CatsFavoritesLoadingState extends CatsFavoritesState {
  const CatsFavoritesLoadingState({super.data});
}

final class CatsFavoritesLoadedState extends CatsFavoritesState {
  const CatsFavoritesLoadedState({super.data});
}

final class CatsFavoritesFailureState extends CatsFavoritesState {
  const CatsFavoritesFailureState({super.data});
}
