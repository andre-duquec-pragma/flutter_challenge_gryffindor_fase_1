import 'package:cats_modify/src/bloc/modify/cat_modify_events.dart';
import 'package:cats_modify/src/ui/components/cat_image_drop_down_button.dart';
import 'package:cats_modify/src/ui/components/save_button.dart';
import 'package:commons/commons.dart';
import 'package:commons_ui/commons_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modular_router/modular_router.dart';

import '../../bloc/modify/cat_modify_bloc.dart';
import '../../bloc/modify/cat_modify_states.dart';
import '../../bloc/router/cat_modify_router_bloc.dart';
import '../../utils/constants.dart';

class CatModifyScreen extends StatelessWidget {
  final Cat? cat;

  final _formKey = GlobalKey<FormState>();

  CatModifyScreen({
    super.key,
    this.cat,
  });

  @override
  Widget build(BuildContext context) {
    return GenericScaffold<CatModifyRouterBloc>(
      routerActionHandlerTypeOnBack: RouterActionHandlerType.external,
      title: _buildTitle(),
      body: _buildScreen(context),
    );
  }

  String _buildTitle() {
    return cat == null ? Constants.addCat : Constants.editCat;
  }

  Widget _buildScreen(BuildContext context) {
    return BlocProvider(
      create: (_) => CatModifyBloc(cat: cat),
      child: BlocListener<CatModifyBloc, CatModifyState>(
        listener: _listener,
        child: BlocBuilder<CatModifyBloc, CatModifyState>(
          builder: _builder,
        ),
      ),
    );
  }

  void _listener(BuildContext context, CatModifyState state) {
    switch (state) {
      case CatModifyFinished():
        showSuccess(context);
      case CatModifyError(message: final message):
        showError(context, message);
      default:
        break;
    }
  }

  Widget _builder(BuildContext context, CatModifyState state) {
    return _buildBody(context, state);
  }

  Widget _buildBody(BuildContext context, CatModifyState state) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formKey,
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
            _addTextChangeEvent(context, CatModifyTextFormField.breedName, value);
          },
        ),
        GenericTextfield(
          initialValue: state.formData.origin,
          placeHolder: Constants.originPlaceHolder,
          validators: const [FormEmptyTextValidator()],
          onChanged: (value) {
            _addTextChangeEvent(context, CatModifyTextFormField.origin, value);
          },
        ),
        GenericTextfield(
          initialValue: state.formData.description,
          placeHolder: Constants.descriptionPlaceHolder,
          validators: const [FormEmptyTextValidator()],
          onChanged: (value) {
            _addTextChangeEvent(context, CatModifyTextFormField.description, value);
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
            _addNumChangeEvent(context, CatModifyNumericFormField.intelligence, value);
          },
        ),
        GenericSlider(
          title: Constants.affectionPlaceHolder,
          value: state.formData.affectionLevel.toDouble(),
          onChanged: (value) {
            _addNumChangeEvent(context, CatModifyNumericFormField.affectionLevel, value);
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return SaveButton(
      onTap: () {
        if (!_formKey.currentState!.validate()) {
          return;
        }

        const event = SaveEvent();
        context.read<CatModifyBloc>().add(event);
      },
    );
  }

  Widget _buildDropDownButtons(BuildContext context, CatModifyState state) {
    final resources = [
      CommonResources.cat1,
      CommonResources.cat2,
      CommonResources.cat3,
      CommonResources.cat4,
      CommonResources.cat5,
      CommonResources.cat6,
      CommonResources.cat7,
    ];

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        CatImageDropDownButton(
          current: state.formData.imageId,
          items: resources,
          onChanged: (image) {
            if (image == null) {
              return;
            }

            _addTextChangeEvent(context, CatModifyTextFormField.imageId, image.name);
          },
        ),
      ],
    );
  }

  void _addNumChangeEvent(
    BuildContext context,
    CatModifyNumericFormField field,
    double value,
  ) {
    final event = CatModifyFormNumericFieldChange(
      field: field,
      newValue: value.toInt(),
    );

    context.read<CatModifyBloc>().add(event);
  }

  void _addTextChangeEvent(
    BuildContext context,
    CatModifyTextFormField field,
    String value,
  ) {
    final event = CatModifyFormTextFieldChange(
      field: field,
      newValue: value,
    );

    context.read<CatModifyBloc>().add(event);
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
    final bloc = context.read<CatModifyRouterBloc>();

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
      const event = PopRequest(type: RouterActionHandlerType.external);
      bloc.add(event);
    });
  }
}
