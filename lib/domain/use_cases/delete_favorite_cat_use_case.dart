abstract class DeleteFavoriteCatUseCase {
  /// To delete a specific cat from local storage.
  ///
  /// [id] A identifier to search the specif cat and remove it.
  Future invoke({required String id});
}
