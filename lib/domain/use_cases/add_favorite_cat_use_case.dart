import '../entities/cats.dart';

abstract class AddFavoriteCatUseCase {
  Future invoke({required Cat cat});
}
