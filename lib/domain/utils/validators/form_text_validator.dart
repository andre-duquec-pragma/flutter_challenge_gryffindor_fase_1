import '../constants.dart';

abstract class FormTextValidator {
  static const String defaultMessage = Constants.emptyFieldError;

  String? validate(String? text);
}
