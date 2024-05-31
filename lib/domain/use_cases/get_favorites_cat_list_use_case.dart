import '../models/cats.dart';

abstract class GetFavoritesCatListUseCase {
  Future<List<Cat>> invoke();
}
