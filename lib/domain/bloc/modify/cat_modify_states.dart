import '../../models/cats.dart';

sealed class CatModifyState {
  final Cat formData;

  const CatModifyState({required this.formData});

  CatModifyState copyWith({Cat? formData});
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

  @override
  CatModifyState copyWith({Cat? formData}) {
    return CatModifyInitialState(
      cat: formData ?? this.formData,
    );
  }
}

final class CatModifiedState extends CatModifyState {
  const CatModifiedState({required super.formData});

  @override
  CatModifyState copyWith({Cat? formData}) {
    return CatModifiedState(
      formData: formData ?? this.formData,
    );
  }
}

final class CatModifyFinished extends CatModifyState {
  const CatModifyFinished({required super.formData});

  @override
  CatModifyState copyWith({Cat? formData}) {
    return CatModifyFinished(
      formData: formData ?? this.formData,
    );
  }
}

final class CatModifyError extends CatModifyState {
  final String message;

  const CatModifyError({
    required super.formData,
    required this.message,
  });

  @override
  CatModifyState copyWith({
    Cat? formData,
    String? message,
  }) {
    return CatModifyError(
      formData: formData ?? this.formData,
      message: message ?? this.message,
    );
  }
}

enum CatModifyTextFormField {
  breedName,
  origin,
  description,
  imageId;
}

enum CatModifyNumericFormField {
  intelligence,
  affectionLevel,
}
