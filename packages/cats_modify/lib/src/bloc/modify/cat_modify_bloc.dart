import 'package:commons/commons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../utils/constants.dart';
import 'cat_modify_events.dart';
import 'cat_modify_states.dart';

final class CatModifyBloc extends Bloc<CatModifyEvent, CatModifyState> {
  final AddFavoriteCatUseCase _addFavoriteCatUseCase;

  final Cat? cat;

  CatModifyBloc({
    this.cat,
  })  : _addFavoriteCatUseCase = GetIt.I.get(),
        super(CatModifyInitialState(cat: cat)) {
    setUp();
  }

  void setUp() {
    on<SaveEvent>(_onSaveEvent);
    on<CatModifyFormTextFieldChange>(_onCatModifyFormTextFieldChange);
    on<CatModifyFormNumericFieldChange>(_onCatModifyFormNumericFieldChange);
  }

  void _onCatModifyFormTextFieldChange(
    CatModifyFormTextFieldChange event,
    Emitter<CatModifyState> emit,
  ) {
    final Cat newFormData;

    switch (event.field) {
      case CatModifyTextFormField.breedName:
        newFormData = state.formData.copyWith(breedName: event.newValue);
      case CatModifyTextFormField.description:
        newFormData = state.formData.copyWith(description: event.newValue);
      case CatModifyTextFormField.imageId:
        newFormData = state.formData.copyWith(imageId: event.newValue);
      case CatModifyTextFormField.origin:
        newFormData = state.formData.copyWith(origin: event.newValue);
    }

    emit(state.copyWith(formData: newFormData));
  }

  void _onCatModifyFormNumericFieldChange(
    CatModifyFormNumericFieldChange event,
    Emitter<CatModifyState> emit,
  ) {
    final Cat newFormData;

    switch (event.field) {
      case CatModifyNumericFormField.intelligence:
        newFormData = state.formData.copyWith(intelligence: event.newValue);
      case CatModifyNumericFormField.affectionLevel:
        newFormData = state.formData.copyWith(affectionLevel: event.newValue);
    }

    emit(state.copyWith(formData: newFormData));
  }

  Future _onSaveEvent(SaveEvent event, Emitter<CatModifyState> emit) async {
    try {
      final formData = state.formData;

      if (formData.intelligence == 0 || formData.affectionLevel == 0) {
        final newState = CatModifyError(
          formData: formData,
          message: "All values must be greater than 0",
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
