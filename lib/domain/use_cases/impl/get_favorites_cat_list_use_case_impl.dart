import '../../../infrastructure/repository/cats_favorites_repository_impl.dart';
import '../../models/cats.dart';
import '../../repositories/cats_favorites_repository.dart';
import '../get_favorites_cat_list_use_case.dart';

final class GetFavoritesCatListUseCaseImpl implements GetFavoritesCatListUseCase {
  final CatsFavoritesRepository _repository;

  const GetFavoritesCatListUseCaseImpl({
    CatsFavoritesRepository repository = const CatsFavoritesRepositoryImpl(),
  }) : _repository = repository;

  @override
  Future<List<Cat>> invoke() async {
    return await _repository.getAll();
  }
}
