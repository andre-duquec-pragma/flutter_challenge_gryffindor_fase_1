import 'package:flutter/material.dart';
import 'package:flutter_challenge_gryffindor_fase_1/presentation/components/buttons/cat_resources_drop_down_button.dart';

import '../../domain/bloc/cat_modify/cat_modify_bloc.dart';
import '../../domain/bloc/cat_modify/cat_modify_states.dart';
import '../../domain/models/cats.dart';
import '../../domain/utils/constants.dart';
import '../../domain/utils/validators/form_empty_text_validator.dart';
import '../components/containers/generic_scaffold.dart';
import '../components/bars/generic_slider.dart';
import '../components/texts/generic_textfield.dart';
import '../components/buttons/save_button.dart';
import 'generic_error_screen.dart';

class CatModifyScreen extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  final CatModifyBloc bloc;

  CatModifyScreen({
    super.key,
    Cat? cat,
  }) : bloc = CatModifyBloc(cat: cat);

  @override
  State<StatefulWidget> createState() => _CatModifyScreenState();
}

class _CatModifyScreenState extends State<CatModifyScreen> {
  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GenericScaffold(
      title: _buildTitle(),
      body: StreamBuilder(
        stream: widget.bloc.stateStream,
        builder: _builder,
      ),
    );
  }

  String _buildTitle() {
    return widget.bloc.cat == null ? Constants.addCat : Constants.editCat;
  }

  Widget _builder(BuildContext context, AsyncSnapshot<CatModifyState> snapshot) {
    if (snapshot.data == null) {
      return const GenericErrorScreen();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (snapshot.data) {
        case CatModifyFinished():
          showSuccess(context);
        case CatModifyError(message: final message):
          showError(context, message);
        default:
          break;
      }
    });

    return _buildBody(context, snapshot.data!);
  }

  Widget _buildBody(BuildContext context, CatModifyState state) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                _buildTextFields(context, state),
                _buildSliders(context, state),
                _buildDropDownButtons(context, state),
                const SizedBox(height: 10),
                _buildSaveButton(context),
              ],
            ),
          )),
    );
  }

  Widget _buildTextFields(BuildContext context, CatModifyState state) {
    return Column(
      children: [
        GenericTextfield(
          initialValue: state.formData.breedName,
          placeHolder: Constants.breedPlaceHolder,
          validators: const [FormEmptyTextValidator()],
          onChanged: (value) {
            widget.bloc.onModifyFormTextFieldChange(CatModifyTextFormField.breedName, value);
          },
        ),
        GenericTextfield(
          initialValue: state.formData.origin,
          placeHolder: Constants.originPlaceHolder,
          validators: const [FormEmptyTextValidator()],
          onChanged: (value) {
            widget.bloc.onModifyFormTextFieldChange(CatModifyTextFormField.origin, value);
          },
        ),
        GenericTextfield(
          initialValue: state.formData.description,
          placeHolder: Constants.descriptionPlaceHolder,
          validators: const [FormEmptyTextValidator()],
          onChanged: (value) {
            widget.bloc.onModifyFormTextFieldChange(CatModifyTextFormField.description, value);
          },
        ),
      ],
    );
  }

  Widget _buildSliders(BuildContext context, CatModifyState state) {
    return Column(
      children: [
        GenericSlider(
          title: Constants.intelligentPlaceHolder,
          value: state.formData.intelligence.toDouble(),
          onChanged: (value) {
            widget.bloc.onCatModifyFormNumericFieldChange(CatModifyNumericFormField.intelligence, value.toInt());
          },
        ),
        GenericSlider(
          title: Constants.affectionPlaceHolder,
          value: state.formData.affectionLevel.toDouble(),
          onChanged: (value) {
            widget.bloc.onCatModifyFormNumericFieldChange(CatModifyNumericFormField.affectionLevel, value.toInt());
          },
        ),
      ],
    );
  }

  Widget _buildDropDownButtons(BuildContext context, CatModifyState state) {
    return CatResourcesDropDownButton(
      current: state.formData.imageId,
      onChanged: (image) {
        widget.bloc.onModifyFormTextFieldChange(CatModifyTextFormField.imageId, image);
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return SaveButton(
      onTap: () {
        if (!widget.formKey.currentState!.validate()) {
          return;
        }

        widget.bloc.save();
      },
    );
  }

  void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Constants.error),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text(Constants.okButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Constants.catSaveSuccess),
          actions: [
            TextButton(
              child: const Text(Constants.doneButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {
      Navigator.pop(context);
    });
  }
}
