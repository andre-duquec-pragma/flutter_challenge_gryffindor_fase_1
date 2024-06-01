import '../../models/cats.dart';

sealed class CatDetailsState {
  final Cat data;

  const CatDetailsState({required this.data});
}

final class CatDetailsStarted extends CatDetailsState {
  const CatDetailsStarted({required super.data});
}

final class CatLoadedState extends CatDetailsState {
  const CatLoadedState({required super.data});
}

final class CatDetailErrorState extends CatDetailsState {
  const CatDetailErrorState({required super.data});
}

final class CatDeletedState extends CatDetailsState {
  const CatDeletedState({required super.data});
}
