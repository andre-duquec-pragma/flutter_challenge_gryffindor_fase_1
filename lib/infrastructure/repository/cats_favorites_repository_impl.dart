import '../../domain/models/cats.dart';
import '../../domain/repositories/cats_favorites_repository.dart';

final class CatsFavoritesRepositoryImpl implements CatsFavoritesRepository {
  static List<Cat> database = [];

  const CatsFavoritesRepositoryImpl();

  @override
  Future<Cat?> get({required String id}) async {
    try {
      return CatsFavoritesRepositoryImpl.database.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Cat>> getAll() async {
    return CatsFavoritesRepositoryImpl.database.toList();
  }

  @override
  Future add({required Cat cat}) async {
    final database = CatsFavoritesRepositoryImpl.database;

    final existingCat = await get(id: cat.id);

    if (existingCat == null) {
      database.add(cat);
      return;
    }

    final index = database.indexOf(existingCat);
    database[index] = cat;
  }

  @override
  Future delete({required String id}) async {
    CatsFavoritesRepositoryImpl.database.removeWhere((item) => item.id == id);
  }
}
