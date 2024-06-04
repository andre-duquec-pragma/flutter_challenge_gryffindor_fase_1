import '../../entities/cats.dart';
import '../../use_cases/add_favorite_cat_use_case.dart';
import '../../use_cases/impl/add_favorite_cat_use_case_impl.dart';
import '../../utils/constants.dart';
import '../bloc.dart';
import 'cat_modify_states.dart';

final class CatModifyBloc extends Bloc<CatModifyState> {
  final AddFavoriteCatUseCase _addFavoriteCatUseCase;

  final Cat? cat;

  CatModifyBloc({
    AddFavoriteCatUseCase addFavoriteCatUseCase = const AddFavoriteCatUseCaseImpl(),
    this.cat,
  })  : _addFavoriteCatUseCase = addFavoriteCatUseCase,
        super(initialState: CatModifyInitialState(cat: cat));

  /// To change state when a text field from form changes.
  ///
  /// [field] to identify the text field which suffered some change.
  /// [newValue] the value to update in current form data.
  ///
  /// Emit a state change to [CatModifiedState].
  Future onModifyFormTextFieldChange(
    final CatModifyTextFormField field,
    final String newValue,
  ) async {
    final Cat newFormData;

    switch (field) {
      case CatModifyTextFormField.breedName:
        newFormData = state.formData.copyWith(breedName: newValue);
      case CatModifyTextFormField.description:
        newFormData = state.formData.copyWith(description: newValue);
      case CatModifyTextFormField.imageId:
        newFormData = state.formData.copyWith(imageId: newValue);
      case CatModifyTextFormField.origin:
        newFormData = state.formData.copyWith(origin: newValue);
    }

    final newState = CatModifiedState(formData: newFormData);
    emit(newState);
  }

  /// To change state when a numeric field from form changes.
  ///
  /// [field] to identify the numeric field which suffered some change.
  /// [newValue] the value to update in current form data.
  ///
  /// Emit a state change to [CatModifiedState].
  Future onCatModifyFormNumericFieldChange(
    final CatModifyNumericFormField field,
    final int newValue,
  ) async {
    final Cat newFormData;

    switch (field) {
      case CatModifyNumericFormField.intelligence:
        newFormData = state.formData.copyWith(intelligence: newValue);
      case CatModifyNumericFormField.affectionLevel:
        newFormData = state.formData.copyWith(affectionLevel: newValue);
    }

    final newState = CatModifiedState(formData: newFormData);
    emit(newState);
  }

  /// To save current form data in storage.
  ///
  /// Uses current form data to invoke a use case which perform all the mapping and storage process.
  /// When form data is invalid emit a state change to [CatModifyError].
  /// Otherwise invoke the storage use case and if success emit a state change to [CarModifyFinished].
  Future save() async {
    try {
      final formData = state.formData;

      if (formData.intelligence == 0 || formData.affectionLevel == 0) {
        final newState = CatModifyError(
          formData: formData,
          message: Constants.slidersError,
        );
        emit(newState);
        return;
      }

      await _addFavoriteCatUseCase.invoke(cat: formData);
      emit(CatModifyFinished(formData: state.formData));
    } catch (_) {
      final newState = CatModifyError(
        formData: state.formData,
        message: Constants.genericErrorMessage,
      );
      emit(newState);
    }
  }
}
