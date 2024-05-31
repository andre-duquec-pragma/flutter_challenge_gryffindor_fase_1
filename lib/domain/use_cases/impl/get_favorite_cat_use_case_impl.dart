import 'package:get_it/get_it.dart';

import '../../models/cats.dart';
import '../../repositories/cats_favorites_repository.dart';
import '../get_favorite_cat_use_case.dart';

final class GetFavoritesCatsUseCaseImpl implements GetFavoritesCatUseCase {
  final CatsFavoritesRepository _repository;

  GetFavoritesCatsUseCaseImpl() : _repository = GetIt.I.get();

  @override
  Future<Cat?> invoke({required String id}) async {
    return await _repository.get(id: id);
  }
}
