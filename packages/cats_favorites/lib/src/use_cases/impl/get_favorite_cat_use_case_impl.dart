import 'package:commons/commons.dart';
import 'package:get_it/get_it.dart';

final class GetFavoritesCatsUseCaseImpl implements GetFavoritesCatUseCase {
  final CatsFavoritesRepository _repository;

  GetFavoritesCatsUseCaseImpl() : _repository = GetIt.I.get();

  @override
  Future<Cat?> invoke({required String id}) async {
    return await _repository.get(id: id);
  }
}
