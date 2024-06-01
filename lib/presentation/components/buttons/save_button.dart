import 'package:flutter/material.dart';

import '../../../domain/utils/constants.dart';
import 'custom_button.dart';

final class SaveButton extends StatelessWidget {
  final double padding = 10;
  final VoidCallback onTap;

  const SaveButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: CustomButton(
        text: Constants.saveButton,
        width: double.infinity,
        onTap: onTap,
      ),
    );
  }
}
