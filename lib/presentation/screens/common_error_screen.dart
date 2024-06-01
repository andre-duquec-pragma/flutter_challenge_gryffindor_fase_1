import 'package:flutter/material.dart';

import '../../domain/utils/resources.dart';
import '../components/buttons/custom_button.dart';
import '../components/images/generic_asset_image.dart';

class CommonErrorScreen extends StatelessWidget {
  final VoidCallback onBackButtonPressed;
  final Widget? child;

  const CommonErrorScreen({
    super.key,
    required this.onBackButtonPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenericAssetImage(
                  resourceName: Resources.error.value,
                ),
                CustomButton(
                  onTap: onBackButtonPressed,
                ),
                child ?? const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
