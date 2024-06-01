import '../../../infrastructure/repository/cats_favorites_repository_impl.dart';
import '../../models/cats.dart';
import '../../repositories/cats_favorites_repository.dart';
import '../get_favorite_cat_use_case.dart';

final class GetFavoritesCatsUseCaseImpl implements GetFavoritesCatUseCase {
  final CatsFavoritesRepository _repository;

  const GetFavoritesCatsUseCaseImpl({CatsFavoritesRepository repository = const CatsFavoritesRepositoryImpl()})
      : _repository = repository;

  @override
  Future<Cat?> invoke({required String id}) async {
    return await _repository.get(id: id);
  }
}
