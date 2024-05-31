import 'package:get_it/get_it.dart';

import '../../models/cats.dart';
import '../../repositories/cats_favorites_repository.dart';
import '../add_favorite_cat_use_case.dart';

final class AddFavoriteCatUseCaseImpl implements AddFavoriteCatUseCase {
  final CatsFavoritesRepository _repository;

  AddFavoriteCatUseCaseImpl() : _repository = GetIt.I.get();

  @override
  Future invoke({required Cat cat}) async {
    String id = cat.id;

    if (id.isEmpty) {
      id = DateTime.now().microsecondsSinceEpoch.toString();
    }

    final newCat = cat.copyWith(id: id);
    await _repository.add(cat: newCat);
  }
}
