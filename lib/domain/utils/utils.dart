class Utils {
  /// Try to cast an objet to a specific type.
  ///
  /// Return a new T objet if success.
  /// Return null if fails.
  T? safeCast<T>({required Object? data}) {
    try {
      return data as T;
    } catch (_) {
      return null;
    }
  }
}
