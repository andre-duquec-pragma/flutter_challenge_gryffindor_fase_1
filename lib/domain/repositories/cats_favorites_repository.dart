import '../entities/cats.dart';

abstract class CatsFavoritesRepository {
  /// To get a specific cat from local storage.
  ///
  /// [id] A identifier to search the specif cat.
  Future<Cat?> get({required String id});

  /// To get all store cats.
  Future<List<Cat>> getAll();

  /// To store a new cat.
  ///
  /// [cat] the specific cat object which will be store.
  Future add({required Cat cat});

  /// To delete a specific cat from local storage.
  ///
  /// [id] A identifier to search the specif cat and remove it.
  Future delete({required String id});
}
