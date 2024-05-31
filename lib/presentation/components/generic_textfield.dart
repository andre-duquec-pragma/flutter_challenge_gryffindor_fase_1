import 'package:flutter/material.dart';

import '../../domain/utils/validators/form_text_validator.dart';

class GenericTextfield extends StatelessWidget {
  final String initialValue;
  final String placeHolder;
  final int? maxLines;
  final List<FormTextValidator> validators;
  final ValueChanged<String> onChanged;

  const GenericTextfield({
    super.key,
    this.initialValue = "",
    required this.placeHolder,
    this.maxLines = 1,
    this.validators = const [],
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        initialValue: initialValue.isEmpty ? null : initialValue,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: placeHolder,
        ),
        validator: (text) {
          final validations = validators.map((item) => item.validate(text));

          return validations.firstWhere((element) => element != null, orElse: () => null);
        },
        onChanged: onChanged,
      ),
    );
  }
}
