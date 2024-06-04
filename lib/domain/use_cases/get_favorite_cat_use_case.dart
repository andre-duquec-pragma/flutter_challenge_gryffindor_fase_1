import '../entities/cats.dart';

abstract class GetFavoritesCatUseCase {
  Future<Cat?> invoke({required String id});
}
