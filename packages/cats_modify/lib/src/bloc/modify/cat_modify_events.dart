sealed class CatModifyEvent {
  const CatModifyEvent();
}

final class SaveEvent extends CatModifyEvent {
  const SaveEvent();
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

final class CatModifyFormTextFieldChange extends CatModifyEvent {
  final CatModifyTextFormField field;
  final String newValue;

  const CatModifyFormTextFieldChange({
    required this.field,
    required this.newValue,
  });
}

final class CatModifyFormNumericFieldChange extends CatModifyEvent {
  final CatModifyNumericFormField field;
  final int newValue;

  const CatModifyFormNumericFieldChange({
    required this.field,
    required this.newValue,
  });
}
