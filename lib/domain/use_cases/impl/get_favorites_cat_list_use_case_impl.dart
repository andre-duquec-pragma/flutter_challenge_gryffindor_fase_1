import 'package:commons/commons.dart';
import 'package:get_it/get_it.dart';

import '../get_favorites_cat_list_use_case.dart';

final class GetFavoritesCatListUseCaseImpl implements GetFavoritesCatListUseCase {
  final CatsFavoritesRepository _repository;

  GetFavoritesCatListUseCaseImpl() : _repository = GetIt.I.get();

  @override
  Future<List<Cat>> invoke() async {
    return await _repository.getAll();
  }
}
