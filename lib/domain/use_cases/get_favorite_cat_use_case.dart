import '../entities/cats.dart';

abstract class GetFavoritesCatUseCase {
  /// To get a specific cat from local storage.
  ///
  /// [id] A identifier to search the specif cat.
  Future<Cat?> invoke({required String id});
}
