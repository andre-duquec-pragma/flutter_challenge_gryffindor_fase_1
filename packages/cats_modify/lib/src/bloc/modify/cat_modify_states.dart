import 'package:commons/commons.dart';

sealed class CatModifyState {
  final Cat formData;

  const CatModifyState({required this.formData});

  CatModifiedState copyWith({Cat? formData}) {
    return CatModifiedState(
      formData: formData ?? this.formData,
    );
  }
}

final class CatModifyInitialState extends CatModifyState {
  final Cat? cat;

  CatModifyInitialState({this.cat})
      : super(
          formData: Cat(
            id: cat?.id ?? "",
            breedName: cat?.breedName ?? "",
            origin: cat?.origin ?? "",
            affectionLevel: cat?.affectionLevel ?? 0,
            intelligence: cat?.intelligence ?? 0,
            imageId: cat?.imageId ?? "",
            description: cat?.description ?? "",
          ),
        );
}

final class CatModifiedState extends CatModifyState {
  const CatModifiedState({required super.formData});
}

final class CatModifyFinished extends CatModifyState {
  const CatModifyFinished({required super.formData});
}

final class CatModifyError extends CatModifiedState {
  final String message;

  const CatModifyError({
    required super.formData,
    required this.message,
  });
}
