import 'generic_textfield.dart';

class GenericTextArea extends GenericTextfield {
  const GenericTextArea({
    super.key,
    super.initialValue,
    required super.placeHolder,
    super.validators,
    required super.onChanged,
  }) : super(maxLines: null);
}
