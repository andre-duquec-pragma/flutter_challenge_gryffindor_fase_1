import 'package:flutter/material.dart';

import 'module_app_bar.dart';

final class GenericScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback? onBackPressed;

  const GenericScaffold({
    super.key,
    required this.title,
    required this.body,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context).widget,
      body: SafeArea(
        child: body,
      ),
    );
  }

  ModuleAppBar _buildAppBar(BuildContext context) {
    return ModuleAppBar.build(
      context: context,
      title: title,
      onPressBack: () {
        if (onBackPressed != null) {
          onBackPressed!();
          return;
        }

        Navigator.pop(context);
      },
    );
  }
}
