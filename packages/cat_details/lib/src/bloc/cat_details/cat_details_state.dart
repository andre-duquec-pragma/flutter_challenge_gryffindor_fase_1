import '../../models/cat_detail.dart';

sealed class CatDetailsState {
  final CatDetail details;

  const CatDetailsState({required this.details});

  CatDetailsState copyWith({CatDetail? details});
}

final class CatDetailsStarted extends CatDetailsState {
  const CatDetailsStarted({required super.details});

  @override
  CatDetailsState copyWith({CatDetail? details}) {
    return CatDetailsStarted(
      details: details ?? this.details,
    );
  }
}

final class CatLoadedState extends CatDetailsState {
  const CatLoadedState({required super.details});

  @override
  CatDetailsState copyWith({CatDetail? details}) {
    return CatLoadedState(
      details: details ?? this.details,
    );
  }
}

final class CatDetailErrorState extends CatDetailsState {
  const CatDetailErrorState({required super.details});

  @override
  CatDetailsState copyWith({CatDetail? details}) {
    return CatDetailErrorState(
      details: details ?? this.details,
    );
  }
}

final class CatDeletedState extends CatDetailsState {
  const CatDeletedState({required super.details});

  @override
  CatDetailsState copyWith({CatDetail? details}) {
    return CatDeletedState(
      details: details ?? this.details,
    );
  }
}
