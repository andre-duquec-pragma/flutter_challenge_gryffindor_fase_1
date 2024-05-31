import 'form_text_validator.dart';

final class FormEmptyTextValidator implements FormTextValidator {
  final String? message;

  const FormEmptyTextValidator({this.message});

  @override
  String? validate(String? text) {
    if (text == null || text.isEmpty) {
      return message ?? FormTextValidator.defaultMessage;
    }

    return null;
  }
}
