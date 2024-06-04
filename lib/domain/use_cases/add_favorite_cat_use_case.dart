import '../entities/cats.dart';

abstract class AddFavoriteCatUseCase {
  /// To store a new cat.
  ///
  /// [cat] the specific cat object which will be store.
  Future invoke({required Cat cat});
}
