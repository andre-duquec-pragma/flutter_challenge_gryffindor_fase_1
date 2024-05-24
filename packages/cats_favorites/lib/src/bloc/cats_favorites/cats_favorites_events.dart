import 'package:commons/commons.dart';

sealed class CatsFavoritesEvent {
  const CatsFavoritesEvent();
}

final class LoadCatsFavorites extends CatsFavoritesEvent {
  const LoadCatsFavorites();
}

final class DeleteFavoriteCat extends CatsFavoritesEvent {
  final Cat data;

  const DeleteFavoriteCat({
    required this.data,
  });
}

final class EditFavoriteCat extends CatsFavoritesEvent {
  final Cat data;

  const EditFavoriteCat({
    required this.data,
  });
}

final class AddFavoriteCat extends CatsFavoritesEvent {
  const AddFavoriteCat();
}

final class NavigateToDetails extends CatsFavoritesEvent {
  final Cat data;

  const NavigateToDetails({
    required this.data,
  });
}
