import '../entities/cats.dart';

abstract class GetFavoritesCatListUseCase {
  /// To get all store cats.
  Future<List<Cat>> invoke();
}
