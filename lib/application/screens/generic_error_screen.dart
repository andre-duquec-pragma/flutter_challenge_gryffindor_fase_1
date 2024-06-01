import 'package:flutter/material.dart';

import 'common_error_screen.dart';

class GenericErrorScreen extends StatelessWidget {
  final VoidCallback? onBackButtonPressed;

  const GenericErrorScreen({
    super.key,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CommonErrorScreen(
      onBackButtonPressed: () {
        if (onBackButtonPressed != null) {
          onBackButtonPressed!();
          return;
        }

        Navigator.pop(context);
      },
    );
  }
}
