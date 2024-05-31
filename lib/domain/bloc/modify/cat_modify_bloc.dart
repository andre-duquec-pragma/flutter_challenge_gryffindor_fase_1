import 'dart:async';

import 'package:commons/commons.dart';
import 'package:get_it/get_it.dart';

import '../../utils/constants.dart';
import 'cat_modify_states.dart';

final class CatModifyBloc {
  final AddFavoriteCatUseCase _addFavoriteCatUseCase;

  final Cat? cat;

  final StreamController<CatModifyState> stream = StreamController();

  CatModifyBloc({
    this.cat,
  })  : _addFavoriteCatUseCase = GetIt.I.get(),
        super() {
    stream.add(CatModifyInitialState(cat: cat));
  }

  Future onModifyFormTextFieldChange(
    final CatModifyTextFormField field,
    final String newValue,
  ) async {
    final Cat newFormData;
    final state = await stream.stream.last;

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

    stream.add(state.copyWith(formData: newFormData));
  }

  Future onCatModifyFormNumericFieldChange(
    final CatModifyNumericFormField field,
    final int newValue,
  ) async {
    final state = await stream.stream.last;
    final Cat newFormData;

    switch (field) {
      case CatModifyNumericFormField.intelligence:
        newFormData = state.formData.copyWith(intelligence: newValue);
      case CatModifyNumericFormField.affectionLevel:
        newFormData = state.formData.copyWith(affectionLevel: newValue);
    }

    stream.add(state.copyWith(formData: newFormData));
  }

  Future save() async {
    final state = await stream.stream.last;

    try {
      final formData = state.formData;

      if (formData.intelligence == 0 || formData.affectionLevel == 0) {
        final newState = CatModifyError(
          formData: formData,
          message: "All values must be greater than 0",
        );
        stream.add(newState);
        return;
      }

      await _addFavoriteCatUseCase.invoke(cat: formData);
      stream.add(CatModifyFinished(formData: state.formData));
    } catch (_) {
      final newState = CatModifyError(
        formData: state.formData,
        message: Constants.genericErrorMessage,
      );
      stream.add(newState);
    }
  }
}
