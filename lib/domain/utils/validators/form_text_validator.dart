import '../constants.dart';

abstract class FormTextValidator {
  static const String defaultMessage = Constants.emptyFieldError;

  /// Validate a string and returns an error message in case something fails.
  String? validate(String? text);
}
