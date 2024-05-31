import 'package:get_it/get_it.dart';

import '../../repositories/cats_favorites_repository.dart';
import '../delete_favorite_cat_use_case.dart';

final class DeleteFavoriteCatUseCaseImpl implements DeleteFavoriteCatUseCase {
  final CatsFavoritesRepository _repository;

  DeleteFavoriteCatUseCaseImpl() : _repository = GetIt.I.get();

  @override
  Future invoke({required String id}) async {
    await _repository.delete(id: id);
  }
}
