import '../../../infrastructure/repository/cats_favorites_repository_impl.dart';
import '../../repositories/cats_favorites_repository.dart';
import '../delete_favorite_cat_use_case.dart';

final class DeleteFavoriteCatUseCaseImpl implements DeleteFavoriteCatUseCase {
  final CatsFavoritesRepository _repository;

  const DeleteFavoriteCatUseCaseImpl({CatsFavoritesRepository repository = const CatsFavoritesRepositoryImpl()})
      : _repository = repository;

  @override
  Future invoke({required String id}) async {
    await _repository.delete(id: id);
  }
}
